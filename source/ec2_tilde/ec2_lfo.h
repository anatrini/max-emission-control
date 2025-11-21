/**
 * ec2_lfo.h
 * Low-frequency oscillator for parameter modulation
 * Adapted from EmissionControl2 for Max/MSP
 */

#ifndef EC2_LFO_H
#define EC2_LFO_H

#include "ec2_constants.h"
#include "ec2_utility.h"
#include <random>

namespace ec2 {

/**
 * LFO waveform types
 */
enum class LFOShape {
    SINE = 0,
    SQUARE = 1,
    RISE = 2,      // Ascending sawtooth
    FALL = 3,      // Descending sawtooth
    NOISE = 4      // Sample and hold noise
};

/**
 * LFO polarity types
 */
enum class LFOPolarity {
    BIPOLAR = 0,       // -1 to 1
    UNIPOLAR_POS = 1,  // 0 to 1
    UNIPOLAR_NEG = 2   // -1 to 0
};

/**
 * Low-frequency oscillator for parameter modulation
 * Supports multiple waveforms and polarities
 */
class LFO {
public:
    LFO();

    /**
     * Set sample rate
     */
    void setSampleRate(float sampleRate);

    /**
     * Set frequency in Hz
     */
    void setFrequency(float frequency);

    /**
     * Set waveform shape
     */
    void setShape(LFOShape shape);

    /**
     * Set polarity (bipolar/unipolar)
     */
    void setPolarity(LFOPolarity polarity);

    /**
     * Set duty cycle (for square wave)
     * 0.0-1.0, default 0.5
     */
    void setDuty(float duty);

    /**
     * Set phase (0.0-1.0)
     */
    void setPhase(float phase);

    /**
     * Process one sample
     * @return Modulation value
     */
    float process();

    /**
     * Get current value without advancing
     */
    float getCurrentValue() const { return mCurrentValue; }

    // Getters
    float getFrequency() const { return mFrequency; }
    LFOShape getShape() const { return mShape; }
    LFOPolarity getPolarity() const { return mPolarity; }
    float getDuty() const { return mDuty; }
    float getPhase() const { return mPhase; }

private:
    float mSampleRate = DEFAULT_SAMPLE_RATE;
    float mFrequency = 1.0f;
    LFOShape mShape = LFOShape::SINE;
    LFOPolarity mPolarity = LFOPolarity::BIPOLAR;
    float mDuty = 0.5f;
    float mPhase = 0.0f;

    float mPhaseIncrement = 0.0f;
    float mCurrentValue = 0.0f;

    // For sample and hold noise
    std::mt19937 mRNG;
    std::uniform_real_distribution<float> mDist;
    float mHoldValue = 0.0f;
    unsigned int mLastPhase = 0;

    void updatePhaseIncrement();
    float generateWaveform(float phase);
    float applyPolarity(float value);
};

/**
 * Modulation parameters
 */
struct ModulationParameters {
    int lfoSource = 0;     // 0=none, 1-6=LFO number
    float depth = 0.0f;    // 0.0-1.0
};

}  // namespace ec2

#endif  // EC2_LFO_H
