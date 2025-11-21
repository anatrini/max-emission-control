/**
 * ec2_grain.h
 * Individual grain voice for granular synthesis
 * Adapted from EmissionControl2 for Max/MSP
 */

#ifndef EC2_GRAIN_H
#define EC2_GRAIN_H

#include "ec2_constants.h"
#include "ec2_envelope.h"
#include "ec2_filter.h"
#include "ec2_utility.h"
#include <array>
#include <cmath>
#include <memory>

namespace ec2 {

/**
 * Simplified grain parameters structure
 */
struct GrainParameters {
  std::shared_ptr<AudioBuffer<float>> sourceBuffer; // Audio buffer to read from
  float currentIndex;    // Starting position in buffer
  float transposition;   // Playback rate
  float durationMs;      // Grain duration in milliseconds
  float envelope;        // Envelope shape (0-1)
  float pan;             // Pan position (-1 to 1) [legacy stereo]
  float amplitudeDb;     // Amplitude in dB
  float filterFreq;      // Filter center frequency
  float resonance;       // Filter resonance (0-1)
  int *activeVoiceCount; // Pointer to active voice counter

  // Multichannel spatial allocation (Phase 5)
  std::array<float, MAX_AUDIO_OUTS>
      channelGains;                  // Per-channel gains from spatial allocator
  bool useMultichannelGains = false; // true = use channelGains, false = use pan
};

/**
 * Grain voice - individual grain for granular synthesis
 * Handles playback, envelope, filtering, and panning
 */
class Grain {
public:
  Grain();

  /**
   * Configure grain parameters before triggering
   */
  void configure(const GrainParameters &params, float sampleRate);

  /**
   * Process one frame of audio (stereo legacy mode)
   * @param outLeft  - Output for left channel
   * @param outRight - Output for right channel
   * @return true if grain is still active, false if done
   */
  bool process(float &outLeft, float &outRight);

  /**
   * Process one frame of audio (multichannel mode)
   * @param outputs - Array of output channel pointers
   * @param numChannels - Number of output channels
   * @return true if grain is still active, false if done
   */
  bool processMultichannel(float **outputs, int numChannels);

  /**
   * Check if grain has finished
   */
  bool isDone() const { return mEnvelope.isDone(); }

  /**
   * Get current playback position in source buffer
   */
  float getSourceIndex() const { return mSourceIndex; }

  /**
   * Get grain duration in seconds
   */
  float getDuration() const { return mDurationS; }

  /**
   * Mark grain as inactive (for voice pool management)
   */
  void reset();

private:
  // Source buffer
  std::shared_ptr<AudioBuffer<float>> mSource;

  // Playback control
  Line<double> mPlaybackIndex;
  float mSourceIndex = 0.0f;
  float mDurationS = 0.1f;
  float mSampleRate = DEFAULT_SAMPLE_RATE;

  // Envelope
  GrainEnvelope mEnvelope;

  // Filtering (3-stage cascade: BPF -> Resonant -> BPF)
  Biquad<float> mBpf1L, mBpf1R; // Stage 1: Bandpass
  Biquad<float> mBpf2L, mBpf2R; // Stage 2: Resonant (logarithmic)
  Biquad<float> mBpf3L, mBpf3R; // Stage 3: Bandpass
  bool mBypassFilter = true;
  float mCascadeFilterMix = 0.0f;

  // Amplitude and panning
  float mAmp = 0.707f;
  float mLeftGain = 0.707f;
  float mRightGain = 0.707f;
  static constexpr float PAN_CONST = 0.707106781f; // sqrt(2)/2

  // Multichannel gains (Phase 5)
  std::array<float, MAX_AUDIO_OUTS> mChannelGains;
  bool mUseMultichannelGains = false;

  // Active voice tracking
  int *mActiveVoiceCount = nullptr;

  // Temp variables for interpolation
  float mBefore, mAfter, mDecimal;
  int mPrevSampleRate = -1;

  // Configuration helpers
  void configurePlayback(float startIndex, float transposition);
  void configureAmplitude(float dbIn, int voiceCount);
  void configurePan(float pan, float amp);
  void configureFilter(float freq, float resonance, int sourceChannels);
  void initFilters(float sampleRate);

  // Processing helpers
  float filterSample(float sample, float cascadeMix, bool isRightChannel);

  template <int SourceChannels, bool FilterActive>
  bool processTemplate(float &outLeft, float &outRight);

  template <int SourceChannels, bool FilterActive>
  bool processMultichannelTemplate(float **outputs, int numChannels);
};

} // namespace ec2

#endif // EC2_GRAIN_H
