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
    mScheduler(DEFAULT_SAMPLE_RATE) {

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
  // Expand buffer array if needed
  if (index >= static_cast<int>(mAudioBuffers.size())) {
    mAudioBuffers.resize(index + 1);
  }
  mAudioBuffers[index] = buffer;
}

std::shared_ptr<AudioBuffer<float>> GranularEngine::getAudioBuffer(int index) {
  if (index < 0 || index >= static_cast<int>(mAudioBuffers.size())) {
    return nullptr;
  }
  return mAudioBuffers[index];
}

void GranularEngine::updateParameters(const SynthParameters& params) {
  mParams = params;

  // Update scheduler
  mScheduler.configure(params.grainRate, params.async, params.intermittency);
  mScheduler.setPolyStream(SYNCHRONOUS, params.streams);

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
  // Process LFOs once per audio callback (Phase 9)
  processLFOs();

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

  float modulatedAsync = applyModulation(mParams.async, mParams.modAsync, 0.0f, 1.0f);
  float modulatedIntermittency = applyModulation(mParams.intermittency, mParams.modIntermittency, 0.0f, 1.0f);
  int modulatedStreams = static_cast<int>(applyModulation(static_cast<float>(mParams.streams),
                                                          mParams.modStreams, 1.0f, 20.0f));

  // Update scheduler with modulated parameters
  mScheduler.configure(modulatedGrainRate, modulatedAsync, modulatedIntermittency);
  mScheduler.setPolyStream(SYNCHRONOUS, modulatedStreams);

  // Safety check - need at least one buffer
  auto currentBuffer = getAudioBuffer(mParams.soundFile);
  if (!currentBuffer || currentBuffer->size == 0) {
    return;  // No audio to process
  }

  // Apply modulation to scan parameters (Phase 9)
  float modulatedScanBegin = applyModulation(mParams.scanBegin, mParams.modScanBegin, 0.0f, 1.0f);

  // Initialize scan index with modulated parameters if no signal input
  if (!scanSignal) {
    mCurrentScanIndex = modulatedScanBegin * currentBuffer->frames;
  }

  // Process frame by frame
  for (int frame = 0; frame < numFrames; ++frame) {
    // Check if scheduler wants to trigger a new grain
    if (mScheduler.trigger()) {

      // Update scan position from signal input if provided (Phase 12)
      // Sample just-in-time when grain is triggered for efficiency
      if (scanSignal) {
        // Clamp scan signal to 0.0-1.0 range
        float scanPos = std::max(0.0f, std::min(scanSignal[frame], 1.0f));
        mCurrentScanIndex = scanPos * currentBuffer->frames;
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
          // Clamp playback signal to valid range
          grainPlaybackRate = std::max(-32.0f, std::min(playbackSignal[frame], 32.0f));
        } else {
          grainPlaybackRate = applyModulation(mParams.playbackRate, mParams.modPlaybackRate, -32.0f, 32.0f);
        }

        metadata.pitch = grainPlaybackRate * 440.0f;  // Approximate pitch from playback rate
        metadata.spectralCentroid = mParams.filterFreq;
        metadata.streamId = 0;  // TODO: Implement stream routing
        metadata.grainIndex = mActiveVoiceCount;

        // Get spatial allocation (multichannel panning gains)
        PanningVector panning = mSpatialAllocator.allocate(metadata);

        // Apply modulation to other parameters (Phase 9)
        float modulatedDuration = applyModulation(mParams.grainDuration, mParams.modGrainDuration, 1.0f, 1000.0f);
        float modulatedEnvelope = applyModulation(mParams.envelope, mParams.modEnvelope, 0.0f, 1.0f);
        float modulatedPan = applyModulation(mParams.pan, mParams.modPan, -1.0f, 1.0f);
        float modulatedAmplitude = applyModulation(mParams.amplitude, mParams.modAmplitude, 0.0f, 1.0f);
        float modulatedFilterFreq = applyModulation(mParams.filterFreq, mParams.modFilterFreq, 20.0f, 22000.0f);
        float modulatedResonance = applyModulation(mParams.resonance, mParams.modResonance, 0.0f, 1.0f);

        // Apply statistical deviation (Curtis Roads: stochastic grain clouds)
        // Each grain gets slightly randomized parameters for organic variation
        grainPlaybackRate = applyDeviation(grainPlaybackRate, mParams.playbackDeviation, -32.0f, 32.0f);
        modulatedDuration = applyDeviation(modulatedDuration, mParams.durationDeviation, 1.0f, 1000.0f);
        modulatedEnvelope = applyDeviation(modulatedEnvelope, mParams.envelopeDeviation, 0.0f, 1.0f);
        modulatedPan = applyDeviation(modulatedPan, mParams.panDeviation, -1.0f, 1.0f);
        modulatedAmplitude = applyDeviation(modulatedAmplitude, mParams.amplitudeDeviation, 0.0f, 1.0f);
        modulatedFilterFreq = applyDeviation(modulatedFilterFreq, mParams.filterFreqDeviation, 20.0f, 22000.0f);
        modulatedResonance = applyDeviation(modulatedResonance, mParams.resonanceDeviation, 0.0f, 1.0f);

        // Configure grain parameters
        GrainParameters grainParams;
        grainParams.sourceBuffer = currentBuffer;
        grainParams.currentIndex = deviatedScanIndex;  // Use deviated scan position
        grainParams.transposition = grainPlaybackRate;  // Use signal-rate or modulated value
        grainParams.durationMs = modulatedDuration;
        grainParams.envelope = modulatedEnvelope;
        grainParams.pan = modulatedPan;  // Legacy stereo pan (fallback)

        // Convert linear amplitude (0-1) to dB for grain
        // Grain expects dB, but we work with linear internally for modulation
        float amplitudeDb = (modulatedAmplitude > 0.0001f) ?
                            (20.0f * std::log10(modulatedAmplitude)) : -96.0f;
        grainParams.amplitudeDb = amplitudeDb;

        grainParams.filterFreq = modulatedFilterFreq;
        grainParams.resonance = modulatedResonance;
        grainParams.activeVoiceCount = &mActiveVoiceCount;

        // Apply spatial allocation
        // Use multichannel gains ONLY when spatial mode is active AND we have > 2 channels
        // For stereo (2 channels), always use legacy panning
        grainParams.useMultichannelGains = (mParams.spatial.mode != AllocationMode::FIXED &&
                                            mParams.spatial.numChannels > 2);
        grainParams.channelGains = panning.gains;

        grain->configure(grainParams, mSampleRate);
        mActiveVoiceCount++;

      } else {
        // Out of voices - voice pool exhausted
      }
    }

    // Advance grain emission time
    mGrainEmissionTime += 1.0f / mSampleRate;

    // Process all active grains for this frame
    for (int i = static_cast<int>(mVoicePool.getActiveVoiceCount()) - 1; i >= 0; --i) {
      // Voice pool handles grain processing internally
    }
  }

  // Process all active voices (batch processing for efficiency)
  mVoicePool.processActiveVoices(outBuffers, numChannels, numFrames);
}

void GranularEngine::stopAllGrains() {
  mVoicePool.stopAll();
  mActiveVoiceCount = 0;
}

// LFO System (Phase 9)

LFO* GranularEngine::getLFO(int index) {
  if (index < 0 || index >= MAX_LFOS) {
    return nullptr;
  }
  return &mLFOs[index];
}

void GranularEngine::processLFOs() {
  // Process all LFOs once per audio callback
  // This updates mLFOValues which are then used for modulation
  for (int i = 0; i < MAX_LFOS; ++i) {
    mLFOValues[i] = mLFOs[i].process();
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

  // Generate uniform random number in range [-1, 1]
  float randomFactor = 2.0f * (static_cast<float>(rand()) / static_cast<float>(RAND_MAX)) - 1.0f;

  // Apply deviation: baseValue ± (deviation * randomFactor)
  float deviatedValue = baseValue + (deviation * randomFactor);

  // Clamp to valid range
  if (deviatedValue < minValue) deviatedValue = minValue;
  if (deviatedValue > maxValue) deviatedValue = maxValue;

  return deviatedValue;
}

}  // namespace ec2
