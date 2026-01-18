/**
 * ec2_voice_pool.h
 * Voice pool allocator for grain management
 * Replaces al::PolySynth with custom free-list allocation
 */

#ifndef EC2_VOICE_POOL_H
#define EC2_VOICE_POOL_H

#include <vector>
#include <memory>
#include "ec2_grain.h"

namespace ec2 {

/**
 * Voice pool for managing grain allocation
 * Uses free-list pattern for efficient allocation/deallocation
 */
class VoicePool {
public:
  /**
   * Constructor
   * @param maxVoices - Maximum number of simultaneous grains (default 2048)
   */
  VoicePool(size_t maxVoices = 2048);

  /**
   * Get a free grain voice from the pool
   * @return Pointer to free grain, or nullptr if pool exhausted
   */
  Grain* getFreeVoice();

  /**
   * Release a grain voice back to the pool
   */
  void releaseVoice(Grain* voice);

  /**
   * Get number of active voices
   */
  int getActiveVoiceCount() const { return mActiveVoiceCount; }

  /**
   * Get maximum voice capacity
   */
  size_t getMaxVoices() const { return mMaxVoices; }

  /**
   * Process all active grains
   * @param outBuffers - Array of output buffers (one per channel)
   * @param numChannels - Number of output channels
   * @param numFrames - Number of frames to process
   */
  void processActiveVoices(float** outBuffers, int numChannels, int numFrames);

  /**
   * Stop all active grains
   */
  void stopAll();

  /**
   * Get positions of active grains
   * @param positions - Vector to fill with normalized positions (0-1)
   * @param maxCount - Maximum number of positions to return
   * @param bufferFrames - Total buffer frames for normalization
   * @param minPos - Output: minimum position found
   * @param maxPos - Output: maximum position found
   */
  void getGrainPositions(std::vector<float>& positions, int maxCount,
                         float bufferFrames, float& minPos, float& maxPos) const;

private:
  std::vector<std::unique_ptr<Grain>> mGrains;  // All grain voices
  std::vector<Grain*> mFreeList;                // Available voices
  std::vector<Grain*> mActiveVoices;            // Currently playing grains

  size_t mMaxVoices;
  int mActiveVoiceCount = 0;
};

}  // namespace ec2

#endif  // EC2_VOICE_POOL_H
