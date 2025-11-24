/// @file ec2_tilde.cpp
/// @brief EmissionControl2 granular synthesis external with multichannel output
/// @author Alessandro Anatrini
/// @license GPL-3.0

#include "c74_min.h"
#include "ec2_constants.h"
#include "ec2_engine.h"
#include "ec2_utility.h"

// Max SDK includes for graphics (Phase 13)
#include "ext_obex.h"
#include "jgraphics.h"
#include "jpatcher_api.h"

// Standard library
#include <sstream>

using namespace c74::min;

// Buffer management helper (inline to avoid separate compilation unit)
namespace ec2_buffer {
inline std::shared_ptr<ec2::AudioBuffer<float>>
loadFromMaxBuffer(const std::string &buffer_name) {
  if (buffer_name.empty()) {
    return nullptr;
  }

  // Create buffer reference
  auto buf_ref =
      c74::max::buffer_ref_new(nullptr, c74::max::gensym(buffer_name.c_str()));
  if (!buf_ref) {
    return nullptr;
  }

  // Get buffer object
  auto buffer = c74::max::buffer_ref_getobject(buf_ref);
  if (!buffer) {
    c74::max::object_free(buf_ref);
    return nullptr;
  }

  // Get buffer info
  long frames = c74::max::buffer_getframecount(buffer);
  long channels = c74::max::buffer_getchannelcount(buffer);

  if (frames == 0 || channels == 0) {
    c74::max::object_free(buf_ref);
    return nullptr;
  }

  // Lock and copy data
  float *buffer_data = c74::max::buffer_locksamples(buffer);
  if (!buffer_data) {
    c74::max::object_free(buf_ref);
    return nullptr;
  }

  // Create EC2 AudioBuffer
  auto audio_buf = std::make_shared<ec2::AudioBuffer<float>>();
  audio_buf->channels = static_cast<int>(channels);
  audio_buf->frames = static_cast<int>(frames);
  audio_buf->size = static_cast<int>(frames * channels);
  audio_buf->data = new float[audio_buf->size];

  // Copy data (Max buffer~ is interleaved)
  std::copy(buffer_data, buffer_data + audio_buf->size, audio_buf->data);

  // Unlock and cleanup
  c74::max::buffer_unlocksamples(buffer);
  c74::max::object_free(buf_ref);

  return audio_buf;
}
} // namespace ec2_buffer

class ec2_tilde : public object<ec2_tilde> {
private:
  // CRITICAL: These members MUST be declared first, before any attributes,
  // because C++ initializes members in declaration order.
  // LFO attribute setters need m_engine to exist during initialization.
  int m_mc_mode{0}; // Output mode: 0=separated outputs, 1=multichannel cable
  int m_outputs{2}; // Number of output channels (1-16)
  std::unique_ptr<ec2::GranularEngine> m_engine;

  // Dynamic outlet storage (Max SDK)
  std::vector<void *> m_signal_outlets;
  void *m_osc_outlet{nullptr};

  // OSC bundle buffer (persistent for FullPacket pointer)
  std::vector<unsigned char> m_osc_bundle_buffer;

  // Flag to suppress OSC output during batch updates
  bool m_suppress_osc_output{false};

  // Synthesis parameters (stored as member variables, controlled via messages)
  double m_grain_rate{20.0};
  double m_async{0.0};
  double m_intermittency{0.0};
  double m_streams{1.0};
  double m_playback_rate{1.0};
  double m_grain_duration{100.0};
  double m_envelope_shape{0.5};
  double m_scan_start{0.0};
  double m_scan_range{1.0};
  double m_amplitude{0.5};
  double m_filter_freq{22000.0};
  double m_filter_resonance{0.0};
  double m_stereo_pan{0.0};
  double m_scan_speed{1.0};

public:
  MIN_DESCRIPTION{"EmissionControl2 granular synthesis with multichannel "
                  "output (up to 16 channels)"};
  MIN_TAGS{"audio, synthesis, granular"};
  MIN_AUTHOR{"Alessandro Anatrini"};
  MIN_RELATED{"polybuffer~, groove~"};

  // Constructor
  ec2_tilde(const atoms &args = {}) {
    // Parse arguments for backward compatibility: ec2~ [num_outputs]
    if (!args.empty()) {
      int requested_outputs = args[0];
      if (requested_outputs > 0 && requested_outputs <= 16) {
        m_outputs = requested_outputs;
      }
    }

    // Initialize synthesis engine
    m_engine = std::make_unique<ec2::GranularEngine>(2048); // Max 2048 grains

    // Create outlets dynamically using Max SDK
    createOutlets();
  }

  // SIGNAL INLETS (Phase 12)
  inlet<> scan_in{this,
                  "(signal) Scan position (0.0-1.0, overrides @scanstart)"};
  inlet<> rate_in{this, "(signal) Grain rate in Hz (overrides @grainrate)"};
  inlet<> playback_in{this, "(signal) Playback rate (overrides @playback)"};

  // NOTE: Signal outlets are created DYNAMICALLY in createOutlets()
  // OSC outlet is also created dynamically and stored in m_osc_outlet

  // ATTRIBUTES (EC2 Parameters)

  // MULTICHANNEL OUTPUT (Phase 6b)

  attribute<int> mc{
      this, "mc", 0,
      description{"Output mode: 0=separated outputs (each requires its own "
                  "cord), 1=multichannel cable (single blue/black cord)"},
      range{0, 1},
      setter{MIN_FUNCTION{
          int new_mc = static_cast<int>(args[0]);
          if (new_mc != m_mc_mode) {
              m_mc_mode = new_mc;
              recreateOutlets();
          }
          return args;
      }}};

attribute<int> outputs{
    this, "outputs", 2,
    description{"Number of output channels (1-16, default 2)"}, range{1, 16},
    setter{MIN_FUNCTION{
        int new_outputs = static_cast<int>(args[0]);
        if (new_outputs != m_outputs) {
            m_outputs = new_outputs;
            recreateOutlets();
        }
        return args;
    }}};

attribute<symbol> out_format{
    this, "out", "n",
    description{"OSC outlet format: 'n' (native FullPacket bundle for odot), 't' (text for printing/logging)"}
};

// SYNTHESIS PARAMETER MESSAGES (not attributes - for performance control)

message<> grainrate{this, "grainrate", "Grain emission rate in Hz (0.1-500.0)",
                    MIN_FUNCTION{
                      if (args.size() > 0) {
                        m_grain_rate = std::max(0.1, std::min(500.0, double(args[0])));
                        sendOSCBundle();
                      }
                      return {};
                    }};

message<> async_msg{this, "async", "Asynchronicity (0.0-1.0)",
                    MIN_FUNCTION{
                      if (args.size() > 0) {
                        m_async = std::max(0.0, std::min(1.0, double(args[0])));
                        sendOSCBundle();
                      }
                      return {};
                    }};

message<> intermittency_msg{this, "intermittency", "Intermittency (0.0-1.0)",
                            MIN_FUNCTION{
                              if (args.size() > 0) {
                                m_intermittency = std::max(0.0, std::min(1.0, double(args[0])));
                                sendOSCBundle();
                              }
                              return {};
                            }};

message<> streams_msg{this, "streams", "Number of grain streams (1-20)",
                      MIN_FUNCTION{
                        if (args.size() > 0) {
                          m_streams = std::max(1.0, std::min(20.0, double(args[0])));
                          sendOSCBundle();
                        }
                        return {};
                      }};

message<> playback{this, "playback", "Playback rate (-32 to 32)",
                   MIN_FUNCTION{
                     if (args.size() > 0) {
                       m_playback_rate = std::max(-32.0, std::min(32.0, double(args[0])));
                       sendOSCBundle();
                     }
                     return {};
                   }};

message<> duration{this, "duration", "Grain duration in milliseconds (1-1000)",
                   MIN_FUNCTION{
                     if (args.size() > 0) {
                       m_grain_duration = std::max(1.0, std::min(1000.0, double(args[0])));
                       sendOSCBundle();
                     }
                     return {};
                   }};

message<> envelope{this, "envelope", "Envelope shape (0.0-1.0)",
                   MIN_FUNCTION{
                     if (args.size() > 0) {
                       m_envelope_shape = std::max(0.0, std::min(1.0, double(args[0])));
                       sendOSCBundle();
                     }
                     return {};
                   }};

message<> amp{this, "amp", "Overall amplitude (0.0-1.0)",
              MIN_FUNCTION{
                if (args.size() > 0) {
                  m_amplitude = std::max(0.0, std::min(1.0, double(args[0])));
                  sendOSCBundle();
                }
                return {};
              }};

// FILTERING MESSAGES

message<> filterfreq{this, "filterfreq", "Filter cutoff frequency in Hz (20-22000)",
                     MIN_FUNCTION{
                       if (args.size() > 0) {
                         m_filter_freq = std::max(20.0, std::min(22000.0, double(args[0])));
                         sendOSCBundle();
                       }
                       return {};
                     }};

message<> resonance{this, "resonance", "Filter resonance (0.0-1.0)",
                    MIN_FUNCTION{
                      if (args.size() > 0) {
                        m_filter_resonance = std::max(0.0, std::min(1.0, double(args[0])));
                        sendOSCBundle();
                      }
                      return {};
                    }};

// PANNING MESSAGE

message<> pan{this, "pan", "Stereo pan position (-1.0 to 1.0)",
              MIN_FUNCTION{
                if (args.size() > 0) {
                  m_stereo_pan = std::max(-1.0, std::min(1.0, double(args[0])));
                  sendOSCBundle();
                }
                return {};
              }};

// SCANNING MESSAGES

message<> scanstart{this, "scanstart", "Scan start position (0.0-1.0)",
                    MIN_FUNCTION{
                      if (args.size() > 0) {
                        m_scan_start = std::max(0.0, std::min(1.0, double(args[0])));
                        sendOSCBundle();
                      }
                      return {};
                    }};

message<> scanrange{this, "scanrange", "Scan range (0.0-1.0)",
                    MIN_FUNCTION{
                      if (args.size() > 0) {
                        m_scan_range = std::max(0.0, std::min(1.0, double(args[0])));
                        sendOSCBundle();
                      }
                      return {};
                    }};

message<> scanspeed{this, "scanspeed", "Scan speed multiplier (-32.0 to 32.0)",
                    MIN_FUNCTION{
                      if (args.size() > 0) {
                        m_scan_speed = std::max(-32.0, std::min(32.0, double(args[0])));
                        sendOSCBundle();
                      }
                      return {};
                    }};

// SPATIAL ALLOCATION PARAMETERS (Phase 5)

attribute<int> alloc_mode{
    this, "allocmode", 1, // Default: roundrobin
    description{"Spatial allocation mode (0=fixed, 1=roundrobin, 2=random, "
                "3=weighted, 4=loadbalance, 5=pitchmap, 6=trajectory)"},
    range{0, 6}};

// Fixed mode
attribute<int> fixed_channel{
    this, "fixedchan", 0, description{"Target channel for fixed mode (0-15)"},
    range{0, 15}};

// Round-robin mode
attribute<int> rr_step{this, "rrstep", 1, description{"Round-robin step size"},
                       range{1, 16}};

// Random mode
attribute<number> random_spread{
    this, "randspread", 0.0,
    description{"Random mode panning spread (0.0-1.0)"}, range{0.0, 1.0}};

attribute<number> spatial_corr{
    this, "spatialcorr", 0.0,
    description{"Spatial correlation between grains (0.0-1.0)"},
    range{0.0, 1.0}};

// Pitchmap mode
attribute<number> pitch_min{this, "pitchmin", 20.0,
                            description{"Minimum pitch for pitchmap mode (Hz)"},
                            range{20.0, 20000.0}};

attribute<number> pitch_max{this, "pitchmax", 20000.0,
                            description{"Maximum pitch for pitchmap mode (Hz)"},
                            range{20.0, 20000.0}};

// Trajectory mode
attribute<int> traj_shape{
    this, "trajshape", 0,
    description{"Trajectory shape (0=sine, 1=saw, 2=triangle, 3=randomwalk)"},
    range{0, 3}};

attribute<number> traj_rate{this, "trajrate", 0.5,
                            description{"Trajectory rate in Hz"},
                            range{0.001, 100.0}};

attribute<number> traj_depth{
    this, "trajdepth", 1.0,
    description{"Trajectory depth - proportion of channels used (0.0-1.0)"},
    range{0.0, 1.0}};

// BUFFER PARAMETERS (Phase 6)

attribute<symbol> buffer_name{
    this, "buffer", "", description{"Buffer~ name for audio source"},
    setter{MIN_FUNCTION{std::string name = std::string(args[0]);
if (!name.empty()) {
  auto audio_buf = ec2_buffer::loadFromMaxBuffer(name);
  if (audio_buf) {
    m_engine->setAudioBuffer(audio_buf, 0);
  } else {
    cerr << "failed to load buffer '" << name << "'" << endl;
  }
}
return args;
}
}
}
;

attribute<int> sound_file{
    this, "soundfile", 0,
    description{"Sound file index for polybuffer~ (0-based)"}, range{0, 15}};

// LFO PARAMETERS (Phase 9) - Now messages instead of attributes

// LFO 1
message<> lfo1shape{this, "lfo1shape", "LFO1 shape (0-4)",
                    MIN_FUNCTION{
                      if (args.size() > 0 && m_engine) {
                        auto lfo = m_engine->getLFO(0);
                        if (lfo) {
                          int val = std::max(0, std::min(4, int(args[0])));
                          lfo->setShape(static_cast<ec2::LFOShape>(val));
                          sendOSCBundle();
                        }
                      }
                      return {};
                    }};

message<> lfo1rate{this, "lfo1rate", "LFO1 frequency in Hz (0.001-100.0)",
                   MIN_FUNCTION{
                     if (args.size() > 0 && m_engine) {
                       auto lfo = m_engine->getLFO(0);
                       if (lfo) {
                         double val = std::max(0.001, std::min(100.0, double(args[0])));
                         lfo->setFrequency(val);
                         sendOSCBundle();
                       }
                     }
                     return {};
                   }};

message<> lfo1polarity{this, "lfo1polarity", "LFO1 polarity (0-2)",
                       MIN_FUNCTION{
                         if (args.size() > 0 && m_engine) {
                           auto lfo = m_engine->getLFO(0);
                           if (lfo) {
                             int val = std::max(0, std::min(2, int(args[0])));
                             lfo->setPolarity(static_cast<ec2::LFOPolarity>(val));
                             sendOSCBundle();
                           }
                         }
                         return {};
                       }};

message<> lfo1duty{this, "lfo1duty", "LFO1 duty cycle (0.0-1.0)",
                   MIN_FUNCTION{
                     if (args.size() > 0 && m_engine) {
                       auto lfo = m_engine->getLFO(0);
                       if (lfo) {
                         double val = std::max(0.0, std::min(1.0, double(args[0])));
                         lfo->setDuty(val);
                         sendOSCBundle();
                       }
                     }
                     return {};
                   }};

// LFO 2
message<> lfo2shape{this, "lfo2shape", "LFO2 shape (0-4)",
                    MIN_FUNCTION{
                      if (args.size() > 0 && m_engine) {
                        auto lfo = m_engine->getLFO(1);
                        if (lfo) {
                          int val = std::max(0, std::min(4, int(args[0])));
                          lfo->setShape(static_cast<ec2::LFOShape>(val));
                          sendOSCBundle();
                        }
                      }
                      return {};
                    }};

message<> lfo2rate{this, "lfo2rate", "LFO2 frequency in Hz (0.001-100.0)",
                   MIN_FUNCTION{
                     if (args.size() > 0 && m_engine) {
                       auto lfo = m_engine->getLFO(1);
                       if (lfo) {
                         double val = std::max(0.001, std::min(100.0, double(args[0])));
                         lfo->setFrequency(val);
                         sendOSCBundle();
                       }
                     }
                     return {};
                   }};

message<> lfo2polarity{this, "lfo2polarity", "LFO2 polarity (0-2)",
                       MIN_FUNCTION{
                         if (args.size() > 0 && m_engine) {
                           auto lfo = m_engine->getLFO(1);
                           if (lfo) {
                             int val = std::max(0, std::min(2, int(args[0])));
                             lfo->setPolarity(static_cast<ec2::LFOPolarity>(val));
                             sendOSCBundle();
                           }
                         }
                         return {};
                       }};

message<> lfo2duty{this, "lfo2duty", "LFO2 duty cycle (0.0-1.0)",
                   MIN_FUNCTION{
                     if (args.size() > 0 && m_engine) {
                       auto lfo = m_engine->getLFO(1);
                       if (lfo) {
                         double val = std::max(0.0, std::min(1.0, double(args[0])));
                         lfo->setDuty(val);
                         sendOSCBundle();
                       }
                     }
                     return {};
                   }};

// LFO 3
message<> lfo3shape{this, "lfo3shape", "LFO3 shape (0-4)",
                    MIN_FUNCTION{
                      if (args.size() > 0 && m_engine) {
                        auto lfo = m_engine->getLFO(2);
                        if (lfo) {
                          int val = std::max(0, std::min(4, int(args[0])));
                          lfo->setShape(static_cast<ec2::LFOShape>(val));
                          sendOSCBundle();
                        }
                      }
                      return {};
                    }};

message<> lfo3rate{this, "lfo3rate", "LFO3 frequency in Hz (0.001-100.0)",
                   MIN_FUNCTION{
                     if (args.size() > 0 && m_engine) {
                       auto lfo = m_engine->getLFO(2);
                       if (lfo) {
                         double val = std::max(0.001, std::min(100.0, double(args[0])));
                         lfo->setFrequency(val);
                         sendOSCBundle();
                       }
                     }
                     return {};
                   }};

message<> lfo3polarity{this, "lfo3polarity", "LFO3 polarity (0-2)",
                       MIN_FUNCTION{
                         if (args.size() > 0 && m_engine) {
                           auto lfo = m_engine->getLFO(2);
                           if (lfo) {
                             int val = std::max(0, std::min(2, int(args[0])));
                             lfo->setPolarity(static_cast<ec2::LFOPolarity>(val));
                             sendOSCBundle();
                           }
                         }
                         return {};
                       }};

message<> lfo3duty{this, "lfo3duty", "LFO3 duty cycle (0.0-1.0)",
                   MIN_FUNCTION{
                     if (args.size() > 0 && m_engine) {
                       auto lfo = m_engine->getLFO(2);
                       if (lfo) {
                         double val = std::max(0.0, std::min(1.0, double(args[0])));
                         lfo->setDuty(val);
                         sendOSCBundle();
                       }
                     }
                     return {};
                   }};

// LFO 4-6 (converted to messages)
message<> lfo4shape{this, "lfo4shape", "LFO4 shape (0-4)", MIN_FUNCTION{if (args.size() > 0 && m_engine) {auto lfo = m_engine->getLFO(3); if (lfo) {lfo->setShape(static_cast<ec2::LFOShape>(std::max(0, std::min(4, int(args[0]))))); sendOSCBundle();}} return {};}};
message<> lfo4rate{this, "lfo4rate", "LFO4 rate (0.001-100.0)", MIN_FUNCTION{if (args.size() > 0 && m_engine) {auto lfo = m_engine->getLFO(3); if (lfo) {lfo->setFrequency(std::max(0.001, std::min(100.0, double(args[0])))); sendOSCBundle();}} return {};}};
message<> lfo4polarity{this, "lfo4polarity", "LFO4 polarity (0-2)", MIN_FUNCTION{if (args.size() > 0 && m_engine) {auto lfo = m_engine->getLFO(3); if (lfo) {lfo->setPolarity(static_cast<ec2::LFOPolarity>(std::max(0, std::min(2, int(args[0]))))); sendOSCBundle();}} return {};}};
message<> lfo4duty{this, "lfo4duty", "LFO4 duty (0.0-1.0)", MIN_FUNCTION{if (args.size() > 0 && m_engine) {auto lfo = m_engine->getLFO(3); if (lfo) {lfo->setDuty(std::max(0.0, std::min(1.0, double(args[0])))); sendOSCBundle();}} return {};}};

message<> lfo5shape{this, "lfo5shape", "LFO5 shape (0-4)", MIN_FUNCTION{if (args.size() > 0 && m_engine) {auto lfo = m_engine->getLFO(4); if (lfo) {lfo->setShape(static_cast<ec2::LFOShape>(std::max(0, std::min(4, int(args[0]))))); sendOSCBundle();}} return {};}};
message<> lfo5rate{this, "lfo5rate", "LFO5 rate (0.001-100.0)", MIN_FUNCTION{if (args.size() > 0 && m_engine) {auto lfo = m_engine->getLFO(4); if (lfo) {lfo->setFrequency(std::max(0.001, std::min(100.0, double(args[0])))); sendOSCBundle();}} return {};}};
message<> lfo5polarity{this, "lfo5polarity", "LFO5 polarity (0-2)", MIN_FUNCTION{if (args.size() > 0 && m_engine) {auto lfo = m_engine->getLFO(4); if (lfo) {lfo->setPolarity(static_cast<ec2::LFOPolarity>(std::max(0, std::min(2, int(args[0]))))); sendOSCBundle();}} return {};}};
message<> lfo5duty{this, "lfo5duty", "LFO5 duty (0.0-1.0)", MIN_FUNCTION{if (args.size() > 0 && m_engine) {auto lfo = m_engine->getLFO(4); if (lfo) {lfo->setDuty(std::max(0.0, std::min(1.0, double(args[0])))); sendOSCBundle();}} return {};}};

message<> lfo6shape{this, "lfo6shape", "LFO6 shape (0-4)", MIN_FUNCTION{if (args.size() > 0 && m_engine) {auto lfo = m_engine->getLFO(5); if (lfo) {lfo->setShape(static_cast<ec2::LFOShape>(std::max(0, std::min(4, int(args[0]))))); sendOSCBundle();}} return {};}};
message<> lfo6rate{this, "lfo6rate", "LFO6 rate (0.001-100.0)", MIN_FUNCTION{if (args.size() > 0 && m_engine) {auto lfo = m_engine->getLFO(5); if (lfo) {lfo->setFrequency(std::max(0.001, std::min(100.0, double(args[0])))); sendOSCBundle();}} return {};}};
message<> lfo6polarity{this, "lfo6polarity", "LFO6 polarity (0-2)", MIN_FUNCTION{if (args.size() > 0 && m_engine) {auto lfo = m_engine->getLFO(5); if (lfo) {lfo->setPolarity(static_cast<ec2::LFOPolarity>(std::max(0, std::min(2, int(args[0]))))); sendOSCBundle();}} return {};}};
message<> lfo6duty{this, "lfo6duty", "LFO6 duty (0.0-1.0)", MIN_FUNCTION{if (args.size() > 0 && m_engine) {auto lfo = m_engine->getLFO(5); if (lfo) {lfo->setDuty(std::max(0.0, std::min(1.0, double(args[0])))); sendOSCBundle();}} return {};}};


// MESSAGES

message<> dspsetup{
    this, "dspsetup",
    MIN_FUNCTION{
        double sr = c74::max::sys_getsr();

        // Initialize engine with sample rate
        m_engine->setSampleRate(static_cast<float>(sr));

        // Update engine parameters from attributes
        updateEngineParameters();

        // Add to DSP chain using Max SDK
        c74::max::object_method(
            maxobj(), c74::max::gensym("dsp_add64"),
            maxobj(), perform64_static, 0, this);

        return {};
    }};

message<> clear{this, "clear",
                MIN_FUNCTION{
m_engine->stopAllGrains();
return {};
}
}
;

message<> m_read{
    this, "read",
    MIN_FUNCTION{if (args.empty()){
        cerr << "read requires a buffer name argument" << endl;
return {};
}

symbol buffer_sym = args[0];
std::string buffer_str = std::string(buffer_sym);

auto audio_buf = ec2_buffer::loadFromMaxBuffer(buffer_str);
if (audio_buf) {
  m_engine->setAudioBuffer(audio_buf, 0);
  buffer_name = buffer_sym;
} else {
  cerr << "failed to load buffer '" << buffer_str << "'" << endl;
}

return {};
}
}
;

message<> polybuffer{
    this, "polybuffer",
    MIN_FUNCTION{if (args.size() < 2){
        cerr << "polybuffer requires basename and count arguments"
             << endl;
return {};
}

symbol basename = args[0];
int count = static_cast<int>(args[1]);

// Load all buffers
int loaded_count = 0;
for (int i = 0; i < count; ++i) {
  std::string buf_name = std::string(basename) + "." + std::to_string(i);
  auto audio_buf = ec2_buffer::loadFromMaxBuffer(buf_name);
  if (audio_buf) {
    m_engine->setAudioBuffer(audio_buf, i);
    loaded_count++;
  }
}

if (loaded_count < count) {
  cerr << "polybuffer: loaded " << loaded_count << " of " << count
       << " buffers" << endl;
}

return {};
}
}
;

message<> modroute{
    this, "modroute",
    MIN_FUNCTION{if (args.size() < 2){
        cerr
        << "modroute requires parameter name and LFO number (or 'none')"
        << endl;
cerr << "      usage: modroute <param> <lfo_num> [depth]" << endl;
cerr << "      example: modroute grainrate 1 0.5" << endl;
return {};
}

symbol param_sym = args[0];
std::string param_name = std::string(param_sym);

// Get modulation parameters reference
ec2::ModulationParameters *modParams = getModulationParameters(param_name);
if (!modParams) {
  cerr << "unknown parameter '" << param_name << "'" << endl;
  return {};
}

// Check if clearing modulation
if (args.size() == 2) {
  symbol lfo_arg = args[1];
  std::string lfo_str = std::string(lfo_arg);
  if (lfo_str == "none" || lfo_str == "0") {
    modParams->lfoSource = 0;
    modParams->depth = 0.0f;
    return {};
  }
}

// Setting modulation
int lfo_num = args[1];
float depth = (args.size() >= 3) ? static_cast<float>(args[2]) : 0.5f;

if (lfo_num < 0 || lfo_num > 6) {
  cerr << "LFO number must be 0-6 (0=none, 1-6=LFO1-6)" << endl;
  return {};
}

modParams->lfoSource = lfo_num;
modParams->depth = std::max(0.0f, std::min(depth, 1.0f));

return {};
}
}
;

message<> anything{
    this, "anything",
    MIN_FUNCTION{// Handle OSC-style messages: /param_name value
                 // Also handle odot bundles (FullPacket format)

                 if (inlet == 0){// Only handle messages on main inlet
                                 symbol msg_name = args[0];
std::string msg_str = std::string(msg_name);

// Check if it's an OSC path (starts with "/")
if (!msg_str.empty() && msg_str[0] == '/') {
  // Remove leading "/"
  std::string param_name = msg_str.substr(1);

  // Handle nested paths (e.g., "/ec2/grainrate" -> "grainrate")
  size_t last_slash = param_name.find_last_of('/');
  if (last_slash != std::string::npos) {
    param_name = param_name.substr(last_slash + 1);
  }

  // Handle special /set message for buffer loading
  if (param_name == "set") {
    // Format: /set buffer_name [buffer_name2 ...]
    // Load one or more buffers
    if (args.size() >= 2) {
      for (size_t i = 1; i < args.size(); ++i) {
        symbol buf_name = args[i];
        std::string buf_str = std::string(buf_name);
        auto audio_buf = ec2_buffer::loadFromMaxBuffer(buf_str);

        if (audio_buf) {
          int buf_index = static_cast<int>(i - 1);
          m_engine->setAudioBuffer(audio_buf, buf_index);

          // Update attribute for first buffer
          if (i == 1) {
            buffer_name = buf_name;
          }
        } else {
          cerr << "failed to load buffer '" << buf_str << "' via /set"
               << endl;
        }
      }
    } else {
      cerr << "/set requires at least one buffer name argument" << endl;
    }
    return {};
  }

  // Handle /buffer message for buffer loading (OSC-style)
  if (param_name == "buffer") {
    if (args.size() >= 2) {
      symbol buf_name = args[1];
      std::string buf_str = std::string(buf_name);
      auto audio_buf = ec2_buffer::loadFromMaxBuffer(buf_str);

      if (audio_buf) {
        m_engine->setAudioBuffer(audio_buf, 0);
        buffer_name = buf_name;
      } else {
        cerr << "failed to load buffer '" << buf_str << "' via /buffer" << endl;
      }
    } else {
      cerr << "/buffer requires a buffer name argument" << endl;
    }
    return {};
  }

  // Get the value (should be second argument)
  if (args.size() >= 2) {
    handleOSCParameter(param_name, args[1]);
  }
}
// Check if it's an odot FullPacket bundle
else if (msg_str == "FullPacket") {
  // FullPacket format: "FullPacket" <size> <pointer>
  // args[0] = "FullPacket", args[1] = size, args[2] = pointer
  if (args.size() >= 3) {
    try {
      // Extract size and pointer using min API atom conversion
      long bundle_size_val = 0;
      long bundle_ptr_val = 0;

      // Try to get size from args[1]
      try {
        bundle_size_val = static_cast<long>(args[1]);
      } catch (...) {
        // Try as double
        bundle_size_val = static_cast<long>(static_cast<double>(args[1]));
      }

      // Try to get pointer from args[2]
      try {
        bundle_ptr_val = static_cast<long>(args[2]);
      } catch (...) {
        return {};
      }

      size_t bundle_size = static_cast<size_t>(bundle_size_val);
      unsigned char* bundle_ptr = reinterpret_cast<unsigned char*>(bundle_ptr_val);

      // Validate pointer and size
      if (bundle_ptr && bundle_size > 0 && bundle_size < 1048576) { // Max 1MB sanity check
        // Suppress OSC output during batch parsing
        m_suppress_osc_output = true;

        // Parse the OSC bundle from the pointer
        parseOSCBundle(bundle_ptr, bundle_size);

        // Re-enable OSC output and send bundle once with all updated parameters
        m_suppress_osc_output = false;
        sendOSCBundle();
      }

    } catch (...) {
      // Ignore parsing errors
      m_suppress_osc_output = false; // Ensure flag is reset
    }
  }
}
}

return {};
}
}
;

message<> bang{this, "bang",
               MIN_FUNCTION{// Output current parameter state as OSC bundle
                            outputOSCState();
return {};
}
}
;

message<> loadbang{this, "loadbang",
                   MIN_FUNCTION{// Send initial OSC bundle on object creation
                                sendOSCBundle();
return {};
}
}
;

message<> waveform{
    this, "waveform",
    MIN_FUNCTION{// Phase 13: Report buffer waveform info (simplified approach)
                 // Full graphical display requires jbox UI object which is
                 // beyond min-devkit scope

                 int buffer_index = static_cast<int>(sound_file.get());
auto current_buffer = m_engine->getAudioBuffer(buffer_index);

if (!current_buffer || current_buffer->size == 0) {
  cout << "no buffer loaded" << endl;
  return {};
}

cout << "buffer info:" << endl;
cout << "  frames: " << current_buffer->frames << endl;
cout << "  channels: " << current_buffer->channels << endl;
float sr = m_engine->getSampleRate();
cout << "  sample rate: " << sr << " Hz" << endl;
cout << "  duration: " << (current_buffer->frames / sr) << " seconds" << endl;

// Calculate and report peak amplitude
float peak = 0.0f;
for (size_t i = 0; i < current_buffer->size; ++i) {
  float abs_val = std::abs(current_buffer->data[i]);
  if (abs_val > peak)
    peak = abs_val;
}
cout << "  peak amplitude: " << peak << " (" << (20.0 * log10(peak)) << " dB)"
     << endl;

return {};
}
}
;

message<> openbuffer{
    this, "openbuffer",
    MIN_FUNCTION{// Phase 13: Open buffer editor
                 // This provides a way to view/edit the waveform using Max's
                 // built-in buffer editor

                 std::string buf_name_str = std::string(buffer_name.get());
if (buf_name_str.empty()) {
  cerr << "no buffer loaded (use 'read' or 'polybuffer' message first)"
       << endl;
  return {};
}

// Open buffer editor using Max SDK
auto buf_ref = c74::max::buffer_ref_new((c74::max::t_object *)this->maxobj(),
                                        buffer_name.get());
if (buf_ref) {
  auto buffer = c74::max::buffer_ref_getobject(buf_ref);
  if (buffer) {
    // Send 'wclose' then 'open' to ensure editor appears
    c74::max::object_method_typed(buffer, c74::max::gensym("wclose"), 0,
                                  nullptr, nullptr);
    c74::max::object_method_typed(buffer, c74::max::gensym("open"), 0, nullptr,
                                  nullptr);
  } else {
    cerr << "failed to get buffer object" << endl;
  }
  c74::max::object_free((c74::max::t_object *)buf_ref);
} else {
  cerr << "failed to create buffer reference" << endl;
}

return {};
}
}
;

message<> dblclick{
    this, "dblclick",
    MIN_FUNCTION{// Phase 13: Double-click opens buffer editor (like waveform~)
                 // Delegate to openbuffer message
                 atoms a;
this->try_call("openbuffer", a);
return {};
}
}
;

// Assist strings for inlets and outlets
message<> assist{
    this, "assist",
    MIN_FUNCTION{
        long inlet_idx = args[0];
        long outlet_idx = args[1];

        if (inlet_idx >= 0) {
            // Inlet assist strings
            switch (inlet_idx) {
                case 0:
                    return {"Main inlet: messages, OSC bundles (@out: n/t)"};
                case 1:
                    return {"Signal: scan position (0.0-1.0)"};
                case 2:
                    return {"Signal: grain rate modulation (Hz)"};
                case 3:
                    return {"Signal: playback rate modulation"};
                default:
                    return {};
            }
        } else if (outlet_idx >= 0) {
            // Outlet assist strings - dynamically adjust based on @mc mode
            if (outlet_idx < m_outputs && m_mc_mode == 0) {
                // Separated outputs
                std::stringstream ss;
                ss << "Audio out " << (outlet_idx + 1);
                return {ss.str()};
            } else if (outlet_idx == 0 && m_mc_mode == 1) {
                // MC cable
                std::stringstream ss;
                ss << "Multichannel audio (" << m_outputs << " channels)";
                return {ss.str()};
            } else if ((m_mc_mode == 0 && outlet_idx == m_outputs) ||
                       (m_mc_mode == 1 && outlet_idx == 1)) {
                // OSC outlet (rightmost)
                return {"OSC outlet: parameter updates (@out: n=FullPacket, t=text)"};
            }
        }

        return {};
    }
};

  // DSP64 Perform callback - static wrapper
  static void perform64_static(c74::max::t_object *dsp64, double **ins,
                                long numins, double **outs, long numouts,
                                long sampleframes, long flags, void *userparam) {
    ec2_tilde *self = static_cast<ec2_tilde *>(userparam);
    self->perform64(ins, numins, outs, numouts, sampleframes);
  }

  // DSP64 Perform callback - actual processing
  void perform64(double **ins, long numins, double **outs, long numouts,
                 long sampleframes) {
    // Update engine parameters from attributes
    updateEngineParameters();

    // Allocate temporary float buffers (engine uses float, Max uses double)
    std::vector<std::vector<float>> tempBuffers(m_outputs);
    std::vector<float *> outBuffers(m_outputs);

    for (int ch = 0; ch < m_outputs; ++ch) {
      tempBuffers[ch].resize(sampleframes, 0.0f);
      outBuffers[ch] = tempBuffers[ch].data();
    }

    // Process signal inputs (Phase 12)
    // Signal inlets: 0=scan, 1=grain rate, 2=playback rate
    bool has_scan = (numins > 0);
    bool has_rate = (numins > 1);
    bool has_playback = (numins > 2);

    // Convert signal inputs from double to float
    std::vector<float> scan_signal(sampleframes);
    std::vector<float> rate_signal(sampleframes);
    std::vector<float> playback_signal(sampleframes);

    if (has_scan) {
      for (long i = 0; i < sampleframes; ++i) {
        scan_signal[i] = static_cast<float>(ins[0][i]);
      }
    }

    if (has_rate) {
      for (long i = 0; i < sampleframes; ++i) {
        rate_signal[i] = static_cast<float>(ins[1][i]);
      }
    }

    if (has_playback) {
      for (long i = 0; i < sampleframes; ++i) {
        playback_signal[i] = static_cast<float>(ins[2][i]);
      }
    }

    // Process synthesis engine with signal inputs
    m_engine->processWithSignals(
        outBuffers.data(), m_outputs, static_cast<int>(sampleframes),
        has_scan ? scan_signal.data() : nullptr,
        has_rate ? rate_signal.data() : nullptr,
        has_playback ? playback_signal.data() : nullptr);

    // Route output to outlets based on @mc mode
    if (m_mc_mode == 1) {
      // Multichannel mode: all channels bundled into first outlet
      // Max MC outlets expect all channels in the first numouts channels
      for (int ch = 0; ch < m_outputs && ch < numouts; ++ch) {
        for (long i = 0; i < sampleframes; ++i) {
          outs[ch][i] = static_cast<double>(tempBuffers[ch][i]);
        }
      }
    } else {
      // Separated mode: each channel to its own outlet
      for (int ch = 0; ch < m_outputs && ch < numouts; ++ch) {
        for (long i = 0; i < sampleframes; ++i) {
          outs[ch][i] = static_cast<double>(tempBuffers[ch][i]);
        }
      }
    }
  }

private:

// Helper: Parse OSC bundle and extract messages
void parseOSCBundle(const unsigned char* data, size_t size) {
  // Check for OSC bundle header "#bundle\0"
  if (size < 16) return; // Minimum bundle size

  if (memcmp(data, "#bundle", 8) != 0) {
    return; // Not a valid bundle
  }

  // Skip bundle header (8 bytes) and timetag (8 bytes)
  size_t offset = 16;

  // Parse bundle elements
  while (offset < size) {
    // Read element size (big-endian int32)
    if (offset + 4 > size) break;

    uint32_t element_size =
        (data[offset] << 24) |
        (data[offset + 1] << 16) |
        (data[offset + 2] << 8) |
        data[offset + 3];
    offset += 4;

    if (offset + element_size > size) break;

    // Parse OSC message from this element
    parseOSCMessage(data + offset, element_size);

    offset += element_size;
  }
}

// Helper: Parse single OSC message
void parseOSCMessage(const unsigned char* data, size_t size) {
  if (size < 4) return;

  // Parse address pattern (null-terminated string)
  std::string address;
  size_t offset = 0;
  while (offset < size && data[offset] != '\0') {
    address += (char)data[offset++];
  }

  if (offset >= size) return;

  // Skip to next 4-byte boundary
  offset = (offset + 4) & ~3;

  if (offset >= size || data[offset] != ',') return;

  // Parse type tag string
  std::string typetags;
  offset++; // Skip comma
  while (offset < size && data[offset] != '\0') {
    typetags += (char)data[offset++];
  }

  // Skip to next 4-byte boundary
  offset = (offset + 4) & ~3;

  // Extract parameter name from address (remove leading '/')
  std::string param_name = address;
  if (!param_name.empty() && param_name[0] == '/') {
    param_name = param_name.substr(1);
  }

  // Parse arguments based on type tags
  for (char tag : typetags) {
    if (offset >= size) break;

    if (tag == 'f') {
      // Float32 (big-endian)
      if (offset + 4 > size) break;

      uint32_t bits =
          (data[offset] << 24) |
          (data[offset + 1] << 16) |
          (data[offset + 2] << 8) |
          data[offset + 3];

      float value;
      memcpy(&value, &bits, 4);

      // Route to parameter
      handleOSCParameter(param_name, value);

      offset += 4;
      break; // Only use first argument

    } else if (tag == 'i') {
      // Int32 (big-endian)
      if (offset + 4 > size) break;

      int32_t value =
          (data[offset] << 24) |
          (data[offset + 1] << 16) |
          (data[offset + 2] << 8) |
          data[offset + 3];

      // Route to parameter
      handleOSCParameter(param_name, (double)value);

      offset += 4;
      break; // Only use first argument

    } else if (tag == 's') {
      // String (null-terminated, padded to 4-byte boundary)
      std::string str_value;
      while (offset < size && data[offset] != '\0') {
        str_value += (char)data[offset++];
      }

      // Handle string parameter (e.g., buffer name)
      if (param_name == "buffer") {
        // Load buffer by name
        auto audio_buf = ec2_buffer::loadFromMaxBuffer(str_value);
        if (audio_buf) {
          m_engine->setAudioBuffer(audio_buf, 0);
          buffer_name = c74::max::gensym(str_value.c_str());
        }
      }

      break; // Only use first argument

    } else {
      // Unsupported type, skip
      break;
    }
  }
}

// Helper: get effective output channel count
size_t getOutputChannelCount() const {
  // @outputs controls the number of channels
  // @mc only controls whether they're delivered as separated outputs or bundled
  // in a multichannel cable
  return m_outputs;
}

// Helper: get modulation parameters for a given parameter name (Phase 9)
ec2::ModulationParameters *
getModulationParameters(const std::string &param_name) {
  auto &params = m_engine->getParameters();

  if (param_name == "grainrate")
    return const_cast<ec2::ModulationParameters *>(&params.modGrainRate);
  if (param_name == "async")
    return const_cast<ec2::ModulationParameters *>(&params.modAsync);
  if (param_name == "intermittency")
    return const_cast<ec2::ModulationParameters *>(&params.modIntermittency);
  if (param_name == "streams")
    return const_cast<ec2::ModulationParameters *>(&params.modStreams);
  if (param_name == "playback")
    return const_cast<ec2::ModulationParameters *>(&params.modPlaybackRate);
  if (param_name == "duration")
    return const_cast<ec2::ModulationParameters *>(&params.modGrainDuration);
  if (param_name == "envelope")
    return const_cast<ec2::ModulationParameters *>(&params.modEnvelope);
  if (param_name == "filterfreq")
    return const_cast<ec2::ModulationParameters *>(&params.modFilterFreq);
  if (param_name == "resonance")
    return const_cast<ec2::ModulationParameters *>(&params.modResonance);
  if (param_name == "pan")
    return const_cast<ec2::ModulationParameters *>(&params.modPan);
  if (param_name == "amp")
    return const_cast<ec2::ModulationParameters *>(&params.modAmplitude);
  if (param_name == "scanstart")
    return const_cast<ec2::ModulationParameters *>(&params.modScanBegin);
  if (param_name == "scanrange")
    return const_cast<ec2::ModulationParameters *>(&params.modScanRange);
  if (param_name == "scanspeed")
    return const_cast<ec2::ModulationParameters *>(&params.modScanSpeed);

  return nullptr;
}

// Helper: update engine parameters from member variables
void updateEngineParameters() {
  ec2::SynthParameters params;

  // Grain scheduling
  params.grainRate = m_grain_rate;
  params.async = m_async;
  params.intermittency = m_intermittency;
  params.streams = m_streams;

  // Grain characteristics
  params.playbackRate = m_playback_rate;
  params.grainDuration = m_grain_duration;
  params.envelope = m_envelope_shape;
  params.pan = m_stereo_pan;
  params.amplitude = m_amplitude;

  // Filtering
  params.filterFreq = m_filter_freq;
  params.resonance = m_filter_resonance;

  // Scanning
  params.scanBegin = m_scan_start;
  params.scanRange = m_scan_range;
  params.scanSpeed = m_scan_speed;
  params.soundFile = sound_file; // Phase 6: Buffer selection

  // Spatial allocation (Phase 5)
  params.spatial.mode = static_cast<ec2::AllocationMode>(alloc_mode.get());
  params.spatial.numChannels = static_cast<int>(getOutputChannelCount());

  // Fixed mode
  params.spatial.fixedChannel = fixed_channel;

  // Round-robin mode
  params.spatial.roundRobinStep = rr_step;

  // Random mode
  params.spatial.spread = random_spread;
  params.spatial.spatialCorr = spatial_corr;

  // Pitchmap mode
  params.spatial.pitchMin = pitch_min;
  params.spatial.pitchMax = pitch_max;

  // Trajectory mode
  params.spatial.trajShape =
      static_cast<ec2::TrajectoryShape>(traj_shape.get());
  params.spatial.trajRate = traj_rate;
  params.spatial.trajDepth = traj_depth;

  m_engine->updateParameters(params);
}

// Helper: handle OSC parameter setting (Phase 10)
void handleOSCParameter(const std::string &param_name, const atom &value) {
  // Map OSC parameter names to member variables
  // Use lowercase, no special chars for OSC compatibility

  try {
    double val = static_cast<double>(value);

    // Grain scheduling
    if (param_name == "grainrate") {
      m_grain_rate = std::max(0.1, std::min(500.0, val));
    } else if (param_name == "async") {
      m_async = std::max(0.0, std::min(1.0, val));
    } else if (param_name == "intermittency") {
      m_intermittency = std::max(0.0, std::min(1.0, val));
    } else if (param_name == "streams") {
      m_streams = std::max(1.0, std::min(20.0, val));
    }

    // Grain characteristics
    else if (param_name == "playback") {
      m_playback_rate = std::max(-32.0, std::min(32.0, val));
    } else if (param_name == "duration") {
      m_grain_duration = std::max(1.0, std::min(1000.0, val));
    } else if (param_name == "envelope") {
      m_envelope_shape = std::max(0.0, std::min(1.0, val));
    } else if (param_name == "amp" || param_name == "amplitude") {
      m_amplitude = std::max(0.0, std::min(1.0, val));
    }

    // Filtering
    else if (param_name == "filterfreq") {
      m_filter_freq = std::max(20.0, std::min(22000.0, val));
    } else if (param_name == "resonance") {
      m_filter_resonance = std::max(0.0, std::min(1.0, val));
    }

    // Stereo panning
    else if (param_name == "pan") {
      m_stereo_pan = std::max(-1.0, std::min(1.0, val));
    }

    // Scanning
    else if (param_name == "scanstart") {
      m_scan_start = std::max(0.0, std::min(1.0, val));
    } else if (param_name == "scanrange") {
      m_scan_range = std::max(0.0, std::min(1.0, val));
    } else if (param_name == "scanspeed") {
      m_scan_speed = std::max(-32.0, std::min(32.0, val));
    }

    // Buffer
    else if (param_name == "soundfile") {
      sound_file = static_cast<int>(val);
    }

    // Multichannel
    else if (param_name == "mc") {
      m_mc_mode = static_cast<int>(val);
    } else if (param_name == "outputs") {
      m_outputs = static_cast<int>(val);
    }

    // Spatial allocation
    else if (param_name == "allocmode") {
      alloc_mode = static_cast<int>(val);
    } else if (param_name == "fixedchan") {
      fixed_channel = static_cast<int>(val);
    } else if (param_name == "rrstep") {
      rr_step = static_cast<int>(val);
    } else if (param_name == "randspread") {
      random_spread = val;
    } else if (param_name == "spatialcorr") {
      spatial_corr = val;
    } else if (param_name == "pitchmin") {
      pitch_min = val;
    } else if (param_name == "pitchmax") {
      pitch_max = val;
    } else if (param_name == "trajshape") {
      traj_shape = static_cast<int>(val);
    } else if (param_name == "trajrate") {
      traj_rate = val;
    } else if (param_name == "trajdepth") {
      traj_depth = val;
    }

    // LFOs are now handled as messages, not attributes
    // OSC messages for LFOs will be routed through the message system

    else {
      // Unknown parameter - ignore silently for OSC compatibility
      // (some OSC messages might be for other purposes)
    }

    // Update engine parameters after setting
    updateEngineParameters();

    // Send OSC bundle to notify of parameter change (unless suppressed for batch updates)
    if (!m_suppress_osc_output) {
      sendOSCBundle();
    }

  } catch (...) {
    // Type conversion error - ignore
  }
}

// Helper: Send OSC bundle with all parameters (automatic output)
// Helper: Write big-endian 32-bit integer
void writeBigEndianInt32(std::vector<unsigned char>& buffer, uint32_t value) {
  buffer.push_back((value >> 24) & 0xFF);
  buffer.push_back((value >> 16) & 0xFF);
  buffer.push_back((value >> 8) & 0xFF);
  buffer.push_back(value & 0xFF);
}

// Helper: Write big-endian 32-bit float
void writeBigEndianFloat32(std::vector<unsigned char>& buffer, float value) {
  uint32_t bits;
  memcpy(&bits, &value, 4);
  writeBigEndianInt32(buffer, bits);
}

// Helper: Write OSC string (null-terminated, padded to 4-byte boundary)
void writeOSCString(std::vector<unsigned char>& buffer, const std::string& str) {
  buffer.insert(buffer.end(), str.begin(), str.end());
  buffer.push_back('\0'); // Null terminator

  // Pad to 4-byte boundary
  while (buffer.size() % 4 != 0) {
    buffer.push_back('\0');
  }
}

// Helper: Write single OSC message to buffer (float value)
void writeOSCMessage(std::vector<unsigned char>& buffer, const std::string& address, float value) {
  std::vector<unsigned char> message;

  // Write address pattern
  writeOSCString(message, address);

  // Write type tag string (,f = float)
  writeOSCString(message, ",f");

  // Write float argument
  writeBigEndianFloat32(message, value);

  // Write message size
  writeBigEndianInt32(buffer, message.size());

  // Write message content
  buffer.insert(buffer.end(), message.begin(), message.end());
}

// Helper: Write single OSC message to buffer (string value)
void writeOSCMessageString(std::vector<unsigned char>& buffer, const std::string& address, const std::string& value) {
  std::vector<unsigned char> message;

  // Write address pattern
  writeOSCString(message, address);

  // Write type tag string (,s = string)
  writeOSCString(message, ",s");

  // Write string argument
  writeOSCString(message, value);

  // Write message size
  writeBigEndianInt32(buffer, message.size());

  // Write message content
  buffer.insert(buffer.end(), message.begin(), message.end());
}

// Helper: Send parameters as text (for @out t)
void sendTextOutput() {
  if (!m_osc_outlet) return;

  // Build human-readable parameter string
  std::stringstream ss;
  ss << "ec2~ parameters: ";

  // Synthesis parameters
  ss << "grainrate=" << m_grain_rate << " ";
  ss << "async=" << m_async << " ";
  ss << "intermittency=" << m_intermittency << " ";
  ss << "streams=" << m_streams << " ";
  ss << "playback=" << m_playback_rate << " ";
  ss << "duration=" << m_grain_duration << " ";
  ss << "envelope=" << m_envelope_shape << " ";
  ss << "amp=" << m_amplitude << " ";
  ss << "filterfreq=" << m_filter_freq << " ";
  ss << "resonance=" << m_filter_resonance << " ";
  ss << "pan=" << m_stereo_pan << " ";
  ss << "scanstart=" << m_scan_start << " ";
  ss << "scanrange=" << m_scan_range << " ";
  ss << "scanspeed=" << m_scan_speed << " ";

  // Attributes
  ss << "outputs=" << m_outputs << " ";
  ss << "mc=" << m_mc_mode << " ";
  ss << "allocmode=" << alloc_mode.get() << " ";
  ss << "fixedchan=" << fixed_channel.get() << " ";
  ss << "rrstep=" << rr_step.get() << " ";
  ss << "randspread=" << random_spread.get() << " ";
  ss << "spatialcorr=" << spatial_corr.get() << " ";
  ss << "pitchmin=" << pitch_min.get() << " ";
  ss << "pitchmax=" << pitch_max.get() << " ";
  ss << "trajshape=" << traj_shape.get() << " ";
  ss << "trajrate=" << traj_rate.get() << " ";
  ss << "trajdepth=" << traj_depth.get() << " ";
  ss << "soundfile=" << sound_file.get();

  // Send as symbol
  c74::max::t_atom arg;
  c74::max::atom_setsym(&arg, c74::max::gensym(ss.str().c_str()));
  c74::max::outlet_anything(m_osc_outlet, c74::max::gensym("text"), 1, &arg);
}

void sendOSCBundle() {
  if (!m_osc_outlet) return;

  // Check output format
  std::string format_str = std::string(out_format.get());
  if (format_str == "t" || format_str == "text") {
    sendTextOutput();
    return;
  }

  // Native FullPacket bundle format (default)

  // Create binary OSC bundle following OSC 1.0 specification
  m_osc_bundle_buffer.clear();

  // Bundle header: "#bundle\0" (8 bytes)
  m_osc_bundle_buffer.push_back('#');
  m_osc_bundle_buffer.push_back('b');
  m_osc_bundle_buffer.push_back('u');
  m_osc_bundle_buffer.push_back('n');
  m_osc_bundle_buffer.push_back('d');
  m_osc_bundle_buffer.push_back('l');
  m_osc_bundle_buffer.push_back('e');
  m_osc_bundle_buffer.push_back('\0');

  // Timetag: immediate (0x0000000000000001) (8 bytes)
  for (int i = 0; i < 7; i++) m_osc_bundle_buffer.push_back(0x00);
  m_osc_bundle_buffer.push_back(0x01);

  // Add all parameter messages
  // Grain scheduling
  writeOSCMessage(m_osc_bundle_buffer, "/grainrate", m_grain_rate);
  writeOSCMessage(m_osc_bundle_buffer, "/async", m_async);
  writeOSCMessage(m_osc_bundle_buffer, "/intermittency", m_intermittency);
  writeOSCMessage(m_osc_bundle_buffer, "/streams", m_streams);

  // Grain characteristics
  writeOSCMessage(m_osc_bundle_buffer, "/playback", m_playback_rate);
  writeOSCMessage(m_osc_bundle_buffer, "/duration", m_grain_duration);
  writeOSCMessage(m_osc_bundle_buffer, "/envelope", m_envelope_shape);
  writeOSCMessage(m_osc_bundle_buffer, "/amp", m_amplitude);

  // Filtering
  writeOSCMessage(m_osc_bundle_buffer, "/filterfreq", m_filter_freq);
  writeOSCMessage(m_osc_bundle_buffer, "/resonance", m_filter_resonance);

  // Panning
  writeOSCMessage(m_osc_bundle_buffer, "/pan", m_stereo_pan);

  // Scanning
  writeOSCMessage(m_osc_bundle_buffer, "/scanstart", m_scan_start);
  writeOSCMessage(m_osc_bundle_buffer, "/scanrange", m_scan_range);
  writeOSCMessage(m_osc_bundle_buffer, "/scanspeed", m_scan_speed);

  // Attributes (configuration parameters)
  writeOSCMessage(m_osc_bundle_buffer, "/outputs", m_outputs);
  writeOSCMessage(m_osc_bundle_buffer, "/mc", m_mc_mode);
  writeOSCMessage(m_osc_bundle_buffer, "/allocmode", alloc_mode);
  writeOSCMessage(m_osc_bundle_buffer, "/fixedchan", fixed_channel);
  writeOSCMessage(m_osc_bundle_buffer, "/rrstep", rr_step);
  writeOSCMessage(m_osc_bundle_buffer, "/randspread", random_spread);
  writeOSCMessage(m_osc_bundle_buffer, "/spatialcorr", spatial_corr);
  writeOSCMessage(m_osc_bundle_buffer, "/pitchmin", pitch_min);
  writeOSCMessage(m_osc_bundle_buffer, "/pitchmax", pitch_max);
  writeOSCMessage(m_osc_bundle_buffer, "/trajshape", traj_shape);
  writeOSCMessage(m_osc_bundle_buffer, "/trajrate", traj_rate);
  writeOSCMessage(m_osc_bundle_buffer, "/trajdepth", traj_depth);
  writeOSCMessage(m_osc_bundle_buffer, "/soundfile", sound_file.get());

  // Buffer name (always send, even if empty, for consistency)
  std::string buf_name = std::string(buffer_name.get());
  writeOSCMessageString(m_osc_bundle_buffer, "/buffer", buf_name.empty() ? "" : buf_name);

  // LFO Parameters (24 total: 6 LFOs × 4 params each)
  if (m_engine) {
    for (int i = 0; i < 6; i++) {
      auto lfo = m_engine->getLFO(i);
      if (lfo) {
        std::string lfo_prefix = "/lfo" + std::to_string(i + 1);
        writeOSCMessage(m_osc_bundle_buffer, lfo_prefix + "shape", static_cast<float>(lfo->getShape()));
        writeOSCMessage(m_osc_bundle_buffer, lfo_prefix + "rate", lfo->getFrequency());
        writeOSCMessage(m_osc_bundle_buffer, lfo_prefix + "polarity", static_cast<float>(lfo->getPolarity()));
        writeOSCMessage(m_osc_bundle_buffer, lfo_prefix + "duty", lfo->getDuty());
      }
    }
  }

  // Send as FullPacket (odot format)
  // FullPacket format: TWO arguments
  //   1st: size (long)
  //   2nd: pointer address (long) to buffer
  c74::max::t_atom args[2];
  c74::max::atom_setlong(&args[0], m_osc_bundle_buffer.size());
  c74::max::atom_setlong(&args[1], (long)m_osc_bundle_buffer.data());

  // Send as FullPacket message
  c74::max::outlet_anything(m_osc_outlet, c74::max::gensym("FullPacket"), 2, args);
}

// Legacy function for bang message
void outputOSCState() {
  sendOSCBundle();
}

// Helper: Create outlets dynamically based on @outputs and @mc
void createOutlets() {
  auto max_obj = (c74::max::t_object *)maxobj();

  // Create outlets from right to left (Max convention)
  // Rightmost outlet: OSC (message outlet)
  m_osc_outlet = c74::max::outlet_new(max_obj, nullptr);

  // Signal outlets (created right to left)
  if (m_mc_mode == 1) {
    // Multichannel mode: Create 1 MC signal outlet
    void *mc_outlet = c74::max::outlet_new(max_obj, "multichannelsignal");
    m_signal_outlets.insert(m_signal_outlets.begin(), mc_outlet);
  } else {
    // Separated mode: Create N separate signal outlets (right to left)
    for (int i = m_outputs - 1; i >= 0; --i) {
      void *sig_outlet = c74::max::outlet_new(max_obj, "signal");
      m_signal_outlets.insert(m_signal_outlets.begin(), sig_outlet);
    }
  }
}

// Helper: Recreate outlets when @outputs or @mc changes
void recreateOutlets() {
  // Delete all existing outlets (in reverse order)
  if (m_osc_outlet) {
    c74::max::outlet_delete(m_osc_outlet);
    m_osc_outlet = nullptr;
  }

  for (auto it = m_signal_outlets.rbegin(); it != m_signal_outlets.rend(); ++it) {
    c74::max::outlet_delete(*it);
  }
  m_signal_outlets.clear();

  // Recreate outlets with new configuration
  createOutlets();
}
}
;

MIN_EXTERNAL(ec2_tilde);
