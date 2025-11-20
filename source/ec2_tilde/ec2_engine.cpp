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
  // Safety check - need at least one buffer
  auto currentBuffer = getAudioBuffer(mParams.soundFile);
  if (!currentBuffer || currentBuffer->size == 0) {
    return;  // No audio to process
  }

  // Update scan index (simple version for now)
  // Phase 5 will implement full scanner with speed control
  mCurrentScanIndex = mParams.scanBegin * currentBuffer->frames;

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

        // Configure grain parameters
        GrainParameters grainParams;
        grainParams.sourceBuffer = currentBuffer;
        grainParams.currentIndex = mCurrentScanIndex;
        grainParams.transposition = mParams.playbackRate;
        grainParams.durationMs = mParams.grainDuration;
        grainParams.envelope = mParams.envelope;
        grainParams.pan = mParams.pan;  // Legacy stereo pan (fallback)
        grainParams.amplitudeDb = mParams.amplitude;
        grainParams.filterFreq = mParams.filterFreq;
        grainParams.resonance = mParams.resonance;
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

}  // namespace ec2
