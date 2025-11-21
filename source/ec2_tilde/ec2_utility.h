/**
 * ec2_utility.h
 * Utility classes for EC2 granular synthesis
 * Adapted from EmissionControl2 for Max/MSP (standalone, no allolib
 * dependencies)
 */

#ifndef EC2_UTILITY_H
#define EC2_UTILITY_H

#include "ec2_constants.h"
#include <cmath>
#include <iostream>
#include <memory>
#include <string>
#include <vector>

namespace ec2 {

/**
 * Fast trigonometric lookup table
 */
class FastTrig {
public:
  void buildTrigTable();
  float getCosImpliedPiFactor(float x);

private:
  static const int CIRCLE = 1024;
  static const int MASK_CIRCLE = CIRCLE - 1;
  static const int HALF_CIRCLE = CIRCLE / 2;
  static const int QUARTER_CIRCLE = CIRCLE / 4;
  static float COS_TABLE[CIRCLE];
  static bool tableBuilt;
};

/**
 * Line generator - moves from one value to another over time
 */
template <typename T> class Line {
public:
  Line() : mSamplingRate(DEFAULT_SAMPLE_RATE) {}
  Line(T samplingRate) : mSamplingRate(samplingRate) {}

  T operator()() {
    if (value != target) {
      value += increment;
      if ((increment < 0) ? (value < target) : (value > target)) {
        value = target;
      }
    }
    return value;
  }

  void set(T v = 0, T t = 0, T s = 1) {
    value = v;
    start = v;
    target = t;
    seconds = s;
    if (seconds <= 0)
      seconds = 1.0 / mSamplingRate;
    increment = (target - value) / (seconds * mSamplingRate);
  }

  void setSamplingRate(T samplingRate) { mSamplingRate = samplingRate; }
  T getSamplingRate() const { return mSamplingRate; }
  T getIncrement() const { return increment; }
  T getStart() const { return start; }
  T getValue() const { return value; }
  T getTarget() const { return target; }
  bool isDone() const { return value == target; }

private:
  T value = 0, start = 0, target = 0, seconds = 1, increment = 0;
  T mSamplingRate;
};

/**
 * Exponential envelope generator
 */
class Expo {
public:
  float operator()();

  void setSamplingRate(float samplingRate) { mSamplingRate = samplingRate; }
  float getSamplingRate() const { return mSamplingRate; }

  void reset();
  void set(float seconds, bool reverse, float threshold);
  void set(float seconds, bool reverse);
  void set(float seconds);

  bool isDone() const { return mX == 0; }
  void increment() { mX += mIncrementX; }

private:
  float mIncrementX = 0;
  float mX = 0;
  float mY = 0.001f;
  float mThresholdX = -1.0f * std::log(0.001f);
  float mThresholdY = 0.001f;
  float mSamplingRate = DEFAULT_SAMPLE_RATE;
  bool mReverse = false;
  int mTotalS = 1;

  // Optimization: Recursive multiplication
  float mMultiplier = 1.0f;
  int mCurrentPhase = 0; // 0: Attack, 1: Decay/Sustain, 2: Release
};

/**
 * Tukey window envelope generator
 */
class Tukey {
public:
  Tukey() { fastTrig.buildTrigTable(); }

  float operator()();

  void setSamplingRate(float samplingRate) { mSamplingRate = samplingRate; }
  float getSamplingRate() const { return mSamplingRate; }

  void reset();
  void set(float seconds, float alpha);
  void set(float seconds);

  bool isDone() const { return totalS == currentS; }
  void increment() { currentS++; }

private:
  float value = 0;
  float alpha = 0.6f;
  float mSamplingRate = DEFAULT_SAMPLE_RATE;
  int currentS = 0;
  int totalS = 1;
  float alphaTotalS = 0;
  FastTrig fastTrig;
};

/**
 * Audio buffer with interpolation
 * This will be adapted to interface with Max buffer~ API
 */
template <typename T> class AudioBuffer {
public:
  T *data = nullptr;
  unsigned size = 0;
  int channels = 1;
  unsigned frames = 0;
  std::string filePath;

  virtual ~AudioBuffer() {
    if (data)
      delete[] data;
  }

  void deleteBuffer() {
    if (data)
      delete[] data;
    data = nullptr;
    size = 0;
  }

  T &operator[](unsigned index) { return data[index]; }
  T operator[](const T index) const { return get(index); }

  T get(unsigned index) const { return (index < size) ? data[index] : 0; }

  void resize(unsigned n) {
    if (data)
      delete[] data;
    size = n;
    if (n == 0) {
      data = nullptr;
    } else {
      data = new T[n];
      for (unsigned i = 0; i < n; ++i) {
        data[i] = 0;
      }
    }
  }

  /**
   * Get interpolated value at fractional index
   */
  T getInterpolated(float index) const {
    if (size == 0)
      return 0;

    // Wrap index
    while (index < 0)
      index += size;
    while (index >= size)
      index -= size;

    return raw(index);
  }

  T raw(const float index) const {
    const unsigned i = static_cast<unsigned>(std::floor(index));
    const T x0 = data[i];
    const T x1 = data[(i >= (size - channels)) ? 0 : i + channels];
    const T t = index - i;
    return x1 * t + x0 * (1 - t);
  }

  /**
   * Add value at fractional index (for granular synthesis)
   */
  void add(const float index, const T value) {
    if (size == 0)
      return;

    const unsigned i = static_cast<unsigned>(std::floor(index));
    const unsigned j = (i >= (size - channels)) ? 0 : i + channels;
    const float t = index - i;
    data[i] += value * (1 - t);
    data[j] += value * t;
  }
};

/**
 * Helper function to convert dB to linear amplitude
 */
inline float dbToLinear(float db) { return std::pow(10.0f, db / 20.0f); }

/**
 * Helper function to convert linear amplitude to dB
 */
inline float linearToDb(float linear) { return 20.0f * std::log10(linear); }

/**
 * Map a normalized value [0,1] to a range [min, max]
 * with optional logarithmic scaling
 */
inline float mapRange(float val, float min, float max, bool isLog = false) {
  if (isLog) {
    float logMin = std::log(min);
    float logMax = std::log(max);
    return std::exp(logMin + val * (logMax - logMin));
  }
  return min + val * (max - min);
}

} // namespace ec2

#endif // EC2_UTILITY_H
