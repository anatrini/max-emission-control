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

TEST(test_lfo_processblock_average_advances_phase) {
  ec2::LFO lfo;
  lfo.setSampleRate(48000.0f);
  lfo.setFrequency(1.0f);
  lfo.setShape(ec2::LFOShape::SINE);
  lfo.setPolarity(ec2::LFOPolarity::BIPOLAR);

  // Process the same number of samples both ways and verify same result
  ec2::LFO lfo2;
  lfo2.setSampleRate(48000.0f);
  lfo2.setFrequency(1.0f);
  lfo2.setShape(ec2::LFOShape::SINE);
  lfo2.setPolarity(ec2::LFOPolarity::BIPOLAR);

  // processBlockAverage must advance phase by numFrames samples
  float avg = lfo.processBlockAverage(512);
  float last = 0.0f;
  for (int i = 0; i < 512; ++i) last = lfo2.process();

  // Both LFOs should now be at the same phase (same number of samples processed)
  EXPECT_NEAR(lfo.getCurrentValue(), lfo2.getCurrentValue(), 0.001f);
  // Average over a sub-period should be non-trivially different from last value
  // (it is an average, not the last sample - we just check it's a valid float)
  EXPECT_TRUE(std::isfinite(avg));
  pass();
}

TEST(test_lfo_max_frequency_clamped) {
  ec2::LFO lfo;
  lfo.setSampleRate(48000.0f);
  lfo.setFrequency(10000.0f);  // Should be clamped to 100 Hz
  EXPECT_NEAR(lfo.getFrequency(), 100.0f, 0.001f);
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

TEST(test_voice_pool_process_buffer) {
  // Test that processActiveVoices (per-buffer) accumulates output correctly
  ec2::VoicePool pool(4);

  auto buf = std::make_shared<ec2::AudioBuffer<float>>();
  buf->frames = 4096;
  buf->channels = 1;
  buf->size = 4096;
  buf->data = new float[4096];
  // Fill with a simple DC signal
  for (int i = 0; i < 4096; ++i) buf->data[i] = 0.5f;

  std::atomic<int> counter{0};

  ec2::Grain* g = pool.getFreeVoice();
  EXPECT_TRUE(g != nullptr);

  ec2::GrainParameters params;
  params.sourceBuffer = buf;
  params.currentIndex = 0.0f;
  params.transposition = 1.0f;
  params.durationMs = 100.0f;  // 100 ms
  params.envelope = 0.5f;
  params.pan = 0.0f;
  params.amplitudeDb = -6.0f;
  params.filterFreq = 1000.0f;
  params.resonance = 0.0f;
  params.activeVoiceCount = &counter;
  params.useMultichannelGains = false;
  counter.store(1);

  g->configure(params, 48000.0f);

  // processBuffer over 512 frames
  float out0[512] = {};
  float out1[512] = {};
  float* outBuffers[2] = { out0, out1 };

  bool active = g->processBuffer(outBuffers, 2, 512);
  EXPECT_TRUE(active);  // 100ms grain should survive a 512-sample (~10ms) buffer

  // Output should be non-zero (we have a non-zero source and non-zero envelope)
  bool hasOutput = false;
  for (int i = 0; i < 512; ++i) {
    if (out0[i] != 0.0f || out1[i] != 0.0f) { hasOutput = true; break; }
  }
  EXPECT_TRUE(hasOutput);
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
// Filter coefficient caching tests
// ---------------------------------------------------------------------------

TEST(test_filter_zerostate_preserves_coefficients) {
  ec2::Biquad<float> f;
  f.setBandpassQ(1000.0f, 48000.0f, 10.0f);

  // Feed signal to build up state and get a steady-state output
  float steady = 0.0f;
  for (int i = 0; i < 1000; ++i) steady = f(0.5f);

  // zeroState() should clear delay lines only
  f.zeroState();
  float after_zero = f(0.0f);  // With no input, output should be ~0 (state cleared)
  EXPECT_NEAR(after_zero, 0.0f, 1e-4f);

  // Re-feeding should produce non-zero output again (coefficients intact)
  float after_refeed = 0.0f;
  for (int i = 0; i < 500; ++i) after_refeed = f(0.5f);
  EXPECT_TRUE(std::abs(after_refeed) > 1e-4f);
  pass();
}

TEST(test_grain_filter_cache_skips_recompute) {
  // Confirm that a grain configured twice with identical filter params
  // produces the same steady-state output (cache hit: same coefficients).
  auto buf = std::make_shared<ec2::AudioBuffer<float>>();
  buf->frames = 8192;
  buf->channels = 1;
  buf->size = 8192;
  buf->data = new float[8192];
  for (int i = 0; i < 8192; ++i) buf->data[i] = 0.5f;

  std::atomic<int> counter{1};

  auto makeParams = [&]() {
    ec2::GrainParameters p;
    p.sourceBuffer = buf;
    p.currentIndex = 0.0f;
    p.transposition = 1.0f;
    p.durationMs = 200.0f;
    p.envelope = 0.5f;
    p.pan = 0.0f;
    p.amplitudeDb = -6.0f;
    p.filterFreq = 2000.0f;
    p.resonance = 0.5f;  // Non-zero: filter active
    p.activeVoiceCount = &counter;
    p.useMultichannelGains = false;
    return p;
  };

  ec2::Grain grain;
  ec2::GrainParameters p = makeParams();
  grain.configure(p, 48000.0f);

  float out0a[256] = {}, out1a[256] = {};
  float* bufsA[2] = { out0a, out1a };
  grain.processBuffer(bufsA, 2, 256);

  // Reconfigure with same params (cache hit) — reset grain first via pool
  ec2::VoicePool pool(4);
  ec2::Grain* g = pool.getFreeVoice();
  counter.store(1);
  g->configure(makeParams(), 48000.0f);

  float out0b[256] = {}, out1b[256] = {};
  float* bufsB[2] = { out0b, out1b };
  g->processBuffer(bufsB, 2, 256);

  // Outputs should be approximately equal (same coefficients)
  EXPECT_NEAR(out0a[128], out0b[128], 1e-3f);
  pass();
}

// ---------------------------------------------------------------------------
// Async / Sequenced stream scheduler tests
// ---------------------------------------------------------------------------

TEST(test_scheduler_async_streams_higher_density) {
  // N async streams at rate R should produce approximately N×R triggers/sec
  ec2::GrainScheduler sched(48000.0);
  sched.configure(10.0, 0.0, 0.0);
  sched.setPolyStream(ec2::ASYNCHRONOUS, 4);

  int triggers = 0;
  for (int i = 0; i < 48000; ++i) {
    triggers += sched.triggerCount();
  }
  // 4 streams × 10 Hz = ~40 triggers/sec (allow wide tolerance for phase randomness)
  EXPECT_TRUE(triggers >= 25 && triggers <= 55);
  pass();
}

TEST(test_scheduler_sequenced_fires_at_base_rate) {
  // SEQUENCED with N streams fires at the base rate (not N× the rate)
  ec2::GrainScheduler sched(48000.0);
  sched.configure(10.0, 0.0, 0.0);
  sched.setPolyStream(ec2::SEQUENCED, 4);

  int triggers = 0;
  for (int i = 0; i < 48000; ++i) {
    triggers += sched.triggerCount();
  }
  // 1 stream path × 10 Hz = 10 triggers/sec
  EXPECT_EQ(triggers, 10);
  pass();
}

TEST(test_scheduler_synchronous_still_works) {
  // Regression: SYNCHRONOUS with N streams via triggerCount() must produce N×R
  ec2::GrainScheduler sched(48000.0);
  sched.configure(10.0, 0.0, 0.0);
  sched.setPolyStream(ec2::SYNCHRONOUS, 3);

  int triggers = 0;
  for (int i = 0; i < 48000; ++i) {
    triggers += sched.triggerCount();
  }
  // 3 streams × 10 Hz = 30 triggers/sec (synchronous: freq×N)
  EXPECT_EQ(triggers, 30);
  pass();
}

// ---------------------------------------------------------------------------
// Stream ID cycling in engine
// ---------------------------------------------------------------------------

TEST(test_engine_stream_id_cycles) {
  // With streams=3, SYNCHRONOUS, verify that grains are emitted and
  // the engine doesn't crash (stream ID cycling is internal).
  ec2::GranularEngine engine(64);
  engine.initialize(48000.0f);

  auto buf = std::make_shared<ec2::AudioBuffer<float>>();
  buf->frames = 4096;
  buf->channels = 1;
  buf->size = 4096;
  buf->data = new float[4096]();
  for (int i = 0; i < 4096; ++i) buf->data[i] = 0.1f;
  engine.setAudioBuffer(buf, 0);

  ec2::SynthParameters p;
  p.grainRate = 100.0f;
  p.streams = 3;
  p.streamType = ec2::SYNCHRONOUS;
  engine.updateParameters(p);

  float out[512] = {};
  float* outs[1] = { out };
  for (int block = 0; block < 5; ++block) {
    engine.process(outs, 1, 512);
  }
  // Just verify no crash and voice count stays sane
  EXPECT_TRUE(engine.getActiveVoiceCount() >= 0);
  EXPECT_TRUE(engine.getActiveVoiceCount() <= 64);
  pass();
}

TEST(test_engine_async_streams) {
  // ASYNCHRONOUS mode: engine should emit grains without crashing
  ec2::GranularEngine engine(128);
  engine.initialize(48000.0f);

  auto buf = std::make_shared<ec2::AudioBuffer<float>>();
  buf->frames = 4096;
  buf->channels = 1;
  buf->size = 4096;
  buf->data = new float[4096]();
  for (int i = 0; i < 4096; ++i) buf->data[i] = 0.1f;
  engine.setAudioBuffer(buf, 0);

  ec2::SynthParameters p;
  p.grainRate = 10.0f;
  p.streams = 4;
  p.streamType = ec2::ASYNCHRONOUS;
  engine.updateParameters(p);

  float out[512] = {};
  float* outs[1] = { out };
  for (int block = 0; block < 10; ++block) {
    engine.process(outs, 1, 512);
  }
  EXPECT_TRUE(engine.getActiveVoiceCount() >= 0);
  EXPECT_TRUE(engine.getActiveVoiceCount() <= 128);
  pass();
}

// ---------------------------------------------------------------------------
// Distance spatial allocator tests
// ---------------------------------------------------------------------------

TEST(test_spatial_distance_mode_gain_attenuation) {
  ec2::SpatialAllocator alloc;
  ec2::SpatialParameters params;
  params.mode = ec2::AllocationMode::DISTANCE;
  params.numChannels = 8;
  params.pitchMin = 20.0f;
  params.pitchMax = 20000.0f;
  params.nearClip = 1.0f;
  params.farClip = 100.0f;
  params.distanceAttenuation = 2.0f;
  alloc.updateParameters(params);

  // High spectral centroid → near → high gain
  ec2::GrainMetadata near_grain;
  near_grain.grainIndex = 0;
  near_grain.emissionTime = 0.0f;
  near_grain.pitch = 10000.0f;
  near_grain.spectralCentroid = 15000.0f;  // High: near listener

  // Low spectral centroid → far → low gain
  ec2::GrainMetadata far_grain;
  far_grain.grainIndex = 1;
  far_grain.emissionTime = 0.0f;
  far_grain.pitch = 100.0f;
  far_grain.spectralCentroid = 100.0f;  // Low: far from listener

  ec2::PanningVector pv_near = alloc.allocate(near_grain);
  ec2::PanningVector pv_far  = alloc.allocate(far_grain);

  // Find peak gain for each
  float gain_near = 0.0f, gain_far = 0.0f;
  for (int ch = 0; ch < ec2::MAX_AUDIO_OUTS; ++ch) {
    if (pv_near.gains[ch] > gain_near) gain_near = pv_near.gains[ch];
    if (pv_far.gains[ch] > gain_far)   gain_far  = pv_far.gains[ch];
  }

  // Near grain should be louder than far grain
  EXPECT_TRUE(gain_near > gain_far);
  // Far grain gain should be greater than 0 (still audible)
  EXPECT_TRUE(gain_far > 0.0f);
  pass();
}

TEST(test_spatial_distance_all_channels_valid) {
  ec2::SpatialAllocator alloc;
  ec2::SpatialParameters params;
  params.mode = ec2::AllocationMode::DISTANCE;
  params.numChannels = 4;
  params.pitchMin = 20.0f;
  params.pitchMax = 20000.0f;
  params.nearClip = 0.1f;
  params.farClip = 50.0f;
  params.distanceAttenuation = 1.0f;
  alloc.updateParameters(params);

  for (int i = 0; i < 8; ++i) {
    ec2::GrainMetadata meta;
    meta.grainIndex = i;
    meta.emissionTime = 0.0f;
    meta.pitch = 440.0f;
    meta.spectralCentroid = 440.0f + i * 500.0f;
    ec2::PanningVector pv = alloc.allocate(meta);
    // Each allocation should have at least one channel with non-negative gain
    float sum = 0.0f;
    for (float g : pv.gains) sum += g;
    EXPECT_TRUE(sum >= 0.0f);
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
  RUN(test_lfo_processblock_average_advances_phase);
  RUN(test_lfo_max_frequency_clamped);

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
  RUN(test_voice_pool_process_buffer);

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

  printf("\nFilter coefficient caching\n");
  RUN(test_filter_zerostate_preserves_coefficients);
  RUN(test_grain_filter_cache_skips_recompute);

  printf("\nAsync / Sequenced streams\n");
  RUN(test_scheduler_async_streams_higher_density);
  RUN(test_scheduler_sequenced_fires_at_base_rate);
  RUN(test_scheduler_synchronous_still_works);

  printf("\nStream routing\n");
  RUN(test_engine_stream_id_cycles);
  RUN(test_engine_async_streams);

  printf("\nDistance spatial allocator\n");
  RUN(test_spatial_distance_mode_gain_attenuation);
  RUN(test_spatial_distance_all_channels_valid);

  printf("\nLine\n");
  RUN(test_line_reaches_target);

  printf("\n============================================================\n");
  printf("Results: %d passed, %d failed\n\n", g_pass, g_fail);

  return (g_fail == 0) ? 0 : 1;
}
