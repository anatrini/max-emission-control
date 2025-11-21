/// @file ec2_tilde.cpp
/// @brief EmissionControl2 granular synthesis external with multichannel output
/// @author Alessandro Anatrini
/// @license GPL-3.0

#include "c74_min.h"
#include "ec2_constants.h"
#include "ec2_utility.h"
#include "ec2_engine.h"

// Max SDK includes for graphics (Phase 13)
#include "ext_obex.h"
#include "jgraphics.h"
#include "jpatcher_api.h"

using namespace c74::min;

// Buffer management helper (inline to avoid separate compilation unit)
namespace ec2_buffer {
    inline std::shared_ptr<ec2::AudioBuffer<float>> loadFromMaxBuffer(const std::string& buffer_name) {
        if (buffer_name.empty()) {
            return nullptr;
        }

        // Create buffer reference
        auto buf_ref = c74::max::buffer_ref_new(nullptr, c74::max::gensym(buffer_name.c_str()));
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
        float* buffer_data = c74::max::buffer_locksamples(buffer);
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
}

class ec2_tilde : public object<ec2_tilde>, public mc_operator<> {
public:
    MIN_DESCRIPTION {"EmissionControl2 granular synthesis with multichannel output (up to 16 channels)"};
    MIN_TAGS {"audio, synthesis, granular"};
    MIN_AUTHOR {"Alessandro Anatrini"};
    MIN_RELATED {"polybuffer~, groove~"};

    // Constructor
    ec2_tilde(const atoms& args = {}) {
        // Parse arguments for backward compatibility: ec2~ [num_outputs]
        if (!args.empty()) {
            int requested_outputs = args[0];
            if (requested_outputs > 0 && requested_outputs <= 16) {
                m_outputs = requested_outputs;
            }
        }

        cout << "ec2~ initialized with " << m_outputs << " output"
             << (m_outputs > 1 ? "s" : "") << endl;

        // Initialize synthesis engine
        m_engine = std::make_unique<ec2::GranularEngine>(2048);  // Max 2048 grains
    }

    // Multichannel configuration
    size_t mc_get_output_channel_count() const {
        return getOutputChannelCount();
    }

    // SIGNAL INLETS (Phase 12)
    inlet<> scan_in {this, "(signal) Scan position (0.0-1.0, overrides @scanstart)"};
    inlet<> rate_in {this, "(signal) Grain rate in Hz (overrides @grainrate)"};
    inlet<> playback_in {this, "(signal) Playback rate (overrides @playback)"};

    // OSC OUTLET (Phase 10)
    outlet<> osc_out {this, "(OSC bundle) Parameter state output"};

    // ATTRIBUTES (EC2 Parameters)

    // MULTICHANNEL OUTPUT (Phase 6b)

    attribute<int> mc {
        this, "mc", 0,
        description {"Output mode: 0=separated outputs (each requires its own cord), 1=multichannel cable (single blue/black cord)"},
        range {0, 1},
        setter { MIN_FUNCTION {
            m_mc_mode = static_cast<int>(args[0]);
            cout << "ec2~: output mode set to " << (m_mc_mode ? "multichannel cable" : "separated outputs") << endl;
            return args;
        }}
    };

    attribute<int> outputs {
        this, "outputs", 2,
        description {"Number of output channels (1-16, default 2)"},
        range {1, 16},
        setter { MIN_FUNCTION {
            m_outputs = static_cast<int>(args[0]);
            cout << "ec2~: output count set to " << m_outputs << endl;
            return args;
        }}
    };

    attribute<number> grain_rate {
        this, "grainrate", 20.0,
        description {"Grain emission rate in Hz"},
        range {0.1, 500.0}
    };

    attribute<number> async {
        this, "async", 0.0,
        description {"Asynchronicity (0.0-1.0)"},
        range {0.0, 1.0}
    };

    attribute<number> intermittency {
        this, "intermittency", 0.0,
        description {"Intermittency (0.0-1.0)"},
        range {0.0, 1.0}
    };

    attribute<number> streams {
        this, "streams", 1,
        description {"Number of grain streams"},
        range {1, 20}
    };

    attribute<number> playback_rate {
        this, "playback", 1.0,
        description {"Playback rate (-32 to 32)"},
        range {-32.0, 32.0}
    };

    attribute<number> grain_duration {
        this, "duration", 100.0,
        description {"Grain duration in milliseconds"},
        range {1.0, 1000.0}
    };

    attribute<number> envelope_shape {
        this, "envelope", 0.5,
        description {"Envelope shape: 0.0=exponential decay, 0.5=tukey window (default), 1.0=reverse exponential"},
        range {0.0, 1.0}
    };

    attribute<number> scan_start {
        this, "scanstart", 0.0,
        description {"Scan start position (0.0-1.0)"},
        range {0.0, 1.0}
    };

    attribute<number> scan_range {
        this, "scanrange", 1.0,
        description {"Scan range (0.0-1.0)"},
        range {0.0, 1.0}
    };

    attribute<number> amplitude {
        this, "amp", 0.5,
        description {"Overall amplitude"},
        range {0.0, 1.0}
    };

    // FILTERING PARAMETERS

    attribute<number> filter_freq {
        this, "filterfreq", 22000.0,
        description {"Filter cutoff frequency in Hz (22000 = no filtering)"},
        range {20.0, 22000.0}
    };

    attribute<number> filter_resonance {
        this, "resonance", 0.0,
        description {"Filter resonance (0.0-1.0)"},
        range {0.0, 1.0}
    };

    // STEREO PANNING

    attribute<number> stereo_pan {
        this, "pan", 0.0,
        description {"Stereo pan position: -1.0=left, 0.0=center, 1.0=right (legacy stereo mode)"},
        range {-1.0, 1.0}
    };

    // SCANNING PARAMETERS

    attribute<number> scan_speed {
        this, "scanspeed", 1.0,
        description {"Scan speed multiplier (-32.0 to 32.0)"},
        range {-32.0, 32.0}
    };

    // SPATIAL ALLOCATION PARAMETERS (Phase 5)

    attribute<int> alloc_mode {
        this, "allocmode", 1,  // Default: roundrobin
        description {"Spatial allocation mode (0=fixed, 1=roundrobin, 2=random, 3=weighted, 4=loadbalance, 5=pitchmap, 6=trajectory)"},
        range {0, 6}
    };

    // Fixed mode
    attribute<int> fixed_channel {
        this, "fixedchan", 0,
        description {"Target channel for fixed mode (0-15)"},
        range {0, 15}
    };

    // Round-robin mode
    attribute<int> rr_step {
        this, "rrstep", 1,
        description {"Round-robin step size"},
        range {1, 16}
    };

    // Random mode
    attribute<number> random_spread {
        this, "randspread", 0.0,
        description {"Random mode panning spread (0.0-1.0)"},
        range {0.0, 1.0}
    };

    attribute<number> spatial_corr {
        this, "spatialcorr", 0.0,
        description {"Spatial correlation between grains (0.0-1.0)"},
        range {0.0, 1.0}
    };

    // Pitchmap mode
    attribute<number> pitch_min {
        this, "pitchmin", 20.0,
        description {"Minimum pitch for pitchmap mode (Hz)"},
        range {20.0, 20000.0}
    };

    attribute<number> pitch_max {
        this, "pitchmax", 20000.0,
        description {"Maximum pitch for pitchmap mode (Hz)"},
        range {20.0, 20000.0}
    };

    // Trajectory mode
    attribute<int> traj_shape {
        this, "trajshape", 0,
        description {"Trajectory shape (0=sine, 1=saw, 2=triangle, 3=randomwalk)"},
        range {0, 3}
    };

    attribute<number> traj_rate {
        this, "trajrate", 0.5,
        description {"Trajectory rate in Hz"},
        range {0.001, 100.0}
    };

    attribute<number> traj_depth {
        this, "trajdepth", 1.0,
        description {"Trajectory depth - proportion of channels used (0.0-1.0)"},
        range {0.0, 1.0}
    };

    // BUFFER PARAMETERS (Phase 6)

    attribute<symbol> buffer_name {
        this, "buffer", "",
        description {"Buffer~ name for audio source"},
        setter { MIN_FUNCTION {
            std::string name = std::string(args[0]);
            if (!name.empty()) {
                auto audio_buf = ec2_buffer::loadFromMaxBuffer(name);
                if (audio_buf) {
                    m_engine->setAudioBuffer(audio_buf, 0);
                    cout << "ec2~: loaded buffer '" << name << "' (" << audio_buf->frames
                         << " frames, " << audio_buf->channels << " channels)" << endl;
                } else {
                    cerr << "ec2~: failed to load buffer '" << name << "'" << endl;
                }
            }
            return args;
        }}
    };

    attribute<int> sound_file {
        this, "soundfile", 0,
        description {"Sound file index for polybuffer~ (0-based)"},
        range {0, 15}
    };

    // LFO PARAMETERS (Phase 9)

    // LFO 1
    attribute<int> lfo1_shape {
        this, "lfo1shape", 0,
        description {"LFO1 shape: 0=sine, 1=square, 2=rise, 3=fall, 4=noise"},
        range {0, 4},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(0);
            if (lfo) lfo->setShape(static_cast<ec2::LFOShape>(static_cast<int>(args[0])));
            return args;
        }}
    };

    attribute<number> lfo1_rate {
        this, "lfo1rate", 1.0,
        description {"LFO1 frequency in Hz"},
        range {0.001, 100.0},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(0);
            if (lfo) lfo->setFrequency(args[0]);
            return args;
        }}
    };

    attribute<int> lfo1_polarity {
        this, "lfo1polarity", 0,
        description {"LFO1 polarity: 0=bipolar, 1=unipolar+, 2=unipolar-"},
        range {0, 2},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(0);
            if (lfo) lfo->setPolarity(static_cast<ec2::LFOPolarity>(static_cast<int>(args[0])));
            return args;
        }}
    };

    attribute<number> lfo1_duty {
        this, "lfo1duty", 0.5,
        description {"LFO1 duty cycle (for square wave)"},
        range {0.0, 1.0},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(0);
            if (lfo) lfo->setDuty(args[0]);
            return args;
        }}
    };

    // LFO 2
    attribute<int> lfo2_shape {
        this, "lfo2shape", 0,
        description {"LFO2 shape: 0=sine, 1=square, 2=rise, 3=fall, 4=noise"},
        range {0, 4},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(1);
            if (lfo) lfo->setShape(static_cast<ec2::LFOShape>(static_cast<int>(args[0])));
            return args;
        }}
    };

    attribute<number> lfo2_rate {
        this, "lfo2rate", 1.0,
        description {"LFO2 frequency in Hz"},
        range {0.001, 100.0},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(1);
            if (lfo) lfo->setFrequency(args[0]);
            return args;
        }}
    };

    attribute<int> lfo2_polarity {
        this, "lfo2polarity", 0,
        description {"LFO2 polarity: 0=bipolar, 1=unipolar+, 2=unipolar-"},
        range {0, 2},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(1);
            if (lfo) lfo->setPolarity(static_cast<ec2::LFOPolarity>(static_cast<int>(args[0])));
            return args;
        }}
    };

    attribute<number> lfo2_duty {
        this, "lfo2duty", 0.5,
        description {"LFO2 duty cycle (for square wave)"},
        range {0.0, 1.0},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(1);
            if (lfo) lfo->setDuty(args[0]);
            return args;
        }}
    };

    // LFO 3
    attribute<int> lfo3_shape {
        this, "lfo3shape", 0,
        description {"LFO3 shape: 0=sine, 1=square, 2=rise, 3=fall, 4=noise"},
        range {0, 4},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(2);
            if (lfo) lfo->setShape(static_cast<ec2::LFOShape>(static_cast<int>(args[0])));
            return args;
        }}
    };

    attribute<number> lfo3_rate {
        this, "lfo3rate", 1.0,
        description {"LFO3 frequency in Hz"},
        range {0.001, 100.0},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(2);
            if (lfo) lfo->setFrequency(args[0]);
            return args;
        }}
    };

    attribute<int> lfo3_polarity {
        this, "lfo3polarity", 0,
        description {"LFO3 polarity: 0=bipolar, 1=unipolar+, 2=unipolar-"},
        range {0, 2},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(2);
            if (lfo) lfo->setPolarity(static_cast<ec2::LFOPolarity>(static_cast<int>(args[0])));
            return args;
        }}
    };

    attribute<number> lfo3_duty {
        this, "lfo3duty", 0.5,
        description {"LFO3 duty cycle (for square wave)"},
        range {0.0, 1.0},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(2);
            if (lfo) lfo->setDuty(args[0]);
            return args;
        }}
    };

    // LFO 4
    attribute<int> lfo4_shape {
        this, "lfo4shape", 0,
        description {"LFO4 shape: 0=sine, 1=square, 2=rise, 3=fall, 4=noise"},
        range {0, 4},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(3);
            if (lfo) lfo->setShape(static_cast<ec2::LFOShape>(static_cast<int>(args[0])));
            return args;
        }}
    };

    attribute<number> lfo4_rate {
        this, "lfo4rate", 1.0,
        description {"LFO4 frequency in Hz"},
        range {0.001, 100.0},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(3);
            if (lfo) lfo->setFrequency(args[0]);
            return args;
        }}
    };

    attribute<int> lfo4_polarity {
        this, "lfo4polarity", 0,
        description {"LFO4 polarity: 0=bipolar, 1=unipolar+, 2=unipolar-"},
        range {0, 2},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(3);
            if (lfo) lfo->setPolarity(static_cast<ec2::LFOPolarity>(static_cast<int>(args[0])));
            return args;
        }}
    };

    attribute<number> lfo4_duty {
        this, "lfo4duty", 0.5,
        description {"LFO4 duty cycle (for square wave)"},
        range {0.0, 1.0},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(3);
            if (lfo) lfo->setDuty(args[0]);
            return args;
        }}
    };

    // LFO 5
    attribute<int> lfo5_shape {
        this, "lfo5shape", 0,
        description {"LFO5 shape: 0=sine, 1=square, 2=rise, 3=fall, 4=noise"},
        range {0, 4},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(4);
            if (lfo) lfo->setShape(static_cast<ec2::LFOShape>(static_cast<int>(args[0])));
            return args;
        }}
    };

    attribute<number> lfo5_rate {
        this, "lfo5rate", 1.0,
        description {"LFO5 frequency in Hz"},
        range {0.001, 100.0},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(4);
            if (lfo) lfo->setFrequency(args[0]);
            return args;
        }}
    };

    attribute<int> lfo5_polarity {
        this, "lfo5polarity", 0,
        description {"LFO5 polarity: 0=bipolar, 1=unipolar+, 2=unipolar-"},
        range {0, 2},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(4);
            if (lfo) lfo->setPolarity(static_cast<ec2::LFOPolarity>(static_cast<int>(args[0])));
            return args;
        }}
    };

    attribute<number> lfo5_duty {
        this, "lfo5duty", 0.5,
        description {"LFO5 duty cycle (for square wave)"},
        range {0.0, 1.0},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(4);
            if (lfo) lfo->setDuty(args[0]);
            return args;
        }}
    };

    // LFO 6
    attribute<int> lfo6_shape {
        this, "lfo6shape", 0,
        description {"LFO6 shape: 0=sine, 1=square, 2=rise, 3=fall, 4=noise"},
        range {0, 4},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(5);
            if (lfo) lfo->setShape(static_cast<ec2::LFOShape>(static_cast<int>(args[0])));
            return args;
        }}
    };

    attribute<number> lfo6_rate {
        this, "lfo6rate", 1.0,
        description {"LFO6 frequency in Hz"},
        range {0.001, 100.0},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(5);
            if (lfo) lfo->setFrequency(args[0]);
            return args;
        }}
    };

    attribute<int> lfo6_polarity {
        this, "lfo6polarity", 0,
        description {"LFO6 polarity: 0=bipolar, 1=unipolar+, 2=unipolar-"},
        range {0, 2},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(5);
            if (lfo) lfo->setPolarity(static_cast<ec2::LFOPolarity>(static_cast<int>(args[0])));
            return args;
        }}
    };

    attribute<number> lfo6_duty {
        this, "lfo6duty", 0.5,
        description {"LFO6 duty cycle (for square wave)"},
        range {0.0, 1.0},
        setter { MIN_FUNCTION {
            auto lfo = m_engine->getLFO(5);
            if (lfo) lfo->setDuty(args[0]);
            return args;
        }}
    };

    // MESSAGES

    message<> dspsetup {
        this, "dspsetup",
        MIN_FUNCTION {
            cout << "ec2~ dspsetup: " << samplerate() << " Hz" << endl;

            // Initialize engine with sample rate
            m_engine->setSampleRate(static_cast<float>(samplerate()));

            // Update engine parameters from attributes
            updateEngineParameters();

            return {};
        }
    };

    message<> clear {
        this, "clear",
        MIN_FUNCTION {
            cout << "ec2~ clear: stopping all grains" << endl;
            m_engine->stopAllGrains();
            return {};
        }
    };

    message<> m_read {
        this, "read",
        MIN_FUNCTION {
            if (args.empty()) {
                cerr << "ec2~: read requires a buffer name argument" << endl;
                return {};
            }

            symbol buffer_sym = args[0];
            std::string buffer_str = std::string(buffer_sym);

            auto audio_buf = ec2_buffer::loadFromMaxBuffer(buffer_str);
            if (audio_buf) {
                m_engine->setAudioBuffer(audio_buf, 0);
                buffer_name = buffer_sym;
                cout << "ec2~: loaded buffer '" << buffer_str << "' (" << audio_buf->frames
                     << " frames, " << audio_buf->channels << " channels)" << endl;
            } else {
                cerr << "ec2~: failed to load buffer '" << buffer_str << "'" << endl;
            }

            return {};
        }
    };

    message<> polybuffer {
        this, "polybuffer",
        MIN_FUNCTION {
            if (args.size() < 2) {
                cerr << "ec2~: polybuffer requires basename and count arguments" << endl;
                return {};
            }

            symbol basename = args[0];
            int count = static_cast<int>(args[1]);

            cout << "ec2~: loading polybuffer '" << std::string(basename) << "' with " << count << " buffers" << endl;

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

            cout << "ec2~: loaded " << loaded_count << " of " << count << " polybuffer slots" << endl;

            return {};
        }
    };

    message<> modroute {
        this, "modroute",
        MIN_FUNCTION {
            if (args.size() < 2) {
                cerr << "ec2~: modroute requires parameter name and LFO number (or 'none')" << endl;
                cerr << "      usage: modroute <param> <lfo_num> [depth]" << endl;
                cerr << "      example: modroute grainrate 1 0.5" << endl;
                return {};
            }

            symbol param_sym = args[0];
            std::string param_name = std::string(param_sym);

            // Get modulation parameters reference
            ec2::ModulationParameters* modParams = getModulationParameters(param_name);
            if (!modParams) {
                cerr << "ec2~: unknown parameter '" << param_name << "'" << endl;
                return {};
            }

            // Check if clearing modulation
            if (args.size() == 2) {
                symbol lfo_arg = args[1];
                std::string lfo_str = std::string(lfo_arg);
                if (lfo_str == "none" || lfo_str == "0") {
                    modParams->lfoSource = 0;
                    modParams->depth = 0.0f;
                    cout << "ec2~: cleared modulation from " << param_name << endl;
                    return {};
                }
            }

            // Setting modulation
            int lfo_num = args[1];
            float depth = (args.size() >= 3) ? static_cast<float>(args[2]) : 0.5f;

            if (lfo_num < 0 || lfo_num > 6) {
                cerr << "ec2~: LFO number must be 0-6 (0=none, 1-6=LFO1-6)" << endl;
                return {};
            }

            modParams->lfoSource = lfo_num;
            modParams->depth = std::max(0.0f, std::min(depth, 1.0f));

            if (lfo_num == 0) {
                cout << "ec2~: cleared modulation from " << param_name << endl;
            } else {
                cout << "ec2~: routed LFO" << lfo_num << " to " << param_name
                     << " (depth " << modParams->depth << ")" << endl;
            }

            return {};
        }
    };

    message<> anything {
        this, "anything",
        MIN_FUNCTION {
            // Handle OSC-style messages: /param_name value
            // Also handle odot bundles (FullPacket format)

            if (inlet == 0) {  // Only handle messages on main inlet
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

                    // Get the value (should be second argument)
                    if (args.size() >= 2) {
                        handleOSCParameter(param_name, args[1]);
                    }
                }
                // Check if it's an odot FullPacket bundle
                else if (msg_str == "FullPacket") {
                    // Handle odot bundle format
                    // FullPacket is followed by OSC bundle data
                    // For now, we'll parse individual messages from the bundle
                    // This is a simplified implementation
                    cout << "ec2~: received FullPacket OSC bundle" << endl;
                    // TODO: Full odot bundle parsing if needed
                }
            }

            return {};
        }
    };

    message<> bang {
        this, "bang",
        MIN_FUNCTION {
            // Output current parameter state as OSC bundle
            outputOSCState();
            return {};
        }
    };

    message<> waveform {
        this, "waveform",
        MIN_FUNCTION {
            // Phase 13: Report buffer waveform info (simplified approach)
            // Full graphical display requires jbox UI object which is beyond min-devkit scope

            int buffer_index = static_cast<int>(sound_file.get());
            auto current_buffer = m_engine->getAudioBuffer(buffer_index);

            if (!current_buffer || current_buffer->size == 0) {
                cout << "ec2~: no buffer loaded" << endl;
                return {};
            }

            cout << "ec2~: buffer info:" << endl;
            cout << "  frames: " << current_buffer->frames << endl;
            cout << "  channels: " << current_buffer->channels << endl;
            float sr = m_engine->getSampleRate();
            cout << "  sample rate: " << sr << " Hz" << endl;
            cout << "  duration: " << (current_buffer->frames / sr) << " seconds" << endl;

            // Calculate and report peak amplitude
            float peak = 0.0f;
            for (size_t i = 0; i < current_buffer->size; ++i) {
                float abs_val = std::abs(current_buffer->data[i]);
                if (abs_val > peak) peak = abs_val;
            }
            cout << "  peak amplitude: " << peak << " (" << (20.0 * log10(peak)) << " dB)" << endl;

            return {};
        }
    };

    message<> openbuffer {
        this, "openbuffer",
        MIN_FUNCTION {
            // Phase 13: Open buffer editor
            // This provides a way to view/edit the waveform using Max's built-in buffer editor

            std::string buf_name_str = std::string(buffer_name.get());
            if (buf_name_str.empty()) {
                cout << "ec2~: no buffer loaded (use 'read' or 'polybuffer' message first)" << endl;
                return {};
            }

            // Open buffer editor using Max SDK
            auto buf_ref = c74::max::buffer_ref_new((c74::max::t_object*)this->maxobj(), buffer_name.get());
            if (buf_ref) {
                auto buffer = c74::max::buffer_ref_getobject(buf_ref);
                if (buffer) {
                    // Send 'wclose' then 'open' to ensure editor appears
                    c74::max::object_method_typed(buffer, c74::max::gensym("wclose"), 0, nullptr, nullptr);
                    c74::max::object_method_typed(buffer, c74::max::gensym("open"), 0, nullptr, nullptr);
                    cout << "ec2~: opened buffer editor for '" << buf_name_str << "'" << endl;
                } else {
                    cerr << "ec2~: failed to get buffer object" << endl;
                }
                c74::max::object_free((c74::max::t_object*)buf_ref);
            } else {
                cerr << "ec2~: failed to create buffer reference" << endl;
            }

            return {};
        }
    };

    message<> dblclick {
        this, "dblclick",
        MIN_FUNCTION {
            // Phase 13: Double-click opens buffer editor (like waveform~)
            // Delegate to openbuffer message
            atoms a;
            this->try_call("openbuffer", a);
            return {};
        }
    };

    // Audio processing
    void operator()(audio_bundle input, audio_bundle output) {
        // Update engine parameters from attributes (in case they changed)
        updateEngineParameters();

        // Get output configuration
        auto out_channels = output.channel_count();
        auto frame_count = output.frame_count();
        auto in_channels = input.channel_count();

        // Allocate temporary float buffers (engine uses float, min-devkit uses double)
        std::vector<std::vector<float>> tempBuffers(out_channels);
        std::vector<float*> outBuffers(out_channels);

        for (size_t ch = 0; ch < out_channels; ++ch) {
            tempBuffers[ch].resize(frame_count, 0.0f);
            outBuffers[ch] = tempBuffers[ch].data();
        }

        // Process signal inputs (Phase 12)
        // Signal inlets: 0=scan position, 1=grain rate, 2=playback rate
        bool has_scan_signal = (in_channels > 0);
        bool has_rate_signal = (in_channels > 1);
        bool has_playback_signal = (in_channels > 2);

        // Prepare signal buffers (convert double to float)
        std::vector<float> scan_signal(frame_count);
        std::vector<float> rate_signal(frame_count);
        std::vector<float> playback_signal(frame_count);

        if (has_scan_signal) {
            auto scan_in = input.samples(0);
            for (size_t i = 0; i < frame_count; ++i) {
                scan_signal[i] = static_cast<float>(scan_in[i]);
            }
        }

        if (has_rate_signal) {
            auto rate_in = input.samples(1);
            for (size_t i = 0; i < frame_count; ++i) {
                rate_signal[i] = static_cast<float>(rate_in[i]);
            }
        }

        if (has_playback_signal) {
            auto pb_in = input.samples(2);
            for (size_t i = 0; i < frame_count; ++i) {
                playback_signal[i] = static_cast<float>(pb_in[i]);
            }
        }

        // Process synthesis engine with signal inputs
        m_engine->processWithSignals(
            outBuffers.data(),
            static_cast<int>(out_channels),
            static_cast<int>(frame_count),
            has_scan_signal ? scan_signal.data() : nullptr,
            has_rate_signal ? rate_signal.data() : nullptr,
            has_playback_signal ? playback_signal.data() : nullptr
        );

        // Copy float output to double output buffers
        for (size_t ch = 0; ch < out_channels; ++ch) {
            auto out_samples = output.samples(ch);
            for (size_t i = 0; i < frame_count; ++i) {
                out_samples[i] = static_cast<double>(tempBuffers[ch][i]);
            }
        }
    }

private:
    int m_mc_mode {0};      // Output mode: 0=separated outputs, 1=multichannel cable
    int m_outputs {2};      // Number of output channels (1-16)
    std::unique_ptr<ec2::GranularEngine> m_engine;

    // Helper: get effective output channel count
    size_t getOutputChannelCount() const {
        // @outputs controls the number of channels
        // @mc only controls whether they're delivered as separated outputs or bundled in a multichannel cable
        return m_outputs;
    }

    // Helper: get modulation parameters for a given parameter name (Phase 9)
    ec2::ModulationParameters* getModulationParameters(const std::string& param_name) {
        auto& params = m_engine->getParameters();

        if (param_name == "grainrate") return const_cast<ec2::ModulationParameters*>(&params.modGrainRate);
        if (param_name == "async") return const_cast<ec2::ModulationParameters*>(&params.modAsync);
        if (param_name == "intermittency") return const_cast<ec2::ModulationParameters*>(&params.modIntermittency);
        if (param_name == "streams") return const_cast<ec2::ModulationParameters*>(&params.modStreams);
        if (param_name == "playback") return const_cast<ec2::ModulationParameters*>(&params.modPlaybackRate);
        if (param_name == "duration") return const_cast<ec2::ModulationParameters*>(&params.modGrainDuration);
        if (param_name == "envelope") return const_cast<ec2::ModulationParameters*>(&params.modEnvelope);
        if (param_name == "filterfreq") return const_cast<ec2::ModulationParameters*>(&params.modFilterFreq);
        if (param_name == "resonance") return const_cast<ec2::ModulationParameters*>(&params.modResonance);
        if (param_name == "pan") return const_cast<ec2::ModulationParameters*>(&params.modPan);
        if (param_name == "amp") return const_cast<ec2::ModulationParameters*>(&params.modAmplitude);
        if (param_name == "scanstart") return const_cast<ec2::ModulationParameters*>(&params.modScanBegin);
        if (param_name == "scanrange") return const_cast<ec2::ModulationParameters*>(&params.modScanRange);
        if (param_name == "scanspeed") return const_cast<ec2::ModulationParameters*>(&params.modScanSpeed);

        return nullptr;
    }

    // Helper: update engine parameters from attributes
    void updateEngineParameters() {
        ec2::SynthParameters params;

        // Grain scheduling
        params.grainRate = grain_rate;
        params.async = async;
        params.intermittency = intermittency;
        params.streams = streams;

        // Grain characteristics
        params.playbackRate = playback_rate;
        params.grainDuration = grain_duration;
        params.envelope = envelope_shape;
        params.pan = stereo_pan;
        params.amplitude = amplitude;

        // Filtering
        params.filterFreq = filter_freq;
        params.resonance = filter_resonance;

        // Scanning
        params.scanBegin = scan_start;
        params.scanRange = scan_range;
        params.scanSpeed = scan_speed;
        params.soundFile = sound_file;  // Phase 6: Buffer selection

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
        params.spatial.trajShape = static_cast<ec2::TrajectoryShape>(traj_shape.get());
        params.spatial.trajRate = traj_rate;
        params.spatial.trajDepth = traj_depth;

        m_engine->updateParameters(params);
    }

    // Helper: handle OSC parameter setting (Phase 10)
    void handleOSCParameter(const std::string& param_name, const atom& value) {
        // Map OSC parameter names to attributes
        // Use lowercase, no special chars for OSC compatibility

        try {
            double val = static_cast<double>(value);

            // Grain scheduling
            if (param_name == "grainrate") { grain_rate = val; }
            else if (param_name == "async") { async = val; }
            else if (param_name == "intermittency") { intermittency = val; }
            else if (param_name == "streams") { streams = val; }

            // Grain characteristics
            else if (param_name == "playback") { playback_rate = val; }
            else if (param_name == "duration") { grain_duration = val; }
            else if (param_name == "envelope") { envelope_shape = val; }
            else if (param_name == "amp" || param_name == "amplitude") { amplitude = val; }

            // Filtering
            else if (param_name == "filterfreq") { filter_freq = val; }
            else if (param_name == "resonance") { filter_resonance = val; }

            // Stereo panning
            else if (param_name == "pan") { stereo_pan = val; }

            // Scanning
            else if (param_name == "scanstart") { scan_start = val; }
            else if (param_name == "scanrange") { scan_range = val; }
            else if (param_name == "scanspeed") { scan_speed = val; }

            // Buffer
            else if (param_name == "soundfile") { sound_file = static_cast<int>(val); }

            // Multichannel
            else if (param_name == "mc") { m_mc_mode = static_cast<int>(val); }
            else if (param_name == "outputs") { m_outputs = static_cast<int>(val); }

            // Spatial allocation
            else if (param_name == "allocmode") { alloc_mode = static_cast<int>(val); }
            else if (param_name == "fixedchan") { fixed_channel = static_cast<int>(val); }
            else if (param_name == "rrstep") { rr_step = static_cast<int>(val); }
            else if (param_name == "randspread") { random_spread = val; }
            else if (param_name == "spatialcorr") { spatial_corr = val; }
            else if (param_name == "pitchmin") { pitch_min = val; }
            else if (param_name == "pitchmax") { pitch_max = val; }
            else if (param_name == "trajshape") { traj_shape = static_cast<int>(val); }
            else if (param_name == "trajrate") { traj_rate = val; }
            else if (param_name == "trajdepth") { traj_depth = val; }

            // LFOs (simplified - just rates for now, can expand)
            else if (param_name == "lfo1rate") { lfo1_rate = val; }
            else if (param_name == "lfo2rate") { lfo2_rate = val; }
            else if (param_name == "lfo3rate") { lfo3_rate = val; }
            else if (param_name == "lfo4rate") { lfo4_rate = val; }
            else if (param_name == "lfo5rate") { lfo5_rate = val; }
            else if (param_name == "lfo6rate") { lfo6_rate = val; }

            else {
                // Unknown parameter - ignore silently for OSC compatibility
                // (some OSC messages might be for other purposes)
            }

            // Update engine parameters after setting
            updateEngineParameters();

        } catch (...) {
            // Type conversion error - ignore
        }
    }

    // Helper: output current parameter state as OSC bundle (Phase 10)
    void outputOSCState() {
        // Output all parameters as OSC address/value pairs
        // Format compatible with o.display and odot library

        // Send as multiple messages in OSC format
        // Each message: "/param_name value"

        osc_out.send("/grainrate", grain_rate.get());
        osc_out.send("/async", async.get());
        osc_out.send("/intermittency", intermittency.get());
        osc_out.send("/streams", streams.get());

        osc_out.send("/playback", playback_rate.get());
        osc_out.send("/duration", grain_duration.get());
        osc_out.send("/envelope", envelope_shape.get());
        osc_out.send("/amp", amplitude.get());

        osc_out.send("/filterfreq", filter_freq.get());
        osc_out.send("/resonance", filter_resonance.get());

        osc_out.send("/pan", stereo_pan.get());

        osc_out.send("/scanstart", scan_start.get());
        osc_out.send("/scanrange", scan_range.get());
        osc_out.send("/scanspeed", scan_speed.get());

        osc_out.send("/soundfile", sound_file.get());

        osc_out.send("/mc", m_mc_mode);
        osc_out.send("/outputs", m_outputs);

        osc_out.send("/allocmode", alloc_mode.get());
        osc_out.send("/fixedchan", fixed_channel.get());
        osc_out.send("/rrstep", rr_step.get());
        osc_out.send("/randspread", random_spread.get());
        osc_out.send("/spatialcorr", spatial_corr.get());
        osc_out.send("/pitchmin", pitch_min.get());
        osc_out.send("/pitchmax", pitch_max.get());
        osc_out.send("/trajshape", traj_shape.get());
        osc_out.send("/trajrate", traj_rate.get());
        osc_out.send("/trajdepth", traj_depth.get());

        // LFO rates (can expand to include shape, polarity, duty if needed)
        osc_out.send("/lfo1rate", lfo1_rate.get());
        osc_out.send("/lfo2rate", lfo2_rate.get());
        osc_out.send("/lfo3rate", lfo3_rate.get());
        osc_out.send("/lfo4rate", lfo4_rate.get());
        osc_out.send("/lfo5rate", lfo5_rate.get());
        osc_out.send("/lfo6rate", lfo6_rate.get());
    }
};

MIN_EXTERNAL(ec2_tilde);
