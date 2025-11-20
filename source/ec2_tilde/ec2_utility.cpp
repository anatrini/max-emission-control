/**
 * ec2_utility.cpp
 * Implementation of utility classes for EC2 granular synthesis
 * Adapted from EmissionControl2 for Max/MSP
 */

#include "ec2_utility.h"
#include <cmath>
#include <cassert>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#ifndef M_E
#define M_E 2.71828182845904523536
#endif

namespace ec2 {

//=============================================================================
// FastTrig Implementation
//=============================================================================

void FastTrig::buildTrigTable() {
  for (int i = 0; i < CIRCLE; i++) {
    COS_TABLE[i] = std::cos(M_PI * static_cast<float>(i) / HALF_CIRCLE);
  }
}

float FastTrig::getCosImpliedPiFactor(float x) {
  int index = static_cast<int>(x * HALF_CIRCLE);
  if (index < 0) {
    return COS_TABLE[-((-index) & MASK_CIRCLE) + CIRCLE];
  } else {
    return COS_TABLE[index & MASK_CIRCLE];
  }
}

//=============================================================================
// Expo Implementation
//=============================================================================

float Expo::operator()() {
  if (!mReverse) {
    // Forward exponential decay envelope
    if (mX < mThresholdX * 0.01f) {
      // Initial ramp up
      mY = std::pow(static_cast<float>(M_E), 100.0f * mX - mThresholdX);
      mX += mIncrementX;
    } else if (mX < mThresholdX) {
      // Main decay
      mY = std::pow(static_cast<float>(M_E), -1.0f * mX + (mThresholdX * 0.01f));
      mX += mIncrementX;
    } else {
      // Done
      mY = mThresholdY;
      mX = 0;
    }
  } else {
    // Reverse exponential (growth) envelope
    if (mX < mThresholdX * 0.92761758634f) {
      mY = std::pow(static_cast<float>(M_E), 0.9f * (mX - mThresholdX + 0.5f));
      mX += mIncrementX;
    } else if (mX < mThresholdX * 0.95f) {
      // Small sustain
      mY = 1.0f;
      mX += mIncrementX;
    } else if (mX < mThresholdX) {
      // Quick release
      mY = std::pow(static_cast<float>(M_E), -20.0f * (mX - (mThresholdX * 0.95f)));
      mX += mIncrementX;
    } else {
      // Done
      mY = mThresholdY;
      mX = 0;
    }
  }
  return mY;
}

void Expo::reset() {
  if (mTotalS <= 0) mTotalS = 1;
  if (mThresholdY <= 0) {
    mThresholdY = 0.001f;
    mThresholdX = -1.0f * std::log(0.001f);
  }
  mX = 0;
  mY = mThresholdY;
  mIncrementX = (mThresholdX / mTotalS);
}

void Expo::set(float seconds, bool reverse, float threshold) {
  mTotalS = static_cast<int>(seconds * mSamplingRate);
  mReverse = reverse;
  mThresholdY = threshold;
  mThresholdX = -1.0f * std::log(threshold);
  reset();
}

void Expo::set(float seconds, bool reverse) {
  mTotalS = static_cast<int>(seconds * mSamplingRate);
  mReverse = reverse;
  reset();
}

void Expo::set(float seconds) {
  mTotalS = static_cast<int>(seconds * mSamplingRate);
  reset();
}

//=============================================================================
// Tukey Implementation
//=============================================================================

float Tukey::operator()() {
  if (currentS < (alphaTotalS / 2)) {
    // Attack phase
    value = 0.5f * (1.0f + fastTrig.getCosImpliedPiFactor(
      (2.0f * currentS / alphaTotalS) - 1.0f));
    currentS++;
  } else if (currentS <= totalS * (1.0f - alpha / 2.0f)) {
    // Sustain phase
    value = 1.0f;
    currentS++;
  } else if (currentS <= totalS) {
    // Release phase
    value = 0.5f * (1.0f + fastTrig.getCosImpliedPiFactor(
      (2.0f * currentS / alphaTotalS) - (2.0f / alpha) + 1.0f));
    currentS++;
  } else {
    // Done - reset
    currentS = 0;
  }
  return value;
}

void Tukey::reset() {
  if (totalS <= 0) totalS = 1;
  currentS = 0;
  value = 0;
  alphaTotalS = totalS * alpha;
}

void Tukey::set(float seconds, float alphaVal) {
  alpha = alphaVal;
  totalS = static_cast<int>(seconds * mSamplingRate);
  reset();
}

void Tukey::set(float seconds) {
  totalS = static_cast<int>(seconds * mSamplingRate);
  reset();
}

}  // namespace ec2
