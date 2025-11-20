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

  // Remove from active list
  auto it = std::find(mActiveVoices.begin(), mActiveVoices.end(), voice);
  if (it != mActiveVoices.end()) {
    mActiveVoices.erase(it);
    mActiveVoiceCount--;
  }

  // Reset grain state
  voice->reset();

  // Return to free list
  mFreeList.push_back(voice);
}

void VoicePool::processActiveVoices(float** outBuffers, int numChannels, int numFrames) {
  // Process each active grain
  // We iterate backwards so we can safely remove finished grains
  for (int i = static_cast<int>(mActiveVoices.size()) - 1; i >= 0; --i) {
    Grain* grain = mActiveVoices[i];

    for (int frame = 0; frame < numFrames; ++frame) {
      // Prepare per-frame output pointers
      float* frameOutputs[MAX_AUDIO_OUTS];
      for (int ch = 0; ch < numChannels; ++ch) {
        frameOutputs[ch] = &outBuffers[ch][frame];
      }

      // Process grain (multichannel or stereo)
      bool isActive = grain->processMultichannel(frameOutputs, numChannels);

      if (!isActive) {
        // Grain finished - release it
        releaseVoice(grain);
        break;  // Don't process more frames for this grain
      }
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

}  // namespace ec2
