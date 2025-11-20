/**
 * ec2_scheduler.h
 * Grain emission scheduler for EC2
 * Adapted from EmissionControl2 for Max/MSP
 */

#ifndef EC2_SCHEDULER_H
#define EC2_SCHEDULER_H

#include <random>
#include "ec2_constants.h"

namespace ec2 {

/**
 * Voice scheduler - determines when to trigger new grains
 * Handles grain rate, asynchronicity, and intermittency
 */
class GrainScheduler {
public:
  GrainScheduler(double samplingRate = DEFAULT_SAMPLE_RATE);

  /**
   * Set sampling rate
   */
  void setSamplingRate(double samplingRate);

  /**
   * Configure all scheduler parameters
   * @param frequency - Grain emission rate in Hz
   * @param async - Asynchronicity (0-1): randomizes trigger timing
   * @param intermittence - Intermittency (0-1): probability of dropping grains
   */
  void configure(double frequency, double async, double intermittence);

  /**
   * Call at audio rate - returns true when a grain should be triggered
   */
  bool trigger();

  /**
   * Set frequency (grain rate in Hz)
   */
  void setFrequency(double frequency);

  /**
   * Set asynchronicity (0-1)
   * Randomly triggers grains within a window
   * 0 = completely synchronous, 1 = completely asynchronous
   * Does NOT affect density of emission
   */
  void setAsynchronicity(double async);

  /**
   * Set intermittency (0-1)
   * Probability of dropping a grain
   * 0 = no drops, 1 = all grains dropped
   * DOES affect density of emission
   */
  void setIntermittence(double intermittence);

  /**
   * Set number of parallel grain streams
   * For synchronous streams, multiplies the frequency
   */
  void setPolyStream(StreamType type, int numStreams);

private:
  std::mt19937 mRng;  // Random number generator
  std::uniform_real_distribution<double> mUniformDist;

  double mCounter{1.0};
  double mSamplingRate;
  double mAsync{0.0};
  double mFrequency{1.0};
  double mIncrement{0.0};
  double mIntermittence{0.0};

  // Helper: generate uniform random value
  double uniform();
  double uniform(double min, double max);
};

}  // namespace ec2

#endif  // EC2_SCHEDULER_H
