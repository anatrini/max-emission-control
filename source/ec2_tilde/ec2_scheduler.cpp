/**
 * ec2_scheduler.cpp
 * Implementation of grain emission scheduler
 * Adapted from EmissionControl2 for Max/MSP
 */

#include "ec2_scheduler.h"
#include <algorithm>
#include <iostream>

namespace ec2 {

GrainScheduler::GrainScheduler(double samplingRate)
  : mUniformDist(0.0, 1.0),
    mSamplingRate(samplingRate) {
  // Seed random number generator
  std::random_device rd;
  mRng.seed(rd());
}

void GrainScheduler::setSamplingRate(double samplingRate) {
  mSamplingRate = samplingRate;
  // Recalculate increment
  mIncrement = mFrequency / mSamplingRate;
}

void GrainScheduler::configure(double frequency, double async, double intermittence) {
  // Clamp async to [0, 1]
  if (async > 1.0) {
    async = 1.0;
  } else if (async < 0.0) {
    async = 0.0;
  }

  // Clamp intermittence to [0, 1]
  if (intermittence > 1.0) {
    intermittence = 1.0;
  } else if (intermittence < 0.0) {
    intermittence = 0.0;
  }

  mAsync = async;
  mFrequency = frequency;
  mIntermittence = intermittence;
  mIncrement = mFrequency / mSamplingRate;
}

bool GrainScheduler::trigger() {
  if (mCounter >= 1.0) {
    mCounter -= 1.0;

    // Check intermittency - randomly drop grains
    if (uniform() < mIntermittence) {
      return false;
    }

    // Add asynchronicity - random timing jitter
    mCounter += uniform(-mAsync, mAsync);
    mCounter += mIncrement;

    return true;
  }

  mCounter += mIncrement;
  return false;
}

void GrainScheduler::setFrequency(double frequency) {
  configure(frequency, mAsync, mIntermittence);
}

void GrainScheduler::setAsynchronicity(double async) {
  configure(mFrequency, async, mIntermittence);
}

void GrainScheduler::setIntermittence(double intermittence) {
  configure(mFrequency, mAsync, intermittence);
}

void GrainScheduler::setPolyStream(StreamType type, int numStreams) {
  if (type == SYNCHRONOUS) {
    setFrequency(static_cast<double>(mFrequency * numStreams));
  } else {
    std::cerr << "ec2~: Non-synchronous stream types not implemented yet" << std::endl;
  }
}

double GrainScheduler::uniform() {
  return mUniformDist(mRng);
}

double GrainScheduler::uniform(double min, double max) {
  return min + (max - min) * mUniformDist(mRng);
}

}  // namespace ec2
