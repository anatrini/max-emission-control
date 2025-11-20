/**
 * ec2_envelope.cpp
 * Implementation of grain envelope generator
 * Adapted from EmissionControl2 for Max/MSP
 */

#include "ec2_envelope.h"
#include <algorithm>

namespace ec2 {

GrainEnvelope::GrainEnvelope(float duration, float envelope) {
  setDuration(duration);
  setEnvelope(envelope);
}

void GrainEnvelope::setSamplingRate(float samplingRate) {
  mSamplingRate = samplingRate;
  mExpoEnv.setSamplingRate(mSamplingRate);
  mTukeyEnv.setSamplingRate(mSamplingRate);
  mRExpoEnv.setSamplingRate(mSamplingRate);
}

float GrainEnvelope::operator()() {
  // Clamp envelope to valid range
  if (mEnvelope < 0.0f || mEnvelope > 1.0f) {
    mEnvelope = std::clamp(mEnvelope, 0.0f, 1.0f);
  }

  if (mEnvelope < 0.5f) {
    // Interpolate between exponential decay and tukey
    // mEnvelope = 0: full expo, mEnvelope = 0.5: full tukey
    mRExpoEnv.increment();  // Keep in sync but don't use
    float expoWeight = 1.0f - (mEnvelope * 2.0f);
    float tukeyWeight = mEnvelope * 2.0f;
    return (mExpoEnv() * expoWeight) + (mTukeyEnv() * tukeyWeight);

  } else if (mEnvelope == 0.5f) {
    // Pure tukey envelope
    mRExpoEnv.increment();
    mExpoEnv.increment();
    return mTukeyEnv();

  } else {  // mEnvelope > 0.5
    // Interpolate between tukey and reverse exponential
    // mEnvelope = 0.5: full tukey, mEnvelope = 1: full reverse expo
    mExpoEnv.increment();  // Keep in sync but don't use
    float tukeyWeight = 1.0f - ((mEnvelope - 0.5f) * 2.0f);
    float rexpoWeight = (mEnvelope - 0.5f) * 2.0f;
    return (mTukeyEnv() * tukeyWeight) + (mRExpoEnv() * rexpoWeight);
  }
}

void GrainEnvelope::reset() {
  mExpoEnv.reset();
  mRExpoEnv.reset();
  mTukeyEnv.reset();
}

void GrainEnvelope::setDuration(float duration) {
  if (duration <= 0.0f) {
    mDuration = 0.001f;  // Minimum duration
  } else {
    mDuration = duration;
  }

  mTukeyEnv.set(mDuration);
  mExpoEnv.set(mDuration, false);   // Forward expo (decay)
  mRExpoEnv.set(mDuration, true);   // Reverse expo (growth)
}

void GrainEnvelope::setEnvelope(float envelope) {
  mEnvelope = std::clamp(envelope, 0.0f, 1.0f);
}

void GrainEnvelope::set(float duration, float envelope) {
  setDuration(duration);
  setEnvelope(envelope);
}

bool GrainEnvelope::isDone() const {
  return mTukeyEnv.isDone();
}

}  // namespace ec2
