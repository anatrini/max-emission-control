/**
 * ec2_lfo.cpp
 * LFO implementation
 */

#include "ec2_lfo.h"
#include <cmath>

namespace ec2 {

LFO::LFO()
    : mRNG(std::random_device{}()),
      mDist(-1.0f, 1.0f) {
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
    // Generate raw waveform
    float rawValue = generateWaveform(mPhase);

    // Apply polarity
    mCurrentValue = applyPolarity(rawValue);

    // Advance phase
    mPhase += mPhaseIncrement;
    while (mPhase >= 1.0f) {
        mPhase -= 1.0f;
    }

    return mCurrentValue;
}

float LFO::generateWaveform(float phase) {
    switch (mShape) {
        case LFOShape::SINE: {
            // Sine wave: -1 to 1
            return std::sin(phase * 2.0f * M_PI);
        }

        case LFOShape::SQUARE: {
            // Square wave with duty cycle: -1 or 1
            return (phase < mDuty) ? 1.0f : -1.0f;
        }

        case LFOShape::RISE: {
            // Rising sawtooth: -1 to 1
            return (phase * 2.0f) - 1.0f;
        }

        case LFOShape::FALL: {
            // Falling sawtooth: 1 to -1
            return 1.0f - (phase * 2.0f);
        }

        case LFOShape::NOISE: {
            // Sample and hold noise
            unsigned int currentPhase = static_cast<unsigned int>(phase * 1000.0f);
            if (currentPhase != mLastPhase) {
                mHoldValue = mDist(mRNG);
                mLastPhase = currentPhase;
            }
            return mHoldValue;
        }

        default:
            return 0.0f;
    }
}

float LFO::applyPolarity(float value) {
    switch (mPolarity) {
        case LFOPolarity::BIPOLAR:
            // -1 to 1 (no change)
            return value;

        case LFOPolarity::UNIPOLAR_POS:
            // 0 to 1
            return (value + 1.0f) * 0.5f;

        case LFOPolarity::UNIPOLAR_NEG:
            // -1 to 0
            return (value - 1.0f) * 0.5f;

        default:
            return value;
    }
}

}  // namespace ec2
