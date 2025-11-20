/// @file ec2_tilde.cpp
/// @brief EmissionControl2 granular synthesis external with multichannel output
/// @author Alessandro Anatrini
/// @license GPL-3.0

#include "c74_min.h"
#include "ec2_constants.h"
#include "ec2_utility.h"
#include "ec2_engine.h"

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

    // Audio processing
    void operator()(audio_bundle input, audio_bundle output) {
        // Update engine parameters from attributes (in case they changed)
        updateEngineParameters();

        // Get output configuration
        auto out_channels = output.channel_count();
        auto frame_count = output.frame_count();

        // Allocate temporary float buffers (engine uses float, min-devkit uses double)
        std::vector<std::vector<float>> tempBuffers(out_channels);
        std::vector<float*> outBuffers(out_channels);

        for (size_t ch = 0; ch < out_channels; ++ch) {
            tempBuffers[ch].resize(frame_count, 0.0f);
            outBuffers[ch] = tempBuffers[ch].data();
        }

        // Process synthesis engine
        m_engine->process(outBuffers.data(), static_cast<int>(out_channels),
                         static_cast<int>(frame_count));

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
};

MIN_EXTERNAL(ec2_tilde);
