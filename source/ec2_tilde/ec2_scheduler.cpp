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

int GrainScheduler::triggerCount() {
  if (mStreamType == ASYNCHRONOUS) {
    // N independent counters, each at the base frequency with random phase.
    int count = 0;
    for (auto& cnt : mAsyncCounters) {
      cnt += mIncrement;
      if (cnt >= 1.0) {
        cnt -= 1.0;
        if (uniform() < mIntermittence) continue;  // Drop this stream's trigger
        cnt += uniform(-mAsync, mAsync);
        ++count;
      }
    }
    return count;
  }

  // SYNCHRONOUS (mIncrement = freq*N/sr) and SEQUENCED (mIncrement = freq/sr):
  // single main counter.
  if (mCounter >= 1.0) {
    mCounter -= 1.0;
    if (uniform() < mIntermittence) {
      return 0;
    }
    mCounter += uniform(-mAsync, mAsync);
    mCounter += mIncrement;
    return 1;
  }

  mCounter += mIncrement;
  return 0;
}

bool GrainScheduler::trigger() {
  return triggerCount() > 0;
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
  mStreamType = type;
  mNumStreams = std::max(1, numStreams);

  if (type == SYNCHRONOUS) {
    // Multiply the increment so N streams all fire within the same timing cycle
    mIncrement = mFrequency * mNumStreams / mSamplingRate;
  } else if (type == ASYNCHRONOUS) {
    // Each stream runs at the base frequency with an independent random phase
    mIncrement = mFrequency / mSamplingRate;
    if (static_cast<int>(mAsyncCounters.size()) != mNumStreams) {
      mAsyncCounters.resize(mNumStreams);
      for (auto& cnt : mAsyncCounters) {
        cnt = uniform(0.0, 1.0);  // Randomise initial phase for each stream
      }
    }
  } else if (type == SEQUENCED) {
    // Single trigger at base frequency; engine cycles streamId per emission
    mIncrement = mFrequency / mSamplingRate;
  }
}

double GrainScheduler::uniform() {
  return mUniformDist(mRng);
}

double GrainScheduler::uniform(double min, double max) {
  return min + (max - min) * mUniformDist(mRng);
}

}  // namespace ec2
