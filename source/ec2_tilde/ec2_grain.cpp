/**
 * ec2_grain.cpp
 * Implementation of grain voice for granular synthesis
 * Adapted from EmissionControl2 for Max/MSP
 */

#include "ec2_grain.h"
#include <algorithm>
#include <cmath>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

namespace ec2 {

Grain::Grain() {
  mEnvelope.reset();
}

void Grain::configure(const GrainParameters& params, float sampleRate) {
  mSource = params.sourceBuffer;
  mActiveVoiceCount = params.activeVoiceCount;

  // Update sample rate if changed
  if (static_cast<int>(sampleRate) != mPrevSampleRate) {
    mPrevSampleRate = static_cast<int>(sampleRate);
    mSampleRate = sampleRate;
    initFilters(sampleRate);
  }

  // Set duration
  mDurationS = params.durationMs / 1000.0f;
  if (mDurationS <= 0.0f) mDurationS = 0.001f;

  // Configure envelope
  mEnvelope.setSamplingRate(sampleRate);
  mEnvelope.set(mDurationS, params.envelope);
  mEnvelope.reset();

  // Configure playback
  configurePlayback(params.currentIndex, params.transposition);

  // Configure amplitude (with voice count compensation)
  int voiceCount = (mActiveVoiceCount != nullptr) ? *mActiveVoiceCount : 1;
  configureAmplitude(params.amplitudeDb, voiceCount);

  // Configure panning
  configurePan(params.pan, mAmp);

  // Configure filter
  int sourceChannels = (mSource != nullptr) ? mSource->channels : 1;
  configureFilter(params.filterFreq, params.resonance, sourceChannels);
}

bool Grain::process(float& outLeft, float& outRight) {
  // Check if envelope is done
  if (mEnvelope.isDone()) {
    if (mActiveVoiceCount != nullptr) {
      (*mActiveVoiceCount)--;
    }
    outLeft = 0.0f;
    outRight = 0.0f;
    return false;  // Grain finished
  }

  // Safety check
  if (mSource == nullptr || mSource->size == 0) {
    outLeft = 0.0f;
    outRight = 0.0f;
    return true;
  }

  // Get envelope value
  float envVal = mEnvelope();

  // Get playback index
  float sourceIndex = mPlaybackIndex();
  int iSourceIndex = static_cast<int>(sourceIndex);

  // Wrap index if out of bounds
  if (iSourceIndex >= static_cast<int>(mSource->frames) - mSource->channels || iSourceIndex < 0) {
    sourceIndex = std::fmod(sourceIndex, static_cast<float>(mSource->frames - mSource->channels));
    iSourceIndex = static_cast<int>(sourceIndex);
    if (iSourceIndex < 0) {
      sourceIndex += (mSource->frames - mSource->channels);
      iSourceIndex += (mSource->frames - mSource->channels);
    }
  }

  mSourceIndex = sourceIndex;

  // Process based on source channel count
  float currentSampleL = 0.0f;
  float currentSampleR = 0.0f;

  if (mSource->channels == 1) {
    // Mono source - linear interpolation
    mBefore = mSource->data[iSourceIndex];
    mAfter = mSource->data[iSourceIndex + 1];
    mDecimal = sourceIndex - iSourceIndex;
    currentSampleL = mBefore * (1.0f - mDecimal) + mAfter * mDecimal;

    // Apply filter
    if (!mBypassFilter) {
      currentSampleL = filterSample(currentSampleL, mCascadeFilterMix, false);
    }

    // Apply envelope and pan
    outLeft = currentSampleL * envVal * mLeftGain;
    outRight = currentSampleL * envVal * mRightGain;

  } else if (mSource->channels == 2) {
    // Stereo source - process left channel
    mBefore = mSource->data[iSourceIndex * 2];
    mAfter = mSource->data[iSourceIndex * 2 + 2];
    mDecimal = sourceIndex - iSourceIndex;
    currentSampleL = mBefore * (1.0f - mDecimal) + mAfter * mDecimal;

    if (!mBypassFilter) {
      currentSampleL = filterSample(currentSampleL, mCascadeFilterMix, false);
    }

    outLeft = currentSampleL * envVal * mLeftGain;

    // Process right channel
    mBefore = mSource->get(iSourceIndex * 2 + 1);
    mAfter = mSource->get(iSourceIndex * 2 + 3);
    mDecimal = (sourceIndex + 1.0f) - (iSourceIndex + 1);
    currentSampleR = mBefore * (1.0f - mDecimal) + mAfter * mDecimal;

    if (!mBypassFilter) {
      currentSampleR = filterSample(currentSampleR, mCascadeFilterMix, true);
    }

    outRight = currentSampleR * envVal * mRightGain;
  }

  return true;  // Grain still active
}

void Grain::reset() {
  mEnvelope.reset();
  mSource = nullptr;
  mSourceIndex = 0.0f;
}

//=============================================================================
// Configuration Helpers
//=============================================================================

void Grain::configurePlayback(float startIndex, float transposition) {
  mPlaybackIndex.setSamplingRate(mSampleRate);
  float startSample = startIndex;
  float endSample = startSample + (mDurationS * mSampleRate * transposition);
  mPlaybackIndex.set(startSample, endSample, mDurationS);
}

void Grain::configureAmplitude(float dbIn, int voiceCount) {
  // Convert dB to linear amplitude
  mAmp = std::pow(10.0f, dbIn / 20.0f);

  // Voice count compensation (1/e law)
  // This prevents volume increase with grain overlap
  mAmp *= std::pow(static_cast<float>(voiceCount + 1), -0.367877f);
}

void Grain::configurePan(float pan, float amp) {
  // Constant power panning
  // pan: -1 (left) to +1 (right)
  // Using trigonometric pan law for constant power

  float panRad = pan * M_PI / 4.0f;  // Map to -π/4 to +π/4
  float cosVal = std::cos(panRad);
  float sinVal = std::sin(panRad);

  mLeftGain = PAN_CONST * (cosVal - sinVal) * amp;
  mRightGain = PAN_CONST * (cosVal + sinVal) * amp;
}

void Grain::configureFilter(float freq, float resonance, int sourceChannels) {
  // Bypass filter if resonance is near zero
  if (resonance >= 0.0f && resonance < 0.00001f) {
    mBypassFilter = true;
    return;
  }

  mBypassFilter = false;

  // Process resonance with exponential curve
  // EC2's custom resonance curve: 13^(2.9 * (resonance - 0.5))
  float resProcess = std::pow(13.0f, 2.9f * (resonance - 0.5f));

  // Normalize cascade mix (max resonance is 41.2304)
  mCascadeFilterMix = resProcess / 41.2304f;

  // Configure left channel filters
  mBpf1L.setBandpass(freq, mSampleRate, resonance);
  mBpf2L.setBandpass(freq, mSampleRate, std::log(resProcess + 1.0f) / 49.5f);  // Logarithmic for middle stage
  mBpf3L.setBandpass(freq, mSampleRate, resonance);

  // Configure right channel filters (if stereo)
  if (sourceChannels == 2) {
    mBpf1R.setBandpass(freq, mSampleRate, resonance);
    mBpf2R.setBandpass(freq, mSampleRate, std::log(resProcess + 1.0f) / 49.5f);
    mBpf3R.setBandpass(freq, mSampleRate, resonance);
  }
}

void Grain::initFilters(float sampleRate) {
  // Zero out all filter states
  mBpf1L.zero();
  mBpf2L.zero();
  mBpf3L.zero();
  mBpf1R.zero();
  mBpf2R.zero();
  mBpf3R.zero();

  // Set default filter parameters
  mBpf1L.setBandpass(440.0f, sampleRate);
  mBpf2L.setBandpass(440.0f, sampleRate);
  mBpf3L.setBandpass(440.0f, sampleRate);
  mBpf1R.setBandpass(440.0f, sampleRate);
  mBpf2R.setBandpass(440.0f, sampleRate);
  mBpf3R.setBandpass(440.0f, sampleRate);
}

float Grain::filterSample(float sample, float cascadeMix, bool isRightChannel) {
  float solo, cascade;

  if (!isRightChannel) {
    // Left channel: 3-stage cascade
    solo = mBpf1L(sample);
    cascade = mBpf3L(mBpf2L(solo));
  } else {
    // Right channel: 3-stage cascade
    solo = mBpf1R(sample);
    cascade = mBpf3R(mBpf2R(solo));
  }

  // Mix between single-stage and cascaded output
  return solo * (1.0f - cascadeMix) + cascade * cascadeMix;
}

}  // namespace ec2
