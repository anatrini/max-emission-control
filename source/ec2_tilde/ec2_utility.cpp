/**
 * ec2_utility.cpp
 * Implementation of utility classes for EC2 granular synthesis
 * Adapted from EmissionControl2 for Max/MSP
 */

#include "ec2_utility.h"
#include <cassert>
#include <cmath>

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

// Static member definitions
float FastTrig::COS_TABLE[FastTrig::CIRCLE];
bool FastTrig::tableBuilt = false;

void FastTrig::buildTrigTable() {
  if (tableBuilt)
    return;

  for (int i = 0; i < CIRCLE; i++) {
    COS_TABLE[i] = std::cos(M_PI * static_cast<float>(i) / HALF_CIRCLE);
  }
  tableBuilt = true;
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
      // Initial ramp up (Phase 0)
      if (mCurrentPhase != 0) {
        mCurrentPhase = 0;
        // Calculate multiplier for: exp(100 * x - threshold)
        // dY/step = exp(100 * dx)
        mMultiplier = std::exp(100.0f * mIncrementX);
        // Initialize Y if needed, but here we rely on continuity or reset
        // Re-calculate Y exactly at start of phase to avoid drift?
        // For now, just use the formula for the first sample of phase if
        // needed, but mY is stateful. Let's stick to the formula for the very
        // first sample, then multiply.
        mY = std::pow(static_cast<float>(M_E), 100.0f * mX - mThresholdX);
      } else {
        mY *= mMultiplier;
      }
      mX += mIncrementX;
    } else if (mX < mThresholdX) {
      // Main decay (Phase 1)
      if (mCurrentPhase != 1) {
        mCurrentPhase = 1;
        // Calculate multiplier for: exp(-1 * x + (threshold * 0.01))
        // dY/step = exp(-1 * dx)
        mMultiplier = std::exp(-1.0f * mIncrementX);
        // Recalculate Y to ensure continuity/correctness at phase transition
        mY = std::pow(static_cast<float>(M_E),
                      -1.0f * mX + (mThresholdX * 0.01f));
      } else {
        mY *= mMultiplier;
      }
      mX += mIncrementX;
    } else {
      // Done
      mY = mThresholdY;
      mX = 0;
    }
  } else {
    // Reverse exponential (growth) envelope
    if (mX < mThresholdX * 0.92761758634f) {
      // Growth (Phase 0)
      if (mCurrentPhase != 0) {
        mCurrentPhase = 0;
        // exp(0.9 * (x - threshold + 0.5))
        // dY/step = exp(0.9 * dx)
        mMultiplier = std::exp(0.9f * mIncrementX);
        mY =
            std::pow(static_cast<float>(M_E), 0.9f * (mX - mThresholdX + 0.5f));
      } else {
        mY *= mMultiplier;
      }
      mX += mIncrementX;
    } else if (mX < mThresholdX * 0.95f) {
      // Small sustain (Phase 1)
      mY = 1.0f;
      mX += mIncrementX;
      mCurrentPhase = 1;
    } else if (mX < mThresholdX) {
      // Quick release (Phase 2)
      if (mCurrentPhase != 2) {
        mCurrentPhase = 2;
        // exp(-20 * (x - (threshold * 0.95)))
        // dY/step = exp(-20 * dx)
        mMultiplier = std::exp(-20.0f * mIncrementX);
        mY = std::pow(static_cast<float>(M_E),
                      -20.0f * (mX - (mThresholdX * 0.95f)));
      } else {
        mY *= mMultiplier;
      }
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
  if (mTotalS <= 0)
    mTotalS = 1;
  if (mThresholdY <= 0) {
    mThresholdY = 0.001f;
    mThresholdX = -1.0f * std::log(0.001f);
  }
  mX = 0;
  mY = mThresholdY;
  mIncrementX = (mThresholdX / mTotalS);
  mCurrentPhase = -1; // Force phase init
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
    value =
        0.5f *
        (1.0f + fastTrig.getCosImpliedPiFactor((2.0f * currentS / alphaTotalS) -
                                               (2.0f / alpha) + 1.0f));
    currentS++;
  } else {
    // Done - reset
    currentS = 0;
  }
  return value;
}

void Tukey::reset() {
  if (totalS <= 0)
    totalS = 1;
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

} // namespace ec2
