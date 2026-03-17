/**
 * test_components.cpp
 * Unit tests for ec2~ engine components (no Max SDK dependency)
 *
 * Run:
 *   mkdir build_tests && cd build_tests
 *   cmake .. -DEC2_BUILD_TESTS=ON && cmake --build . --target ec2_tests
 *   ./tests/ec2_tests
 */

#include "ec2_scheduler.h"
#include "ec2_lfo.h"
#include "ec2_envelope.h"
#include "ec2_filter.h"
#include "ec2_grain.h"
#include "ec2_voice_pool.h"
#include "ec2_engine.h"
#include "ec2_spatial_allocator.h"
#include "ec2_utility.h"

#include <atomic>
#include <cassert>
#include <cmath>
#include <cstdio>
#include <memory>
#include <vector>

// ---------------------------------------------------------------------------
// Minimal test harness
// ---------------------------------------------------------------------------

static int g_pass = 0;
static int g_fail = 0;

#define TEST(name) void name()
#define RUN(name)  do { printf("  %-50s", #name); name(); printf("PASS\n"); } while(0)

#define EXPECT_TRUE(cond) \
  do { if (!(cond)) { printf("FAIL  [%s:%d] %s\n", __FILE__, __LINE__, #cond); ++g_fail; return; } } while(0)
#define EXPECT_NEAR(a, b, tol) \
  do { if (std::fabs((a)-(b)) > (tol)) { \
    printf("FAIL  [%s:%d] |%s - %s| = %f > %f\n", __FILE__, __LINE__, #a, #b, std::fabs((a)-(b)), (double)(tol)); \
    ++g_fail; return; } } while(0)
#define EXPECT_EQ(a, b) \
  do { if ((a) != (b)) { printf("FAIL  [%s:%d] %s (%d) != %s (%d)\n", __FILE__, __LINE__, #a, (int)(a), #b, (int)(b)); ++g_fail; return; } } while(0)

static void pass() { ++g_pass; }

// ---------------------------------------------------------------------------
// GrainScheduler tests
// ---------------------------------------------------------------------------

TEST(test_scheduler_triggers_at_expected_rate) {
  ec2::GrainScheduler sched(48000.0);
  sched.configure(10.0, 0.0, 0.0);  // 10 Hz, no async, no intermittency

  int triggers = 0;
  for (int i = 0; i < 48000; ++i) {
    if (sched.trigger()) ++triggers;
  }
  // At 10 Hz over 1 second we expect exactly 10 triggers (synchronous)
  EXPECT_EQ(triggers, 10);
  pass();
}

TEST(test_scheduler_intermittency_reduces_triggers) {
  ec2::GrainScheduler sched(48000.0);
  sched.configure(100.0, 0.0, 1.0);  // 100 Hz, 100% intermittency = no grains

  int triggers = 0;
  for (int i = 0; i < 48000; ++i) {
    if (sched.trigger()) ++triggers;
  }
  EXPECT_EQ(triggers, 0);
  pass();
}

TEST(test_scheduler_async_does_not_change_density) {
  // Asynchronicity changes timing but not density (total count within tolerance)
  ec2::GrainScheduler sched(48000.0);
  sched.configure(20.0, 1.0, 0.0);  // 20 Hz, max async

  int triggers = 0;
  for (int i = 0; i < 48000; ++i) {
    if (sched.trigger()) ++triggers;
  }
  // With async the count can vary slightly but should be near 20
  EXPECT_TRUE(triggers >= 15 && triggers <= 25);
  pass();
}

// ---------------------------------------------------------------------------
// LFO tests
// ---------------------------------------------------------------------------

TEST(test_lfo_sine_range_bipolar) {
  ec2::LFO lfo;
  lfo.setSampleRate(48000.0f);
  lfo.setFrequency(1.0f);
  lfo.setShape(ec2::LFOShape::SINE);
  lfo.setPolarity(ec2::LFOPolarity::BIPOLAR);

  float minVal = 1.0f, maxVal = -1.0f;
  for (int i = 0; i < 48000; ++i) {
    float v = lfo.process();
    if (v < minVal) minVal = v;
    if (v > maxVal) maxVal = v;
  }
  // Over 1 full period the sine should span roughly [-1, 1]
  EXPECT_TRUE(minVal < -0.9f);
  EXPECT_TRUE(maxVal > 0.9f);
  pass();
}

TEST(test_lfo_unipolar_pos_non_negative) {
  ec2::LFO lfo;
  lfo.setSampleRate(48000.0f);
  lfo.setFrequency(1.0f);
  lfo.setShape(ec2::LFOShape::SINE);
  lfo.setPolarity(ec2::LFOPolarity::UNIPOLAR_POS);

  for (int i = 0; i < 48000; ++i) {
    float v = lfo.process();
    EXPECT_TRUE(v >= -0.001f);
  }
  pass();
}

TEST(test_lfo_unipolar_neg_non_positive) {
  ec2::LFO lfo;
  lfo.setSampleRate(48000.0f);
  lfo.setFrequency(1.0f);
  lfo.setShape(ec2::LFOShape::SINE);
  lfo.setPolarity(ec2::LFOPolarity::UNIPOLAR_NEG);

  for (int i = 0; i < 48000; ++i) {
    float v = lfo.process();
    EXPECT_TRUE(v <= 0.001f);
  }
  pass();
}

TEST(test_lfo_frequency_change) {
  ec2::LFO lfo;
  lfo.setSampleRate(48000.0f);
  lfo.setFrequency(2.0f);
  lfo.setShape(ec2::LFOShape::SINE);
  lfo.setPolarity(ec2::LFOPolarity::BIPOLAR);

  int zeroCrossings = 0;
  float prev = 0.0f;
  for (int i = 0; i < 48000; ++i) {
    float v = lfo.process();
    if (prev < 0.0f && v >= 0.0f) ++zeroCrossings;
    prev = v;
  }
  // 2 Hz = 2 complete cycles per second = 2 rising zero-crossings
  EXPECT_TRUE(zeroCrossings >= 1 && zeroCrossings <= 3);
  pass();
}

// ---------------------------------------------------------------------------
// GrainEnvelope tests
// ---------------------------------------------------------------------------

TEST(test_envelope_completes_after_duration) {
  ec2::GrainEnvelope env;
  env.setSamplingRate(48000.0f);
  float durS = 0.1f;
  env.set(durS, 0.5f);
  env.reset();

  int samplesUntilDone = 0;
  while (!env.isDone() && samplesUntilDone < 100000) {
    env();
    ++samplesUntilDone;
  }
  // Should complete within ±10% of expected sample count
  int expected = static_cast<int>(durS * 48000.0f);
  EXPECT_TRUE(samplesUntilDone >= (int)(expected * 0.9));
  EXPECT_TRUE(samplesUntilDone <= (int)(expected * 1.1));
  pass();
}

TEST(test_envelope_starts_near_zero) {
  ec2::GrainEnvelope env;
  env.setSamplingRate(48000.0f);
  env.set(0.1f, 0.5f);
  env.reset();

  // First few samples should be near zero (Tukey window rises from 0)
  float firstSample = env();
  EXPECT_TRUE(firstSample >= 0.0f);
  EXPECT_TRUE(firstSample <= 0.1f);
  pass();
}

// ---------------------------------------------------------------------------
// Biquad filter tests
// ---------------------------------------------------------------------------

TEST(test_filter_zero_clears_state) {
  ec2::Biquad<float> f;
  f.setBandpass(1000.0f, 48000.0f, 1.0f);

  // Feed some signal to build up state
  for (int i = 0; i < 100; ++i) f(1.0f);

  f.zero();

  // After zero(), input of 0 should produce 0 output
  float out = f(0.0f);
  EXPECT_NEAR(out, 0.0f, 1e-6f);
  pass();
}

TEST(test_filter_passes_dc_lowpass) {
  ec2::Biquad<float> f;
  f.setLowpass(10000.0f, 48000.0f, 0.0f);  // Wide lowpass

  // Feed DC signal - should pass through
  float out = 0.0f;
  for (int i = 0; i < 1000; ++i) out = f(1.0f);

  EXPECT_NEAR(out, 1.0f, 0.05f);
  pass();
}

// ---------------------------------------------------------------------------
// VoicePool tests
// ---------------------------------------------------------------------------

TEST(test_voice_pool_allocation_and_release) {
  ec2::VoicePool pool(8);

  EXPECT_EQ(pool.getActiveVoiceCount(), 0);

  ec2::Grain* g1 = pool.getFreeVoice();
  EXPECT_TRUE(g1 != nullptr);
  EXPECT_EQ(pool.getActiveVoiceCount(), 1);

  ec2::Grain* g2 = pool.getFreeVoice();
  EXPECT_TRUE(g2 != nullptr);
  EXPECT_EQ(pool.getActiveVoiceCount(), 2);

  pool.releaseVoice(g1);
  EXPECT_EQ(pool.getActiveVoiceCount(), 1);

  pool.releaseVoice(g2);
  EXPECT_EQ(pool.getActiveVoiceCount(), 0);
  pass();
}

TEST(test_voice_pool_exhaustion) {
  ec2::VoicePool pool(4);

  std::vector<ec2::Grain*> voices;
  for (int i = 0; i < 4; ++i) {
    ec2::Grain* g = pool.getFreeVoice();
    EXPECT_TRUE(g != nullptr);
    voices.push_back(g);
  }
  EXPECT_EQ(pool.getActiveVoiceCount(), 4);

  // Pool exhausted - should return nullptr
  ec2::Grain* extra = pool.getFreeVoice();
  EXPECT_TRUE(extra == nullptr);

  // Release one and try again
  pool.releaseVoice(voices[0]);
  ec2::Grain* g = pool.getFreeVoice();
  EXPECT_TRUE(g != nullptr);
  pass();
}

TEST(test_voice_pool_stop_all) {
  ec2::VoicePool pool(8);
  pool.getFreeVoice();
  pool.getFreeVoice();
  pool.getFreeVoice();
  EXPECT_EQ(pool.getActiveVoiceCount(), 3);

  pool.stopAll();
  EXPECT_EQ(pool.getActiveVoiceCount(), 0);
  pass();
}

// ---------------------------------------------------------------------------
// SpatialAllocator tests
// ---------------------------------------------------------------------------

TEST(test_spatial_allocator_roundrobin_cycles) {
  ec2::SpatialAllocator alloc;
  ec2::SpatialParameters params;
  params.mode = ec2::AllocationMode::ROUNDROBIN;
  params.numChannels = 4;
  params.roundRobinStep = 1;
  alloc.updateParameters(params);

  ec2::GrainMetadata meta;
  meta.emissionTime = 0.0f;
  meta.pitch = 440.0f;
  meta.grainIndex = 0;

  // With step=1 and 4 channels: gains should cycle ch0, ch1, ch2, ch3, ch0...
  std::vector<int> peakChannels;
  for (int i = 0; i < 8; ++i) {
    meta.grainIndex = i;
    ec2::PanningVector pv = alloc.allocate(meta);
    // Find which channel has the most energy
    int peak = 0;
    float peakGain = 0.0f;
    for (int ch = 0; ch < 4; ++ch) {
      float g = pv.gains[ch] * pv.gains[ch];
      if (g > peakGain) { peakGain = g; peak = ch; }
    }
    peakChannels.push_back(peak);
  }
  // The first 4 should cover all channels
  bool saw0 = false, saw1 = false, saw2 = false, saw3 = false;
  for (int c : peakChannels) {
    if (c == 0) saw0 = true;
    if (c == 1) saw1 = true;
    if (c == 2) saw2 = true;
    if (c == 3) saw3 = true;
  }
  EXPECT_TRUE(saw0 && saw1 && saw2 && saw3);
  pass();
}

TEST(test_spatial_allocator_fixed_channel) {
  ec2::SpatialAllocator alloc;
  ec2::SpatialParameters params;
  params.mode = ec2::AllocationMode::FIXED;
  params.numChannels = 8;
  params.fixedChannel = 2;  // 0-indexed
  alloc.updateParameters(params);

  ec2::GrainMetadata meta;
  meta.emissionTime = 0.0f;
  meta.pitch = 440.0f;
  meta.grainIndex = 0;

  ec2::PanningVector pv = alloc.allocate(meta);
  // Channel 2 should have non-zero gain, others near zero
  EXPECT_TRUE(pv.gains[2] > 0.5f);
  for (int ch = 0; ch < 8; ++ch) {
    if (ch != 2) EXPECT_NEAR(pv.gains[ch], 0.0f, 0.01f);
  }
  pass();
}

// ---------------------------------------------------------------------------
// GranularEngine tests (without audio processing)
// ---------------------------------------------------------------------------

TEST(test_engine_initialize) {
  ec2::GranularEngine engine(64);
  engine.initialize(48000.0f);
  EXPECT_NEAR(engine.getSampleRate(), 48000.0f, 0.1f);
  EXPECT_EQ(engine.getActiveVoiceCount(), 0);
  pass();
}

TEST(test_engine_parameter_update) {
  ec2::GranularEngine engine(64);
  engine.initialize(48000.0f);

  ec2::SynthParameters p;
  p.grainRate = 30.0f;
  p.grainDuration = 200.0f;
  p.amplitude = -12.0f;
  engine.updateParameters(p);

  EXPECT_NEAR(engine.getParameters().grainRate, 30.0f, 0.001f);
  EXPECT_NEAR(engine.getParameters().grainDuration, 200.0f, 0.001f);
  pass();
}

TEST(test_engine_lfo_access) {
  ec2::GranularEngine engine(64);
  engine.initialize(48000.0f);

  for (int i = 0; i < 6; ++i) {
    ec2::LFO* lfo = engine.getLFO(i);
    EXPECT_TRUE(lfo != nullptr);
  }
  // Out-of-range returns nullptr
  EXPECT_TRUE(engine.getLFO(-1) == nullptr);
  EXPECT_TRUE(engine.getLFO(6) == nullptr);
  pass();
}

TEST(test_engine_silent_without_buffer) {
  ec2::GranularEngine engine(32);
  engine.initialize(48000.0f);

  ec2::SynthParameters p;
  p.grainRate = 200.0f;
  engine.updateParameters(p);

  // No buffer set - process should return silently without crashing
  float out0[64] = {};
  float out1[64] = {};
  float* outBuffers[2] = { out0, out1 };
  engine.process(outBuffers, 2, 64);

  // Output should be zero
  for (int i = 0; i < 64; ++i) {
    EXPECT_NEAR(out0[i], 0.0f, 1e-6f);
    EXPECT_NEAR(out1[i], 0.0f, 1e-6f);
  }
  pass();
}

TEST(test_engine_stop_all_resets_count) {
  ec2::GranularEngine engine(64);
  engine.initialize(48000.0f);

  // Create a dummy audio buffer
  auto buf = std::make_shared<ec2::AudioBuffer<float>>();
  buf->frames = 4096;
  buf->channels = 1;
  buf->size = 4096;
  buf->data = new float[4096]();
  engine.setAudioBuffer(buf, 0);

  ec2::SynthParameters p;
  p.grainRate = 500.0f;  // High rate to ensure grains are emitted
  engine.updateParameters(p);

  float out0[512] = {};
  float* outBuffers[1] = { out0 };
  engine.process(outBuffers, 1, 512);

  engine.stopAllGrains();
  EXPECT_EQ(engine.getActiveVoiceCount(), 0);
  pass();
}

TEST(test_engine_atomic_voice_count) {
  // Verify mActiveVoiceCount behaves correctly via getActiveVoiceCount()
  ec2::GranularEngine engine(16);
  engine.initialize(48000.0f);
  EXPECT_EQ(engine.getActiveVoiceCount(), 0);

  auto buf = std::make_shared<ec2::AudioBuffer<float>>();
  buf->frames = 8192;
  buf->channels = 1;
  buf->size = 8192;
  buf->data = new float[8192]();
  for (int i = 0; i < 8192; ++i) buf->data[i] = 0.1f;
  engine.setAudioBuffer(buf, 0);

  ec2::SynthParameters p;
  p.grainRate = 100.0f;
  p.grainDuration = 10.0f;  // 10 ms grains - will finish quickly
  engine.updateParameters(p);

  // Process several buffers
  float out[512] = {};
  float* outBuffers[1] = { out };
  for (int block = 0; block < 10; ++block) {
    engine.process(outBuffers, 1, 512);
    int count = engine.getActiveVoiceCount();
    EXPECT_TRUE(count >= 0);
    EXPECT_TRUE(count <= 16);
  }

  pass();
}

// ---------------------------------------------------------------------------
// Line (ramp generator) tests
// ---------------------------------------------------------------------------

TEST(test_line_reaches_target) {
  ec2::Line<float> line;
  line.setSamplingRate(48000.0f);
  line.set(0.0f, 1.0f, 1.0f);  // Ramp from 0 to 1 in 1 second

  float val = 0.0f;
  for (int i = 0; i < 48000; ++i) val = line();

  EXPECT_NEAR(val, 1.0f, 0.01f);
  pass();
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

int main() {
  printf("\nec2~ component tests\n");
  printf("============================================================\n");

  printf("\nGrainScheduler\n");
  RUN(test_scheduler_triggers_at_expected_rate);
  RUN(test_scheduler_intermittency_reduces_triggers);
  RUN(test_scheduler_async_does_not_change_density);

  printf("\nLFO\n");
  RUN(test_lfo_sine_range_bipolar);
  RUN(test_lfo_unipolar_pos_non_negative);
  RUN(test_lfo_unipolar_neg_non_positive);
  RUN(test_lfo_frequency_change);

  printf("\nGrainEnvelope\n");
  RUN(test_envelope_completes_after_duration);
  RUN(test_envelope_starts_near_zero);

  printf("\nBiquad Filter\n");
  RUN(test_filter_zero_clears_state);
  RUN(test_filter_passes_dc_lowpass);

  printf("\nVoicePool\n");
  RUN(test_voice_pool_allocation_and_release);
  RUN(test_voice_pool_exhaustion);
  RUN(test_voice_pool_stop_all);

  printf("\nSpatialAllocator\n");
  RUN(test_spatial_allocator_roundrobin_cycles);
  RUN(test_spatial_allocator_fixed_channel);

  printf("\nGranularEngine\n");
  RUN(test_engine_initialize);
  RUN(test_engine_parameter_update);
  RUN(test_engine_lfo_access);
  RUN(test_engine_silent_without_buffer);
  RUN(test_engine_stop_all_resets_count);
  RUN(test_engine_atomic_voice_count);

  printf("\nLine\n");
  RUN(test_line_reaches_target);

  printf("\n============================================================\n");
  printf("Results: %d passed, %d failed\n\n", g_pass, g_fail);

  return (g_fail == 0) ? 0 : 1;
}
