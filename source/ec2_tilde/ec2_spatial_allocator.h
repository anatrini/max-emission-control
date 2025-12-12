/**
 * ec2_spatial_allocator.h
 * Multichannel spatial allocation for grain distribution
 * Based on Roads ("Microsound") principles for spatial granular synthesis
 */

#ifndef EC2_SPATIAL_ALLOCATOR_H
#define EC2_SPATIAL_ALLOCATOR_H

#include <vector>
#include <random>
#include <array>
#include <cmath>
#include "ec2_constants.h"

namespace ec2 {

/**
 * Allocation modes for multichannel grain distribution
 */
enum class AllocationMode {
  FIXED,          // All grains to same channel(s)
  ROUNDROBIN,     // Cyclic sequence through channels
  RANDOM,         // Uniform random channel selection
  WEIGHTED,       // Weighted random distribution
  LOADBALANCE,    // Balance active grains across channels
  PITCHMAP,       // Pitch/spectrum to spatial position
  TRAJECTORY,     // Time-based spatial trajectory
  DISTANCE        // 3D position-based (optional)
};

/**
 * Trajectory shape types
 */
enum class TrajectoryShape {
  SINE,           // Sinusoidal movement
  SAW,            // Sawtooth sweep
  TRIANGLE,       // Triangle wave
  RANDOMWALK,     // Random walk
  SPIRAL,         // Spiral movement (requires spiral_factor parameter)
  PENDULUM,       // Damped pendulum oscillation (requires pendulum_decay parameter)
  CUSTOM          // User-defined
};

/**
 * Tie-break strategy for load-balance mode
 */
enum class TieBreakMode {
  RANDOM,
  ROUNDROBIN
};

/**
 * Grain metadata for allocation decisions
 */
struct GrainMetadata {
  float emissionTime;       // Time of grain emission (seconds)
  float pitch;              // Grain pitch (Hz or MIDI note)
  float spectralCentroid;   // Spectral centroid (Hz)
  int streamId;             // Stream identifier
  int grainIndex;           // Global grain counter
};

/**
 * Spatial allocator parameters
 */
struct SpatialParameters {
  // Mode selection
  AllocationMode mode = AllocationMode::ROUNDROBIN;

  // Channel selection (all modes)
  std::vector<int> channelList;  // Allowed channels subset
  int numChannels = 16;           // Total available channels

  // Fixed mode
  int fixedChannel = 0;
  bool dualChannel = false;
  int fixedChannel2 = 1;

  // Round-robin mode
  int roundRobinStep = 1;
  float jitterProb = 0.0f;        // 0-1
  float jitterAmount = 0.0f;      // in channels

  // Random mode
  float spread = 0.0f;            // 0-1, controls panning vs hard assignment
  float spatialCorr = 0.0f;       // 0-1, correlation between successive grains
  unsigned int randSeed = 12345;

  // Weighted mode
  std::array<float, MAX_AUDIO_OUTS> weights;  // Per-channel weights
  float weightsSmooth = 0.0f;     // Smoothing time constant

  // Load-balance mode
  int maxActivePerChannel = -1;   // -1 = unlimited
  TieBreakMode tieBreak = TieBreakMode::RANDOM;

  // Pitchmap mode
  float pitchMin = 20.0f;         // Hz
  float pitchMax = 20000.0f;      // Hz
  float pitchJitter = 0.0f;       // in channels
  bool pitchLogCurve = true;      // true = log, false = linear

  // Trajectory mode
  TrajectoryShape trajShape = TrajectoryShape::SINE;
  float trajRate = 0.5f;          // Hz
  float trajDepth = 1.0f;         // 0-1, proportion of array covered
  float trajOffset = 0.0f;        // Initial phase (0-1)
  float spiralFactor = 0.0f;      // 0-1, controls spiral tightness (0=circle, 1=tight spiral)
  float pendulumDecay = 0.1f;     // 0-1, damping factor for pendulum motion

  // Distance mode (optional)
  float distanceAttenuation = 2.0f;  // Distance exponent
  float nearClip = 0.1f;
  float farClip = 100.0f;

  // Constructor with default channel list (all 16)
  SpatialParameters() {
    channelList.resize(numChannels);
    for (int i = 0; i < numChannels; ++i) {
      channelList[i] = i;
    }

    // Initialize weights to uniform
    for (int i = 0; i < MAX_AUDIO_OUTS; ++i) {
      weights[i] = 1.0f / MAX_AUDIO_OUTS;
    }
  }
};

/**
 * Panning vector result (16 channels)
 */
struct PanningVector {
  std::array<float, MAX_AUDIO_OUTS> gains;

  PanningVector() {
    gains.fill(0.0f);
  }

  // Normalize to preserve energy (sum of squares = 1)
  void normalizeEnergy() {
    float sumSquares = 0.0f;
    for (float g : gains) {
      sumSquares += g * g;
    }

    if (sumSquares > 0.0f) {
      float scale = 1.0f / std::sqrt(sumSquares);
      for (float& g : gains) {
        g *= scale;
      }
    }
  }

  // Normalize to sum = 1
  void normalizeSum() {
    float sum = 0.0f;
    for (float g : gains) {
      sum += g;
    }

    if (sum > 0.0f) {
      for (float& g : gains) {
        g /= sum;
      }
    }
  }
};

/**
 * Spatial allocator class
 * Assigns grains to output channels with panning gains
 */
class SpatialAllocator {
public:
  SpatialAllocator();

  /**
   * Update allocator parameters
   */
  void updateParameters(const SpatialParameters& params);

  /**
   * Get current parameters
   */
  const SpatialParameters& getParameters() const { return mParams; }

  /**
   * Allocate a grain to channels
   * Returns panning vector with gains for each channel
   */
  PanningVector allocate(const GrainMetadata& grain);

  /**
   * Notify allocator when a grain finishes (for load-balance mode)
   */
  void releaseGrain(const std::vector<int>& channels);

  /**
   * Set sample rate (for trajectory mode timing)
   */
  void setSampleRate(float sr) { mSampleRate = sr; }

  /**
   * Reset internal state
   */
  void reset();

private:
  SpatialParameters mParams;

  // Internal state
  int mLastChannel = 0;                           // Round-robin state
  std::array<int, MAX_AUDIO_OUTS> mActiveCount;  // Load-balance state
  std::mt19937 mRng;                              // Random generator
  float mTrajectoryPhase = 0.0f;                  // Trajectory state
  float mLastRandomChannel = 0.0f;                // For spatial correlation
  float mSampleRate = DEFAULT_SAMPLE_RATE;
  int mGrainCounter = 0;                          // Global grain counter

  // Mode-specific allocation functions
  PanningVector allocateFixed(const GrainMetadata& grain);
  PanningVector allocateRoundRobin(const GrainMetadata& grain);
  PanningVector allocateRandom(const GrainMetadata& grain);
  PanningVector allocateWeighted(const GrainMetadata& grain);
  PanningVector allocateLoadBalance(const GrainMetadata& grain);
  PanningVector allocatePitchmap(const GrainMetadata& grain);
  PanningVector allocateTrajectory(const GrainMetadata& grain);
  PanningVector allocateDistance(const GrainMetadata& grain);

  // Helper: create panning between two adjacent channels
  void panBetweenChannels(PanningVector& pv, int chL, int chR, float alpha);

  // Helper: get continuous channel index from normalized position (0-1)
  float getContinuousChannelIndex(float normalizedPos);

  // Helper: apply jitter to channel index
  int applyJitter(int baseChannel);

  // Helper: check if channel is in allowed list
  bool isChannelAllowed(int ch) const;

  // Helper: evaluate trajectory at given time
  float evaluateTrajectory(float time);
};

}  // namespace ec2

#endif  // EC2_SPATIAL_ALLOCATOR_H
