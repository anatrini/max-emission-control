/**
 * ec2_spatial_allocator.cpp
 * Implementation of multichannel spatial allocation strategies
 */

#include "ec2_spatial_allocator.h"
#include <algorithm>
#include <limits>

namespace ec2 {

SpatialAllocator::SpatialAllocator() {
  mActiveCount.fill(0);
  mRng.seed(mParams.randSeed);
}

void SpatialAllocator::updateParameters(const SpatialParameters& params) {
  // Re-seed RNG if seed changed
  if (params.randSeed != mParams.randSeed) {
    mRng.seed(params.randSeed);
  }

  mParams = params;

  // Validate and clamp channel list
  for (int& ch : mParams.channelList) {
    ch = std::clamp(ch, 0, MAX_AUDIO_OUTS - 1);
  }
}

void SpatialAllocator::reset() {
  mLastChannel = 0;
  mActiveCount.fill(0);
  mTrajectoryPhase = mParams.trajOffset;
  mLastRandomChannel = 0.0f;
  mGrainCounter = 0;
}

PanningVector SpatialAllocator::allocate(const GrainMetadata& grain) {
  mGrainCounter++;

  switch (mParams.mode) {
    case AllocationMode::FIXED:
      return allocateFixed(grain);
    case AllocationMode::ROUNDROBIN:
      return allocateRoundRobin(grain);
    case AllocationMode::RANDOM:
      return allocateRandom(grain);
    case AllocationMode::WEIGHTED:
      return allocateWeighted(grain);
    case AllocationMode::LOADBALANCE:
      return allocateLoadBalance(grain);
    case AllocationMode::PITCHMAP:
      return allocatePitchmap(grain);
    case AllocationMode::TRAJECTORY:
      return allocateTrajectory(grain);
    case AllocationMode::DISTANCE:
      return allocateDistance(grain);
    default:
      return PanningVector();  // Silent
  }
}

void SpatialAllocator::releaseGrain(const std::vector<int>& channels) {
  for (int ch : channels) {
    if (ch >= 0 && ch < MAX_AUDIO_OUTS) {
      mActiveCount[ch] = std::max(0, mActiveCount[ch] - 1);
    }
  }
}

// ============================================================================
// MODE: Fixed
// ============================================================================

PanningVector SpatialAllocator::allocateFixed(const GrainMetadata& grain) {
  PanningVector pv;

  int ch = std::clamp(mParams.fixedChannel, 0, MAX_AUDIO_OUTS - 1);
  pv.gains[ch] = 1.0f;

  if (mParams.dualChannel) {
    int ch2 = std::clamp(mParams.fixedChannel2, 0, MAX_AUDIO_OUTS - 1);
    pv.gains[ch2] = 1.0f;
    pv.normalizeEnergy();
  }

  mActiveCount[ch]++;
  if (mParams.dualChannel) {
    mActiveCount[mParams.fixedChannel2]++;
  }

  return pv;
}

// ============================================================================
// MODE: Round-robin
// ============================================================================

PanningVector SpatialAllocator::allocateRoundRobin(const GrainMetadata& grain) {
  PanningVector pv;

  if (mParams.channelList.empty()) {
    return pv;
  }

  // Get next channel in sequence
  int listSize = static_cast<int>(mParams.channelList.size());
  int nextIndex = (mLastChannel + mParams.roundRobinStep) % listSize;
  int ch = mParams.channelList[nextIndex];

  // Apply jitter if enabled
  std::uniform_real_distribution<float> dist01(0.0f, 1.0f);
  if (mParams.jitterProb > 0.0f && dist01(mRng) < mParams.jitterProb) {
    ch = applyJitter(ch);
  }

  // Assign to channel
  ch = std::clamp(ch, 0, MAX_AUDIO_OUTS - 1);
  pv.gains[ch] = 1.0f;
  mActiveCount[ch]++;

  // Update state
  mLastChannel = nextIndex;

  return pv;
}

// ============================================================================
// MODE: Random (uniform)
// ============================================================================

PanningVector SpatialAllocator::allocateRandom(const GrainMetadata& grain) {
  PanningVector pv;

  if (mParams.channelList.empty()) {
    return pv;
  }

  // Apply spatial correlation
  float targetChannel;
  std::uniform_real_distribution<float> dist01(0.0f, 1.0f);

  if (mParams.spatialCorr > 0.0f && mGrainCounter > 1) {
    // Blend between last channel and new random choice
    float randomChannel = dist01(mRng) * mParams.channelList.size();
    targetChannel = mParams.spatialCorr * mLastRandomChannel +
                   (1.0f - mParams.spatialCorr) * randomChannel;
  } else {
    // Pure random
    targetChannel = dist01(mRng) * mParams.channelList.size();
  }

  mLastRandomChannel = targetChannel;

  // Convert to channel indices
  if (mParams.spread > 0.0f) {
    // Pan between adjacent channels
    int idx = static_cast<int>(std::floor(targetChannel));
    idx = std::clamp(idx, 0, static_cast<int>(mParams.channelList.size()) - 1);

    int chL = mParams.channelList[idx];
    int chR = mParams.channelList[(idx + 1) % mParams.channelList.size()];

    float alpha = targetChannel - std::floor(targetChannel);
    alpha *= mParams.spread;  // Scale by spread amount

    panBetweenChannels(pv, chL, chR, alpha);
    mActiveCount[chL]++;
    mActiveCount[chR]++;
  } else {
    // Hard assignment
    int idx = static_cast<int>(std::round(targetChannel));
    idx = std::clamp(idx, 0, static_cast<int>(mParams.channelList.size()) - 1);
    int ch = mParams.channelList[idx];

    pv.gains[ch] = 1.0f;
    mActiveCount[ch]++;
  }

  return pv;
}

// ============================================================================
// MODE: Weighted random
// ============================================================================

PanningVector SpatialAllocator::allocateWeighted(const GrainMetadata& grain) {
  PanningVector pv;

  if (mParams.channelList.empty()) {
    return pv;
  }

  // Create cumulative distribution from weights
  std::vector<float> cumulativeWeights;
  cumulativeWeights.reserve(mParams.channelList.size());

  float cumSum = 0.0f;
  for (int ch : mParams.channelList) {
    cumSum += mParams.weights[ch];
    cumulativeWeights.push_back(cumSum);
  }

  // Normalize
  if (cumSum > 0.0f) {
    for (float& w : cumulativeWeights) {
      w /= cumSum;
    }
  }

  // Sample from distribution
  std::uniform_real_distribution<float> dist01(0.0f, 1.0f);
  float u = dist01(mRng);

  // Find channel
  int selectedIdx = 0;
  for (size_t i = 0; i < cumulativeWeights.size(); ++i) {
    if (u <= cumulativeWeights[i]) {
      selectedIdx = static_cast<int>(i);
      break;
    }
  }

  int ch = mParams.channelList[selectedIdx];

  // Apply spread if enabled
  if (mParams.spread > 0.0f && selectedIdx + 1 < static_cast<int>(mParams.channelList.size())) {
    int chR = mParams.channelList[selectedIdx + 1];
    float alpha = mParams.spread * 0.5f;  // Gentle spread
    panBetweenChannels(pv, ch, chR, alpha);
    mActiveCount[ch]++;
    mActiveCount[chR]++;
  } else {
    pv.gains[ch] = 1.0f;
    mActiveCount[ch]++;
  }

  return pv;
}

// ============================================================================
// MODE: Load-balance
// ============================================================================

PanningVector SpatialAllocator::allocateLoadBalance(const GrainMetadata& grain) {
  PanningVector pv;

  if (mParams.channelList.empty()) {
    return pv;
  }

  // Find minimum active count among allowed channels
  int minCount = std::numeric_limits<int>::max();
  std::vector<int> candidates;

  for (int ch : mParams.channelList) {
    // Skip if over max active threshold
    if (mParams.maxActivePerChannel > 0 &&
        mActiveCount[ch] >= mParams.maxActivePerChannel) {
      continue;
    }

    if (mActiveCount[ch] < minCount) {
      minCount = mActiveCount[ch];
      candidates.clear();
      candidates.push_back(ch);
    } else if (mActiveCount[ch] == minCount) {
      candidates.push_back(ch);
    }
  }

  if (candidates.empty()) {
    // All channels at max - fall back to first available
    candidates.push_back(mParams.channelList[0]);
  }

  // Resolve tie
  int ch;
  if (candidates.size() == 1) {
    ch = candidates[0];
  } else {
    if (mParams.tieBreak == TieBreakMode::RANDOM) {
      std::uniform_int_distribution<int> dist(0, static_cast<int>(candidates.size()) - 1);
      ch = candidates[dist(mRng)];
    } else {  // ROUNDROBIN
      // Use last channel to pick next in round-robin fashion
      auto it = std::find(candidates.begin(), candidates.end(), mLastChannel);
      if (it != candidates.end()) {
        ch = candidates[(std::distance(candidates.begin(), it) + 1) % candidates.size()];
      } else {
        ch = candidates[0];
      }
    }
  }

  pv.gains[ch] = 1.0f;
  mActiveCount[ch]++;
  mLastChannel = ch;

  return pv;
}

// ============================================================================
// MODE: Pitchmap
// ============================================================================

PanningVector SpatialAllocator::allocatePitchmap(const GrainMetadata& grain) {
  PanningVector pv;

  if (mParams.channelList.empty()) {
    return pv;
  }

  // Normalize pitch to [0, 1]
  float pitch = grain.pitch;
  float u;

  if (mParams.pitchLogCurve) {
    // Logarithmic mapping
    float logPitch = std::log2(std::max(pitch, 1.0f));
    float logMin = std::log2(mParams.pitchMin);
    float logMax = std::log2(mParams.pitchMax);
    u = (logPitch - logMin) / (logMax - logMin);
  } else {
    // Linear mapping
    u = (pitch - mParams.pitchMin) / (mParams.pitchMax - mParams.pitchMin);
  }

  u = std::clamp(u, 0.0f, 1.0f);

  // Map to continuous channel index
  float idx = u * (mParams.channelList.size() - 1);

  // Apply jitter
  if (mParams.pitchJitter > 0.0f) {
    std::normal_distribution<float> dist(0.0f, mParams.pitchJitter);
    idx += dist(mRng);
    idx = std::clamp(idx, 0.0f, static_cast<float>(mParams.channelList.size() - 1));
  }

  // Get channels and pan
  int chL_idx = static_cast<int>(std::floor(idx));
  int chR_idx = std::min(chL_idx + 1, static_cast<int>(mParams.channelList.size()) - 1);

  int chL = mParams.channelList[chL_idx];
  int chR = mParams.channelList[chR_idx];

  float alpha = idx - std::floor(idx);

  panBetweenChannels(pv, chL, chR, alpha);
  mActiveCount[chL]++;
  if (chL != chR) {
    mActiveCount[chR]++;
  }

  return pv;
}

// ============================================================================
// MODE: Trajectory
// ============================================================================

PanningVector SpatialAllocator::allocateTrajectory(const GrainMetadata& grain) {
  PanningVector pv;

  if (mParams.channelList.empty()) {
    return pv;
  }

  // Evaluate trajectory at grain emission time
  float pos = evaluateTrajectory(grain.emissionTime);

  // Apply depth (proportion of array covered)
  float centerOffset = (1.0f - mParams.trajDepth) * 0.5f;
  pos = centerOffset + pos * mParams.trajDepth;

  // Map to continuous channel index
  float idx = pos * (mParams.channelList.size() - 1);

  // Get channels and pan
  int chL_idx = static_cast<int>(std::floor(idx));
  int chR_idx = (chL_idx + 1) % mParams.channelList.size();  // Wrap around

  int chL = mParams.channelList[chL_idx];
  int chR = mParams.channelList[chR_idx];

  float alpha = idx - std::floor(idx);

  panBetweenChannels(pv, chL, chR, alpha);
  mActiveCount[chL]++;
  mActiveCount[chR]++;

  return pv;
}

// ============================================================================
// MODE: Distance (3D position-based)
// ============================================================================

PanningVector SpatialAllocator::allocateDistance(const GrainMetadata& grain) {
  PanningVector pv;

  // TODO Phase 5b: Implement 3D distance-based allocation
  // For now, fall back to random
  return allocateRandom(grain);
}

// ============================================================================
// Helper functions
// ============================================================================

void SpatialAllocator::panBetweenChannels(PanningVector& pv, int chL, int chR, float alpha) {
  // Constant-power panning
  alpha = std::clamp(alpha, 0.0f, 1.0f);

  float angleL = (1.0f - alpha) * M_PI * 0.5f;
  float angleR = alpha * M_PI * 0.5f;

  pv.gains[chL] = std::cos(angleR);
  pv.gains[chR] = std::sin(angleR);
}

float SpatialAllocator::getContinuousChannelIndex(float normalizedPos) {
  if (mParams.channelList.empty()) {
    return 0.0f;
  }
  return normalizedPos * (mParams.channelList.size() - 1);
}

int SpatialAllocator::applyJitter(int baseChannel) {
  if (mParams.jitterAmount <= 0.0f) {
    return baseChannel;
  }

  std::normal_distribution<float> dist(0.0f, mParams.jitterAmount);
  float jitter = dist(mRng);
  int newChannel = baseChannel + static_cast<int>(std::round(jitter));

  // Keep within allowed channels
  if (!mParams.channelList.empty()) {
    newChannel = std::clamp(newChannel, 0, static_cast<int>(mParams.channelList.size()) - 1);
    return mParams.channelList[newChannel];
  }

  return std::clamp(newChannel, 0, MAX_AUDIO_OUTS - 1);
}

bool SpatialAllocator::isChannelAllowed(int ch) const {
  if (mParams.channelList.empty()) {
    return ch >= 0 && ch < mParams.numChannels;
  }
  return std::find(mParams.channelList.begin(), mParams.channelList.end(), ch) !=
         mParams.channelList.end();
}

float SpatialAllocator::evaluateTrajectory(float time) {
  // Compute phase based on rate and time
  float phase = mParams.trajOffset + mParams.trajRate * time;
  phase = std::fmod(phase, 1.0f);  // Wrap to [0, 1]

  float pos = 0.0f;

  switch (mParams.trajShape) {
    case TrajectoryShape::SINE:
      pos = 0.5f + 0.5f * std::sin(phase * 2.0f * M_PI);
      break;

    case TrajectoryShape::SAW:
      pos = phase;
      break;

    case TrajectoryShape::TRIANGLE:
      pos = (phase < 0.5f) ? (2.0f * phase) : (2.0f * (1.0f - phase));
      break;

    case TrajectoryShape::RANDOMWALK: {
      // Simple random walk - advance trajectory phase with random steps
      std::uniform_real_distribution<float> dist(-0.1f, 0.1f);
      mTrajectoryPhase += dist(mRng);
      mTrajectoryPhase = std::clamp(mTrajectoryPhase, 0.0f, 1.0f);
      pos = mTrajectoryPhase;
      break;
    }

    case TrajectoryShape::CUSTOM:
      // TODO: Allow user-defined trajectory function
      pos = phase;
      break;
  }

  return std::clamp(pos, 0.0f, 1.0f);
}

}  // namespace ec2
