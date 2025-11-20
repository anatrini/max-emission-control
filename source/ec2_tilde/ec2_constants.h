/**
 * ec2_constants.h
 * Constants for EC2 granular synthesis engine
 * Adapted from EmissionControl2 for Max/MSP
 */

#ifndef EC2_CONSTANTS_H
#define EC2_CONSTANTS_H

#include <string>

namespace ec2 {

const std::string VERSION = "1.0.0-max";

// Synthesis constants
const int CR_EVERY_N_SAMPLES = 4;  // Control rate decimation
const unsigned MAX_NUM_FLOATS_PER_AUDIO_FILE = 256000000;  // 1 GB worth of floats

// Parameter counts
const int NUM_PARAMS = 15;
const int NUM_LFOS = 6;

// Audio I/O
const int DEFAULT_SAMPLE_RATE = 48000;
const int DEFAULT_BUFFER_SIZE = 512;
const int MAX_AUDIO_OUTS = 16;  // Extended from original 2 for multichannel

// Parameter indices
enum ParamIndex {
  GRAIN_RATE = 0,
  ASYNC,
  INTERM,
  STREAMS,
  PLAYBACK,
  FILTER_CENTER,
  RESONANCE,
  SOUND_FILE,
  SCAN_BEGIN,
  SCAN_RANGE,
  SCAN_SPEED,
  GRAIN_DUR,
  ENVELOPE,
  PAN,
  AMPLITUDE
};

// Stream types
enum StreamType {
  SYNCHRONOUS = 0,
  ASYNCHRONOUS,
  SEQUENCED,
  DERIVED
};

// Waveform types (for LFOs)
enum Waveform {
  SINE = 0,
  SQUARE,
  ASCEND,
  DESCEND,
  NOISE
};

// Polarity types (for LFOs)
enum Polarity {
  BIPOLAR = 0,
  UNIPOLAR_POS,
  UNIPOLAR_NEG,
  UNIPOLAR
};

// Multichannel spatial modes
enum SpatialMode {
  SPATIAL_MONO = 0,      // All grains to all channels
  SPATIAL_STEREO,        // Grains distributed L-R
  SPATIAL_MULTICHANNEL   // Grains distributed across N channels
};

}  // namespace ec2

#endif  // EC2_CONSTANTS_H
