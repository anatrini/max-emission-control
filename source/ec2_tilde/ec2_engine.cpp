/**
 * ec2_engine.cpp
 * Implementation of main granular synthesis engine
 */

#include "ec2_engine.h"
#include <iostream>

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
  // Process LFOs once per audio callback (Phase 9)
  processLFOs();

  // Apply modulation to control-rate parameters (Phase 9)
  float modulatedGrainRate = applyModulation(mParams.grainRate, mParams.modGrainRate, 0.1f, 500.0f);
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
  float modulatedScanRange = applyModulation(mParams.scanRange, mParams.modScanRange, 0.0f, 1.0f);
  float modulatedScanSpeed = applyModulation(mParams.scanSpeed, mParams.modScanSpeed, -32.0f, 32.0f);

  // Update scan index with modulated parameters
  // TODO: Implement full scanner with modulatedScanSpeed
  mCurrentScanIndex = modulatedScanBegin * currentBuffer->frames;

  // Process frame by frame
  for (int frame = 0; frame < numFrames; ++frame) {
    // Check if scheduler wants to trigger a new grain
    if (mScheduler.trigger()) {
      Grain* grain = mVoicePool.getFreeVoice();

      if (grain) {
        // Create grain metadata for spatial allocator
        GrainMetadata metadata;
        metadata.emissionTime = mGrainEmissionTime;
        metadata.pitch = mParams.playbackRate * 440.0f;  // Approximate pitch from playback rate
        metadata.spectralCentroid = mParams.filterFreq;
        metadata.streamId = 0;  // TODO: Implement stream routing
        metadata.grainIndex = mActiveVoiceCount;

        // Get spatial allocation (multichannel panning gains)
        PanningVector panning = mSpatialAllocator.allocate(metadata);

        // Apply modulation to parameters (Phase 9)
        float modulatedPlaybackRate = applyModulation(mParams.playbackRate, mParams.modPlaybackRate, -32.0f, 32.0f);
        float modulatedDuration = applyModulation(mParams.grainDuration, mParams.modGrainDuration, 1.0f, 1000.0f);
        float modulatedEnvelope = applyModulation(mParams.envelope, mParams.modEnvelope, 0.0f, 1.0f);
        float modulatedPan = applyModulation(mParams.pan, mParams.modPan, -1.0f, 1.0f);
        float modulatedAmplitude = applyModulation(mParams.amplitude, mParams.modAmplitude, 0.0f, 1.0f);
        float modulatedFilterFreq = applyModulation(mParams.filterFreq, mParams.modFilterFreq, 20.0f, 22000.0f);
        float modulatedResonance = applyModulation(mParams.resonance, mParams.modResonance, 0.0f, 1.0f);

        // Configure grain parameters
        GrainParameters grainParams;
        grainParams.sourceBuffer = currentBuffer;
        grainParams.currentIndex = mCurrentScanIndex;
        grainParams.transposition = modulatedPlaybackRate;
        grainParams.durationMs = modulatedDuration;
        grainParams.envelope = modulatedEnvelope;
        grainParams.pan = modulatedPan;  // Legacy stereo pan (fallback)
        grainParams.amplitudeDb = modulatedAmplitude;
        grainParams.filterFreq = modulatedFilterFreq;
        grainParams.resonance = modulatedResonance;
        grainParams.activeVoiceCount = &mActiveVoiceCount;

        // Apply spatial allocation
        grainParams.useMultichannelGains = (mParams.spatial.mode != AllocationMode::FIXED ||
                                            mParams.spatial.numChannels > 2);
        grainParams.channelGains = panning.gains;

        grain->configure(grainParams, mSampleRate);
        mActiveVoiceCount++;

      } else {
        // Out of voices - could log this
        // std::cout << "ec2~: out of voices!" << std::endl;
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

}  // namespace ec2
