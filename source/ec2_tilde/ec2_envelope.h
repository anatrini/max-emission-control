/**
 * ec2_envelope.h
 * Grain envelope generator with morphing between envelope shapes
 * Adapted from EmissionControl2 for Max/MSP
 */

#ifndef EC2_ENVELOPE_H
#define EC2_ENVELOPE_H

#include "ec2_utility.h"
#include "ec2_constants.h"

namespace ec2 {

/**
 * Grain envelope that morphs between three envelope types:
 * - Exponential decay (mEnvelope = 0)
 * - Tukey window (mEnvelope = 0.5)
 * - Reverse exponential / growth (mEnvelope = 1)
 */
class GrainEnvelope {
public:
  GrainEnvelope(float duration = 1.0f, float envelope = 0.5f);

  void setSamplingRate(float samplingRate);
  float getSamplingRate() const { return mSamplingRate; }

  /**
   * Generate envelope value at current time
   * Call once per sample
   */
  float operator()();

  /**
   * Set envelope shape (0-1)
   * 0-0.5: interpolates between expo decay and tukey
   * 0.5-1: interpolates between tukey and reverse expo
   */
  void setEnvelope(float envelope);

  /**
   * Set duration in seconds
   */
  void setDuration(float duration);

  /**
   * Convenience: set both duration and envelope
   */
  void set(float duration, float envelope);

  /**
   * Reset envelope to beginning
   */
  void reset();

  /**
   * Check if envelope has completed
   */
  bool isDone() const;

  float getEnvelope() const { return mEnvelope; }
  float getDuration() const { return mDuration; }

private:
  float mSamplingRate = DEFAULT_SAMPLE_RATE;
  Expo mExpoEnv;     // Exponential decay
  Tukey mTukeyEnv;   // Tukey window
  Expo mRExpoEnv;    // Reverse exponential (growth)
  float mEnvelope = 0.5f;  // Envelope shape parameter (0-1)
  float mDuration = 1.0f;  // Duration in seconds
};

}  // namespace ec2

#endif  // EC2_ENVELOPE_H
