/**
 * ec2_voice_pool.cpp
 * Implementation of voice pool allocator
 */

#include "ec2_voice_pool.h"
#include <algorithm>

namespace ec2 {

VoicePool::VoicePool(size_t maxVoices)
  : mMaxVoices(maxVoices) {

  // Pre-allocate all grain voices
  mGrains.reserve(maxVoices);
  mFreeList.reserve(maxVoices);
  mActiveVoices.reserve(maxVoices);

  for (size_t i = 0; i < maxVoices; ++i) {
    mGrains.push_back(std::make_unique<Grain>());
    mFreeList.push_back(mGrains[i].get());
  }
}

Grain* VoicePool::getFreeVoice() {
  if (mFreeList.empty()) {
    return nullptr;  // Pool exhausted
  }

  // Pop from free list
  Grain* voice = mFreeList.back();
  mFreeList.pop_back();

  // Add to active list
  mActiveVoices.push_back(voice);
  mActiveVoiceCount++;

  return voice;
}

void VoicePool::releaseVoice(Grain* voice) {
  if (!voice) return;

  // Swap-and-pop: O(1) removal (order in active list is not significant)
  auto it = std::find(mActiveVoices.begin(), mActiveVoices.end(), voice);
  if (it != mActiveVoices.end()) {
    *it = mActiveVoices.back();
    mActiveVoices.pop_back();
    mActiveVoiceCount--;
  }

  // Reset grain state
  voice->reset();

  // Return to free list
  mFreeList.push_back(voice);
}

void VoicePool::processActiveVoices(float** outBuffers, int numChannels, int numFrames) {
  // Grain-major processing: each grain processes the entire buffer before moving to the next.
  // Eliminates per-frame stack allocation (previously MAX_AUDIO_OUTS pointers × numFrames).
  for (int i = static_cast<int>(mActiveVoices.size()) - 1; i >= 0; --i) {
    Grain* grain = mActiveVoices[i];
    bool stillActive = grain->processBuffer(outBuffers, numChannels, numFrames);
    if (!stillActive) {
      releaseVoice(grain);
    }
  }
}

void VoicePool::stopAll() {
  // Release all active voices
  while (!mActiveVoices.empty()) {
    releaseVoice(mActiveVoices.back());
  }
  mActiveVoiceCount = 0;
}

void VoicePool::getGrainPositions(std::vector<float>& positions, int maxCount,
                                   float bufferFrames, float& minPos, float& maxPos) const {
  positions.clear();

  if (mActiveVoices.empty() || bufferFrames <= 0.0f) {
    minPos = 0.0f;
    maxPos = 0.0f;
    return;
  }

  // Initialize min/max tracking
  minPos = 1.0f;
  maxPos = 0.0f;

  int count = 0;
  for (const Grain* grain : mActiveVoices) {
    if (!grain) continue;

    // Get source index and normalize to 0-1
    float sourceIndex = grain->getSourceIndex();
    float normalizedPos = sourceIndex / bufferFrames;

    // Clamp to valid range
    normalizedPos = std::max(0.0f, std::min(1.0f, normalizedPos));

    // Track min/max
    if (normalizedPos < minPos) minPos = normalizedPos;
    if (normalizedPos > maxPos) maxPos = normalizedPos;

    // Add to positions vector (up to maxCount)
    if (count < maxCount) {
      positions.push_back(normalizedPos);
      count++;
    }
  }

  // If no valid positions were found, reset min/max
  if (positions.empty()) {
    minPos = 0.0f;
    maxPos = 0.0f;
  }
}

}  // namespace ec2
