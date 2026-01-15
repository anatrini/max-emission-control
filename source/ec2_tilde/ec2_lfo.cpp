/**
 * ec2_lfo.cpp
 * LFO implementation
 *
 * Aligned with original EmissionControl2 ecModulator behavior:
 * - Waveform generation matches original Gamma-based implementation
 * - Polarity applied during generation (not post-hoc)
 * - RISE/FALL produce [0,1] in bipolar mode (matches original upU/downU)
 */

#include "ec2_lfo.h"
#include <cmath>

namespace ec2 {

LFO::LFO()
    : mRNG(std::random_device{}()),
      mDistBipolar(-1.0f, 1.0f),
      mDistUnipolar(0.0f, 1.0f) {
    updatePhaseIncrement();
}

void LFO::setSampleRate(float sampleRate) {
    mSampleRate = sampleRate;
    updatePhaseIncrement();
}

void LFO::setFrequency(float frequency) {
    mFrequency = std::max(0.001f, std::min(frequency, 10000.0f));
    updatePhaseIncrement();
}

void LFO::setShape(LFOShape shape) {
    mShape = shape;
}

void LFO::setPolarity(LFOPolarity polarity) {
    mPolarity = polarity;

    // Match original EC2 behavior: convert polarity to internal state
    // Original uses mSign and mPolarity (BI vs UNI) internally
    switch (polarity) {
        case LFOPolarity::BIPOLAR:
            mIsUnipolar = false;
            mSign = 1;  // Don't care for bipolar
            break;
        case LFOPolarity::UNIPOLAR_POS:
            mIsUnipolar = true;
            mSign = 1;
            break;
        case LFOPolarity::UNIPOLAR_NEG:
            mIsUnipolar = true;
            mSign = -1;
            break;
    }
}

void LFO::setDuty(float duty) {
    mDuty = std::max(0.0f, std::min(duty, 1.0f));
}

void LFO::setPhase(float phase) {
    while (phase < 0.0f) phase += 1.0f;
    while (phase >= 1.0f) phase -= 1.0f;
    mPhase = phase;
}

void LFO::updatePhaseIncrement() {
    mPhaseIncrement = mFrequency / mSampleRate;
}

float LFO::process() {
    // Generate waveform with polarity applied (matches original EC2)
    mCurrentValue = generateWaveform();

    // Advance phase
    mPhase += mPhaseIncrement;
    while (mPhase >= 1.0f) {
        mPhase -= 1.0f;
    }

    return mCurrentValue;
}

/**
 * Generate waveform value with polarity applied.
 * This matches the original ecModulator::operator() from emissionControl.cpp
 *
 * Key differences from typical LFO implementations:
 * 1. SINE uses cosine (phase offset 90°)
 * 2. RISE/FALL produce [0,1] or [1,0] in bipolar mode (not [-1,1])
 * 3. SQUARE uses triangle comparison for duty cycle
 * 4. Polarity is applied during generation, not after
 */
float LFO::generateWaveform() {
    float result;

    switch (mShape) {
        case LFOShape::SINE: {
            // Original: mLFO.cos() for bipolar, mLFO.cosU() * mSign for unipolar
            // cos() produces [-1, 1], cosU() produces [0, 1]
            if (!mIsUnipolar) {
                // Bipolar: cosine wave [-1, 1]
                result = std::cos(mPhase * 2.0f * M_PI);
            } else {
                // Unipolar: cosU() = (cos + 1) / 2 = [0, 1], then apply sign
                float cosU = (std::cos(mPhase * 2.0f * M_PI) + 1.0f) * 0.5f;
                result = cosU * static_cast<float>(mSign);
            }
            break;
        }

        case LFOShape::SQUARE: {
            // Original uses triangle wave comparison for duty cycle
            // tri() produces [-1, 1] triangle
            // Triangle approximation: convert phase to triangle wave
            float tri;
            if (mPhase < 0.5f) {
                // Rising portion: 0->0.5 maps to -1->1
                tri = (mPhase * 4.0f) - 1.0f;
            } else {
                // Falling portion: 0.5->1 maps to 1->-1
                tri = 3.0f - (mPhase * 4.0f);
            }

            if (!mIsUnipolar) {
                // Bipolar: threshold at -2*(mWidth-0.5)
                float threshold = -2.0f * (mDuty - 0.5f);
                result = (tri >= threshold) ? 1.0f : -1.0f;
            } else {
                // Unipolar: threshold adjusted by sign, output is mSign or 0
                float threshold = -static_cast<float>(mSign) * 2.0f * (mDuty - 0.5f);
                result = (tri >= threshold) ? static_cast<float>(mSign) : 0.0f;
            }
            break;
        }

        case LFOShape::RISE: {
            // Original: mLFO.upU() produces [0, 1] for all polarity modes
            // Bipolar: [0, 1], Unipolar: [0, 1] * mSign
            float upU = mPhase;  // Linear ramp 0 to 1
            if (!mIsUnipolar) {
                // Bipolar: output is [0, 1] (NOT [-1, 1] like typical LFO)
                result = upU;
            } else {
                // Unipolar: [0, 1] * mSign gives [0, 1] or [0, -1]
                result = upU * static_cast<float>(mSign);
            }
            break;
        }

        case LFOShape::FALL: {
            // Original: mLFO.downU() produces [1, 0] for all polarity modes
            // Bipolar: [1, 0], Unipolar: [1, 0] * mSign
            float downU = 1.0f - mPhase;  // Linear ramp 1 to 0
            if (!mIsUnipolar) {
                // Bipolar: output is [1, 0] (NOT [1, -1] like typical LFO)
                result = downU;
            } else {
                // Unipolar: [1, 0] * mSign gives [1, 0] or [-1, 0]
                result = downU * static_cast<float>(mSign);
            }
            break;
        }

        case LFOShape::NOISE: {
            // Sample and hold noise
            // Original: sampleAndHoldUniform with different ranges
            unsigned int currentPhaseInt = static_cast<unsigned int>(mPhase * 1000000.0f);

            // Check for phase wraparound (new cycle)
            if (currentPhaseInt < mLastPhase) {
                // Generate new sample on phase wrap
                if (!mIsUnipolar) {
                    // Bipolar: uniform(-1, 1)
                    mHoldValue = mDistBipolar(mRNG);
                } else {
                    // Unipolar: mSign * uniform(0, 1)
                    mHoldValue = static_cast<float>(mSign) * mDistUnipolar(mRNG);
                }
            }
            mLastPhase = currentPhaseInt;
            result = mHoldValue;
            break;
        }

        default:
            result = 0.0f;
            break;
    }

    return result;
}

}  // namespace ec2
