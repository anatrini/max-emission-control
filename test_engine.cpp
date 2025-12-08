#include "ec2_engine.h"
#include "ec2_utility.h"
#include <iostream>
#include <vector>
#include <cmath>

int main() {
    std::cout << "=== EC2 Engine Standalone Test ===" << std::endl;

    // Create engine
    ec2::GranularEngine engine(2048);
    engine.initialize(48000.0f);

    std::cout << "Engine initialized with sample rate: " << engine.getSampleRate() << std::endl;

    // Create test audio buffer (1 second of 440Hz sine wave)
    auto testBuffer = std::make_shared<ec2::AudioBuffer<float>>();
    testBuffer->channels = 2;
    testBuffer->frames = 48000;
    testBuffer->size = testBuffer->frames * testBuffer->channels;
    testBuffer->data = new float[testBuffer->size];

    // Fill with sine wave
    for (unsigned i = 0; i < testBuffer->frames; ++i) {
        float sample = 0.5f * std::sin(2.0f * M_PI * 440.0f * i / 48000.0f);
        testBuffer->data[i * 2] = sample;  // Left
        testBuffer->data[i * 2 + 1] = sample;  // Right
    }

    std::cout << "Created test buffer: " << testBuffer->frames << " frames, "
              << testBuffer->channels << " channels" << std::endl;

    engine.setAudioBuffer(testBuffer, 0);

    // Configure parameters to match Max test
    ec2::SynthParameters params;
    params.grainRate = 20.0f;
    params.grainDuration = 100.0f;
    params.amplitude = 0.5f;  // Match Max: 0.5
    params.playbackRate = 1.0f;
    params.streams = 20;  // Match Max: 20 streams
    params.spatial.numChannels = 2;

    std::cout << "Parameters set: grainRate=" << params.grainRate
              << ", duration=" << params.grainDuration
              << ", amplitude=" << params.amplitude << std::endl;

    engine.updateParameters(params);

    // Process one buffer (512 samples)
    const int numFrames = 512;
    const int numChannels = 2;
    float* outBuffers[2];
    outBuffers[0] = new float[numFrames];
    outBuffers[1] = new float[numFrames];

    // Initialize to zero
    for (int i = 0; i < numFrames; ++i) {
        outBuffers[0][i] = 0.0f;
        outBuffers[1][i] = 0.0f;
    }

    std::cout << "\nProcessing " << numFrames << " frames..." << std::endl;
    engine.process(outBuffers, numChannels, numFrames);

    // Check output
    float maxSample = 0.0f;
    int nonZeroSamples = 0;
    for (int ch = 0; ch < numChannels; ++ch) {
        for (int i = 0; i < numFrames; ++i) {
            float abs_sample = std::abs(outBuffers[ch][i]);
            if (abs_sample > maxSample) {
                maxSample = abs_sample;
            }
            if (abs_sample > 0.0001f) {
                nonZeroSamples++;
            }
        }
    }

    std::cout << "\n=== RESULTS ===" << std::endl;
    std::cout << "Active voices: " << engine.getActiveVoiceCount() << std::endl;
    std::cout << "Max sample value: " << maxSample << std::endl;
    std::cout << "Non-zero samples: " << nonZeroSamples << " / " << (numFrames * numChannels) << std::endl;

    if (maxSample > 0.0001f) {
        std::cout << "\n✓ SUCCESS: Audio generated!" << std::endl;
        return 0;
    } else {
        std::cout << "\n✗ FAILURE: No audio output!" << std::endl;
        return 1;
    }
}
