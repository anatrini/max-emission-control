/**
 * ec2_engine.h
 * Main granular synthesis engine
 * Coordinates scheduler, voice pool, and parameters
 */

#ifndef EC2_ENGINE_H
#define EC2_ENGINE_H

#include <memory>
#include <vector>
#include "ec2_constants.h"
#include "ec2_scheduler.h"
#include "ec2_voice_pool.h"
#include "ec2_grain.h"
#include "ec2_utility.h"
#include "ec2_spatial_allocator.h"
#include "ec2_lfo.h"

namespace ec2 {

// Maximum number of LFOs
constexpr int MAX_LFOS = 6;

/**
 * Synthesis parameters
 * Simple struct for now - will be connected to min-devkit attributes
 */
struct SynthParameters {
  // Grain scheduling
  float grainRate = 20.0f;       // Hz
  float async = 0.0f;            // 0-1
  float intermittency = 0.0f;    // 0-1
  int streams = 1;               // 1-20

  // Grain characteristics
  float playbackRate = 1.0f;     // -32 to 32
  float grainDuration = 100.0f;  // ms
  float envelope = 0.5f;         // 0-1

  // Spatial
  float pan = 0.0f;              // -1 to 1 [legacy stereo]
  float amplitude = -6.0f;       // dB

  // Filtering
  float filterFreq = 1000.0f;    // Hz
  float resonance = 0.0f;        // 0-1

  // Scanning (for later implementation)
  float scanBegin = 0.0f;        // 0-1
  float scanRange = 1.0f;        // 0-1
  float scanSpeed = 1.0f;        // -32 to 32

  // Sound file selection
  int soundFile = 0;             // Buffer index

  // Multichannel spatial allocation (Phase 5)
  SpatialParameters spatial;     // Spatial allocator parameters

  // Modulation routing (Phase 9)
  ModulationParameters modGrainRate;
  ModulationParameters modAsync;
  ModulationParameters modIntermittency;
  ModulationParameters modStreams;
  ModulationParameters modPlaybackRate;
  ModulationParameters modGrainDuration;
  ModulationParameters modEnvelope;
  ModulationParameters modFilterFreq;
  ModulationParameters modResonance;
  ModulationParameters modPan;
  ModulationParameters modAmplitude;
  ModulationParameters modScanBegin;
  ModulationParameters modScanRange;
  ModulationParameters modScanSpeed;
};

/**
 * Main granular synthesis engine
 * Manages grain emission, voice allocation, and audio processing
 */
class GranularEngine {
public:
  GranularEngine(size_t maxVoices = 2048);

  /**
   * Initialize engine with sample rate
   */
  void initialize(float sampleRate);

  /**
   * Set sample rate (call from dspsetup)
   */
  void setSampleRate(float sampleRate);

  /**
   * Get current sample rate
   */
  float getSampleRate() const { return mSampleRate; }

  /**
   * Set audio buffer for grain playback
   * @param buffer - Shared pointer to audio buffer
   * @param index - Buffer index (for multiple buffers)
   */
  void setAudioBuffer(std::shared_ptr<AudioBuffer<float>> buffer, int index = 0);

  /**
   * Get current audio buffer
   */
  std::shared_ptr<AudioBuffer<float>> getAudioBuffer(int index = 0);

  /**
   * Update synthesis parameters
   */
  void updateParameters(const SynthParameters& params);

  /**
   * Get current parameters
   */
  const SynthParameters& getParameters() const { return mParams; }

  /**
   * Get mutable reference to parameters (for modulation routing)
   */
  SynthParameters& getParameters() { return mParams; }

  /**
   * Process audio
   * @param outBuffers - Array of output buffers (one per channel)
   * @param numChannels - Number of output channels
   * @param numFrames - Number of frames to process
   */
  void process(float** outBuffers, int numChannels, int numFrames);

  /**
   * Stop all active grains
   */
  void stopAllGrains();

  /**
   * Get number of active voices
   */
  int getActiveVoiceCount() const { return mVoicePool.getActiveVoiceCount(); }

  /**
   * Get LFO by index (0-5)
   */
  LFO* getLFO(int index);

  /**
   * Process all LFOs (call once per audio callback)
   */
  void processLFOs();

  /**
   * Apply modulation to a parameter value
   * @param baseValue - The base parameter value
   * @param modParams - Modulation parameters (source LFO + depth)
   * @param minValue - Minimum allowed value
   * @param maxValue - Maximum allowed value
   * @return Modulated value
   */
  float applyModulation(float baseValue, const ModulationParameters& modParams,
                       float minValue, float maxValue);

private:
  VoicePool mVoicePool;
  GrainScheduler mScheduler;
  SpatialAllocator mSpatialAllocator;  // Phase 5: Multichannel allocation
  SynthParameters mParams;

  std::vector<std::shared_ptr<AudioBuffer<float>>> mAudioBuffers;

  float mSampleRate = DEFAULT_SAMPLE_RATE;
  float mCurrentScanIndex = 0.0f;
  Line<double> mScanner;  // For scan position control (Phase 5)

  int mActiveVoiceCount = 0;
  float mGrainEmissionTime = 0.0f;  // Track time for spatial allocator

  // LFO system (Phase 9)
  LFO mLFOs[MAX_LFOS];
  float mLFOValues[MAX_LFOS];  // Current LFO values (updated once per audio callback)
};

}  // namespace ec2

#endif  // EC2_ENGINE_H
