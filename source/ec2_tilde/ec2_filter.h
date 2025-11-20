/**
 * ec2_filter.h
 * Biquad filter for per-grain filtering
 * Standalone implementation (replaces Gamma::Biquad)
 */

#ifndef EC2_FILTER_H
#define EC2_FILTER_H

#include <cmath>
#include "ec2_constants.h"

namespace ec2 {

/**
 * Biquad filter implementation
 * Direct Form II implementation for efficiency
 */
template <typename T = float>
class Biquad {
public:
  Biquad() { zero(); }

  /**
   * Process one sample
   */
  T operator()(T input) {
    // Direct Form II
    T w = input - a1 * d1 - a2 * d2;
    T output = b0 * w + b1 * d1 + b2 * d2;

    // Update delay line
    d2 = d1;
    d1 = w;

    return output;
  }

  /**
   * Set filter type and parameters
   */
  void setType(FilterType type, T freq, T sampleRate, T resonance = 0.707f) {
    T omega = 2.0f * M_PI * freq / sampleRate;
    T sinOmega = std::sin(omega);
    T cosOmega = std::cos(omega);

    // Q factor from resonance (0-1)
    T Q = 0.5f + resonance * 49.5f;  // Maps 0-1 to 0.5-50

    T alpha = sinOmega / (2.0f * Q);

    T a0;  // Temporary for normalization

    switch (type) {
      case FILTER_LOWPASS:
        b0 = (1.0f - cosOmega) / 2.0f;
        b1 = 1.0f - cosOmega;
        b2 = b0;
        a0 = 1.0f + alpha;
        a1 = -2.0f * cosOmega;
        a2 = 1.0f - alpha;
        break;

      case FILTER_HIGHPASS:
        b0 = (1.0f + cosOmega) / 2.0f;
        b1 = -(1.0f + cosOmega);
        b2 = b0;
        a0 = 1.0f + alpha;
        a1 = -2.0f * cosOmega;
        a2 = 1.0f - alpha;
        break;

      case FILTER_BANDPASS:
      default:
        b0 = alpha;
        b1 = 0.0f;
        b2 = -alpha;
        a0 = 1.0f + alpha;
        a1 = -2.0f * cosOmega;
        a2 = 1.0f - alpha;
        break;
    }

    // Normalize coefficients
    b0 /= a0;
    b1 /= a0;
    b2 /= a0;
    a1 /= a0;
    a2 /= a0;
  }

  /**
   * Zero out filter state
   */
  void zero() {
    d1 = d2 = 0;
    b0 = b1 = b2 = 0;
    a1 = a2 = 0;
  }

  /**
   * Shorthand for bandpass (most common in EC2)
   */
  void setBandpass(T freq, T sampleRate, T resonance = 0.707f) {
    setType(FILTER_BANDPASS, freq, sampleRate, resonance);
  }

  void setLowpass(T freq, T sampleRate, T resonance = 0.707f) {
    setType(FILTER_LOWPASS, freq, sampleRate, resonance);
  }

  void setHighpass(T freq, T sampleRate, T resonance = 0.707f) {
    setType(FILTER_HIGHPASS, freq, sampleRate, resonance);
  }

private:
  // Filter coefficients (Direct Form II)
  T b0, b1, b2;  // Feedforward
  T a1, a2;      // Feedback (a0 normalized to 1)
  T d1, d2;      // Delay line

  enum FilterType {
    FILTER_LOWPASS,
    FILTER_HIGHPASS,
    FILTER_BANDPASS
  };
};

}  // namespace ec2

#endif  // EC2_FILTER_H
