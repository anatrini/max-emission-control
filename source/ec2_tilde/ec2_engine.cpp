/**
 * ec2_engine.cpp
 * Implementation of main granular synthesis engine
 */

#include "ec2_engine.h"
#include <iostream>
#include <cmath>

namespace ec2 {

GranularEngine::GranularEngine(size_t maxVoices)
  : mVoicePool(maxVoices),
    mScheduler(DEFAULT_SAMPLE_RATE),
    mDeviationRng(std::random_device{}()) {

  mAudioBuffers.resize(1);  // Start with one buffer slot
  mScanner.setSamplingRate(DEFAULT_SAMPLE_RATE);

  // Initialize LFOs (Phase 9)
  for (int i = 0; i < MAX_LFOS; ++i) {
    mLFOs[i].setSampleRate(DEFAULT_SAMPLE_RATE);
    mLFOValues[i] = 0.0f;
  }
}

void GranularEngine::initialize(float sampleRate) {
  mSampleRate = sampleRate;
  mScheduler.setSamplingRate(sampleRate);
  mScanner.setSamplingRate(sampleRate);

  // Configure scheduler with default parameters
  mScheduler.configure(mParams.grainRate, mParams.async, mParams.intermittency);
}

void GranularEngine::setSampleRate(float sampleRate) {
  if (mSampleRate != sampleRate) {
    mSampleRate = sampleRate;
    mScheduler.setSamplingRate(sampleRate);
    mScanner.setSamplingRate(sampleRate);

    // Update LFO sample rates (Phase 9)
    for (int i = 0; i < MAX_LFOS; ++i) {
      mLFOs[i].setSampleRate(sampleRate);
    }
  }
}

void GranularEngine::setAudioBuffer(std::shared_ptr<AudioBuffer<float>> buffer, int index) {
  // Spinlock: protects mPendingBuffers from concurrent access (main vs audio thread).
  // The critical section is tiny (pointer copy), so spinning is acceptable.
  while (mBufferLock.test_and_set(std::memory_order_acquire)) {}

  if (index >= static_cast<int>(mPendingBuffers.size())) {
    mPendingBuffers.resize(index + 1);
  }
  mPendingBuffers[index] = buffer;

  mBufferLock.clear(std::memory_order_release);
  mBufferUpdatePending.store(true, std::memory_order_release);
}

std::shared_ptr<AudioBuffer<float>> GranularEngine::getAudioBuffer(int index) {
  // Caller is responsible for thread safety: called from audio thread only during normal operation.
  if (index < 0 || index >= static_cast<int>(mAudioBuffers.size())) {
    return nullptr;
  }
  return mAudioBuffers[index];
}

void GranularEngine::updateParameters(const SynthParameters& params) {
  mParams = params;

  // Update scheduler
  mScheduler.configure(params.grainRate, params.async, params.intermittency);
  mScheduler.setPolyStream(params.streamType, params.streams);

  // Update spatial allocator (Phase 5)
  mSpatialAllocator.updateParameters(params.spatial);
}

void GranularEngine::process(float** outBuffers, int numChannels, int numFrames) {
  // Delegate to processWithSignals with no signal inputs
  processWithSignals(outBuffers, numChannels, numFrames, nullptr, nullptr, nullptr);
}

void GranularEngine::processWithSignals(float** outBuffers, int numChannels, int numFrames,
                                       const float* scanSignal, const float* rateSignal,
                                       const float* playbackSignal) {
  // Swap any pending buffers in (submitted from main thread via setAudioBuffer).
  // try_lock: if spinlock is currently held by setAudioBuffer, skip this cycle.
  if (mBufferUpdatePending.load(std::memory_order_acquire)) {
    if (!mBufferLock.test_and_set(std::memory_order_acquire)) {
      for (size_t i = 0; i < mPendingBuffers.size(); ++i) {
        if (mPendingBuffers[i]) {
          if (i >= mAudioBuffers.size()) mAudioBuffers.resize(i + 1);
          mAudioBuffers[i] = std::move(mPendingBuffers[i]);
        }
      }
      mBufferUpdatePending.store(false, std::memory_order_release);
      mBufferLock.clear(std::memory_order_release);
    }
  }

  // Process LFOs for the entire buffer duration (FIX: advance by numFrames, not 1)
  processLFOs(numFrames);

  // Apply modulation to control-rate parameters (Phase 9)
  // If signal inputs provided, average them for control-rate params (Phase 12)
  float modulatedGrainRate;
  if (rateSignal) {
    // Average the grain rate signal over the buffer
    float avg = 0.0f;
    for (int i = 0; i < numFrames; ++i) {
      avg += rateSignal[i];
    }
    modulatedGrainRate = std::max(0.1f, std::min(avg / numFrames, 500.0f));
  } else {
    modulatedGrainRate = applyModulation(mParams.grainRate, mParams.modGrainRate, 0.1f, 500.0f);
  }

  // Apply deviation to scheduler parameters (per-buffer variation)
  modulatedGrainRate = applyDeviation(modulatedGrainRate, mParams.grainRateDeviation, 0.1f, 500.0f);

  float modulatedAsync = applyModulation(mParams.async, mParams.modAsync, 0.0f, 1.0f);
  modulatedAsync = applyDeviation(modulatedAsync, mParams.asyncDeviation, 0.0f, 1.0f);

  float modulatedIntermittency = applyModulation(mParams.intermittency, mParams.modIntermittency, 0.0f, 1.0f);
  modulatedIntermittency = applyDeviation(modulatedIntermittency, mParams.intermittencyDeviation, 0.0f, 1.0f);

  float modulatedStreamsF = applyModulation(static_cast<float>(mParams.streams), mParams.modStreams, 1.0f, 20.0f);
  modulatedStreamsF = applyDeviation(modulatedStreamsF, mParams.streamsDeviation, 1.0f, 20.0f);
  int modulatedStreams = static_cast<int>(modulatedStreamsF);

  // Update scheduler with modulated parameters
  mScheduler.configure(modulatedGrainRate, modulatedAsync, modulatedIntermittency);
  mScheduler.setPolyStream(mParams.streamType, modulatedStreams);

  // Inform spatial allocator of current stream count for stream-aware routing
  mSpatialAllocator.setNumActiveStreams(modulatedStreams);

  // Apply modulation to soundFile (matches original EC2 ecSynth.cpp:201-204)
  // Round to nearest integer for buffer index selection
  float modulatedSoundFileF = applyModulation(static_cast<float>(mParams.soundFile),
                                              mParams.modSoundFile, 0.0f, 15.0f);
  int modulatedSoundFile = static_cast<int>(modulatedSoundFileF + 0.5f);  // Round to nearest
  modulatedSoundFile = std::max(0, std::min(15, modulatedSoundFile));  // Clamp to valid range

  // Safety check - need at least one buffer
  auto currentBuffer = getAudioBuffer(modulatedSoundFile);
  if (!currentBuffer || currentBuffer->size == 0) {
    // Fallback to base soundFile if modulated index has no buffer
    currentBuffer = getAudioBuffer(mParams.soundFile);
    if (!currentBuffer || currentBuffer->size == 0) {
      return;  // No audio to process
    }
    modulatedSoundFile = mParams.soundFile;  // Use fallback
  }

  // Apply modulation and deviation to scan parameters
  // Note: scanBegin deviation is applied per-grain (to individual grain positions)
  float modulatedScanBegin = applyModulation(mParams.scanBegin, mParams.modScanBegin, 0.0f, 1.0f);

  float modulatedScanRange = applyModulation(mParams.scanRange, mParams.modScanRange, -1.0f, 1.0f);
  modulatedScanRange = applyDeviation(modulatedScanRange, mParams.scanRangeDeviation, -1.0f, 1.0f);

  float modulatedScanSpeed = applyModulation(mParams.scanSpeed, mParams.modScanSpeed, -32.0f, 32.0f);
  modulatedScanSpeed = applyDeviation(modulatedScanSpeed, mParams.scanSpeedDeviation, -32.0f, 32.0f);

  // SCANNER LOGIC (EC2 original algorithm from ecSynth.cpp:113-169)
  // Update scan index from Line object (moves continuously)
  if (!scanSignal) {
    mCurrentScanIndex = mScanner();
  }

  float frames = static_cast<float>(currentBuffer->frames);
  float start, end;

  // Detect if we need a hard reset of the scanner
  bool needsHardReset =
    mScannerNeedsReset ||  // First run
    (mPrevSoundFile != modulatedSoundFile) ||  // Buffer changed (including via LFO modulation)
    (mCurrentScanIndex == mScanner.getTarget()) ||  // Scanner reached target
    (modulatedScanBegin != mPrevScanBegin);  // ScanBegin changed (always hard reset in ec2~)

  if (needsHardReset) {
    mScannerNeedsReset = false;

    // Calculate start and end based on scanSpeed and scanRange signs
    // EC2 logic: if speed and range have same sign, go forward from begin
    //            if opposite signs, go backward
    if ((modulatedScanSpeed >= 0 && modulatedScanRange >= 0) ||
        (modulatedScanSpeed < 0 && modulatedScanRange < 0)) {
      start = modulatedScanBegin * frames;
      end = start + (frames * modulatedScanRange);
    } else {
      start = (modulatedScanBegin + modulatedScanRange) * frames;
      end = modulatedScanBegin * frames;
    }

    // Set scanner to move from start to end
    // Duration = distance / (sampleRate * speed)
    float duration = std::abs(end - start) / (mSampleRate * std::abs(modulatedScanSpeed));
    mScanner.set(start, end, duration);
    mCurrentScanIndex = start;
  }
  // On-the-fly adjustments when parameters change
  else if (modulatedScanRange != mPrevScanRange ||
           modulatedScanSpeed != mPrevScanSpeed) {

    start = mScanner.getValue();

    // Validate start position is within new range
    if (modulatedScanRange >= 0) {
      if ((start > (modulatedScanBegin + modulatedScanRange) * frames) ||
          start < modulatedScanBegin * frames) {
        start = modulatedScanBegin * frames;
      }
    } else {
      if ((start < (modulatedScanBegin + modulatedScanRange) * frames) ||
          (start > modulatedScanBegin * frames)) {
        start = (modulatedScanBegin + modulatedScanRange) * frames;
      }
    }

    // Calculate new end position
    if ((modulatedScanSpeed >= 0 && modulatedScanRange >= 0) ||
        (modulatedScanSpeed < 0 && modulatedScanRange < 0)) {
      end = (modulatedScanBegin * frames) + (frames * modulatedScanRange);
    } else {
      end = (modulatedScanBegin * frames);
    }

    // Update scanner with new trajectory
    float duration = std::abs(end - start) / (mSampleRate * std::abs(modulatedScanSpeed));
    mScanner.set(start, end, duration);
  }

  // Wrapping logic - keep index within buffer bounds
  if (mCurrentScanIndex >= frames || mCurrentScanIndex < 0) {
    mCurrentScanIndex = std::fmod(mCurrentScanIndex, frames);
    if (mCurrentScanIndex < 0) {
      mCurrentScanIndex += frames;
    }
  }

  // Store current values for next iteration
  mPrevScanBegin = modulatedScanBegin;
  mPrevScanRange = modulatedScanRange;
  mPrevScanSpeed = modulatedScanSpeed;
  mPrevSoundFile = modulatedSoundFile;  // Track modulated value for change detection
  // END OF SCANNER LOGIC

  // Process frame by frame
  for (int frame = 0; frame < numFrames; ++frame) {
    // How many grains to emit this frame (0 for SYNCHRONOUS/SEQUENCED, 0-N for ASYNCHRONOUS)
    int numTriggers = mScheduler.triggerCount();

    for (int t = 0; t < numTriggers; ++t) {
      // Update scan position from signal input if provided
      if (scanSignal) {
        float scanPos = std::max(0.0f, std::min(scanSignal[frame], 1.0f));
        mCurrentScanIndex = scanPos * frames;
      }

      // Apply statistical deviation to scan position
      float deviatedScanIndex = mCurrentScanIndex;
      if (mParams.scanBeginDeviation > 0.0f) {
        float normalizedScan = mCurrentScanIndex / currentBuffer->frames;
        normalizedScan = applyDeviation(normalizedScan, mParams.scanBeginDeviation, 0.0f, 1.0f);
        deviatedScanIndex = normalizedScan * currentBuffer->frames;
      }

      Grain* grain = mVoicePool.getFreeVoice();

      if (grain) {
        // Create grain metadata for spatial allocator
        GrainMetadata metadata;
        metadata.emissionTime = mGrainEmissionTime;

        // Get playback rate for this grain (Phase 12: use signal if provided)
        float grainPlaybackRate;
        if (playbackSignal) {
          grainPlaybackRate = std::max(-32.0f, std::min(playbackSignal[frame], 32.0f));
        } else {
          grainPlaybackRate = applyModulation(mParams.playbackRate, mParams.modPlaybackRate, -32.0f, 32.0f);
        }

        metadata.pitch = grainPlaybackRate * 440.0f;
        metadata.spectralCentroid = mParams.filterFreq;
        // Assign stream ID and advance the cyclic counter (0..streams-1).
        // SYNCHRONOUS: cycles through N stream IDs at N× rate.
        // ASYNCHRONOUS: multiple triggers per frame each get the next ID.
        // SEQUENCED: single trigger per period, ID cycles at base rate.
        metadata.streamId = mCurrentStreamId;
        mCurrentStreamId = (mCurrentStreamId + 1) % std::max(1, modulatedStreams);
        metadata.grainIndex = mGrainCounter++;

        // Get spatial allocation (multichannel panning gains)
        PanningVector panning = mSpatialAllocator.allocate(metadata);

        // Apply modulation to other parameters (Phase 9)
        float modulatedDuration = applyModulation(mParams.grainDuration, mParams.modGrainDuration, 1.0f, 10000.0f);
        float modulatedEnvelope = applyModulation(mParams.envelope, mParams.modEnvelope, 0.0f, 1.0f);
        float modulatedPan = applyModulation(mParams.pan, mParams.modPan, -1.0f, 1.0f);
        float modulatedAmplitude = applyModulation(mParams.amplitude, mParams.modAmplitude, -180.0f, 48.0f);
        float modulatedFilterFreq = applyModulation(mParams.filterFreq, mParams.modFilterFreq, 20.0f, 24000.0f);
        float modulatedResonance = applyModulation(mParams.resonance, mParams.modResonance, 0.0f, 1.0f);

        // Apply statistical deviation (Curtis Roads: stochastic grain clouds)
        grainPlaybackRate = applyDeviation(grainPlaybackRate, mParams.playbackDeviation, -32.0f, 32.0f);
        modulatedDuration = applyDeviation(modulatedDuration, mParams.durationDeviation, 0.046f, 10000.0f);
        modulatedEnvelope = applyDeviation(modulatedEnvelope, mParams.envelopeDeviation, 0.0f, 1.0f);
        modulatedPan = applyDeviation(modulatedPan, mParams.panDeviation, -1.0f, 1.0f);
        modulatedAmplitude = applyDeviation(modulatedAmplitude, mParams.amplitudeDeviation, -180.0f, 48.0f);
        modulatedFilterFreq = applyDeviation(modulatedFilterFreq, mParams.filterFreqDeviation, 20.0f, 24000.0f);
        modulatedResonance = applyDeviation(modulatedResonance, mParams.resonanceDeviation, 0.0f, 1.0f);

        // Configure grain parameters
        GrainParameters grainParams;
        grainParams.sourceBuffer = currentBuffer;
        grainParams.currentIndex = deviatedScanIndex;
        grainParams.transposition = grainPlaybackRate;
        grainParams.durationMs = modulatedDuration;
        grainParams.envelope = modulatedEnvelope;
        grainParams.pan = modulatedPan;
        grainParams.amplitudeDb = modulatedAmplitude;
        grainParams.filterFreq = modulatedFilterFreq;
        grainParams.resonance = modulatedResonance;
        grainParams.activeVoiceCount = &mActiveVoiceCount;

        grainParams.useMultichannelGains = (mParams.spatial.mode != AllocationMode::FIXED &&
                                            mParams.spatial.numChannels > 2);
        grainParams.channelGains = panning.gains;

        grain->configure(grainParams, mSampleRate);
        mActiveVoiceCount.fetch_add(1, std::memory_order_relaxed);
      }
      // else: voice pool exhausted — grain dropped silently
    }

    // Advance grain emission time
    mGrainEmissionTime += 1.0f / mSampleRate;
  }

  // Process all active voices (batch processing for efficiency)
  mVoicePool.processActiveVoices(outBuffers, numChannels, numFrames);
}

void GranularEngine::stopAllGrains() {
  mVoicePool.stopAll();
  mActiveVoiceCount.store(0, std::memory_order_relaxed);
}

// LFO System (Phase 9)

LFO* GranularEngine::getLFO(int index) {
  if (index < 0 || index >= MAX_LFOS) {
    return nullptr;
  }
  return &mLFOs[index];
}

void GranularEngine::processLFOs(int numFrames) {
  // Process LFOs over the full buffer duration, using block-average for
  // better control-rate accuracy than taking only the final sample
  for (int i = 0; i < MAX_LFOS; ++i) {
    mLFOValues[i] = mLFOs[i].processBlockAverage(numFrames);
  }
}

float GranularEngine::applyModulation(float baseValue, const ModulationParameters& modParams,
                                     float minValue, float maxValue) {
  // If no LFO assigned or depth is zero, return base value
  if (modParams.lfoSource == 0 || modParams.depth == 0.0f) {
    return baseValue;
  }

  // Get LFO index (lfoSource is 1-6, array index is 0-5)
  int lfoIndex = modParams.lfoSource - 1;
  if (lfoIndex < 0 || lfoIndex >= MAX_LFOS) {
    return baseValue;
  }

  // Get current LFO value
  float lfoValue = mLFOValues[lfoIndex];

  // Calculate modulation range
  float range = maxValue - minValue;
  float modAmount = lfoValue * modParams.depth * range;

  // Apply modulation and clamp to valid range
  float modulatedValue = baseValue + modAmount;
  if (modulatedValue < minValue) modulatedValue = minValue;
  if (modulatedValue > maxValue) modulatedValue = maxValue;

  return modulatedValue;
}

float GranularEngine::applyDeviation(float baseValue, float deviation,
                                     float minValue, float maxValue) {
  // If no deviation, return base value
  if (deviation == 0.0f) {
    return baseValue;
  }

  // Generate uniform random number in range [-1, 1] using MT19937
  float randomFactor = mDeviationDist(mDeviationRng);

  // Apply deviation: baseValue ± (deviation * randomFactor)
  float deviatedValue = baseValue + (deviation * randomFactor);

  // Clamp to valid range
  if (deviatedValue < minValue) deviatedValue = minValue;
  if (deviatedValue > maxValue) deviatedValue = maxValue;

  return deviatedValue;
}

float GranularEngine::getScanPosition() const {
  // Get current buffer to determine frame count for normalization
  // Bounds check to prevent crash
  if (mAudioBuffers.empty() || mParams.soundFile < 0 ||
      static_cast<size_t>(mParams.soundFile) >= mAudioBuffers.size()) {
    return 0.0f;
  }

  auto buffer = mAudioBuffers[mParams.soundFile];
  if (!buffer || buffer->frames == 0) {
    return 0.0f;
  }

  // Normalize scan index to 0-1 range
  float normalizedPos = mCurrentScanIndex / static_cast<float>(buffer->frames);

  // Clamp to valid range
  return std::max(0.0f, std::min(1.0f, normalizedPos));
}

void GranularEngine::getGrainPositions(std::vector<float>& positions, int maxCount,
                                       float& minPos, float& maxPos) const {
  // Get current buffer frame count for normalization
  // Bounds check to prevent crash
  float bufferFrames = 0.0f;
  if (!mAudioBuffers.empty() && mParams.soundFile >= 0 &&
      static_cast<size_t>(mParams.soundFile) < mAudioBuffers.size()) {
    auto buffer = mAudioBuffers[mParams.soundFile];
    if (buffer && buffer->frames > 0) {
      bufferFrames = static_cast<float>(buffer->frames);
    }
  }

  // Delegate to voice pool
  mVoicePool.getGrainPositions(positions, maxCount, bufferFrames, minPos, maxPos);
}

}  // namespace ec2
