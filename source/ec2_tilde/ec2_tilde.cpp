/// @file ec2_tilde.cpp
/// @brief EmissionControl2 granular synthesis external with multichannel output
/// @author Alessandro Anatrini
/// @license GPL-3.0

#include "c74_min.h"
#include "ec2_constants.h"
#include "ec2_utility.h"
#include "ec2_engine.h"

using namespace c74::min;

class ec2_tilde : public object<ec2_tilde>, public mc_operator<> {
public:
    MIN_DESCRIPTION {"EmissionControl2 granular synthesis with multichannel output (up to 16 channels)"};
    MIN_TAGS {"audio, synthesis, granular"};
    MIN_AUTHOR {"Alessandro Anatrini"};
    MIN_RELATED {"polybuffer~, groove~"};

    // Constructor
    ec2_tilde(const atoms& args = {}) {
        // Parse arguments: ec2~ [num_channels]
        if (!args.empty()) {
            int requested_channels = args[0];
            if (requested_channels > 0 && requested_channels <= 16) {
                m_num_channels = requested_channels;
            }
        }

        cout << "ec2~ initialized with " << m_num_channels << " output channels" << endl;

        // Initialize synthesis engine
        m_engine = std::make_unique<ec2::GranularEngine>(2048);  // Max 2048 grains
    }

    // Multichannel configuration
    size_t mc_get_output_channel_count() const {
        return m_num_channels;
    }

    // ATTRIBUTES (EC2 Parameters)

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

    attribute<number> spatial_mode {
        this, "spatialmode", 0,
        description {"Spatial distribution mode (0=mono, 1=stereo, 2=multichannel)"},
        range {0, 2}
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
            symbol filename = args[0];
            cout << "ec2~ read message: " << filename << endl;
            cout << "  (Note: Use Max buffer~ objects for audio - polybuffer~ support coming in Phase 5)" << endl;

            // TODO Phase 5: Implement buffer~ / polybuffer~ reference
            // For now, users should use buffer~ and we'll read from it

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
    int m_num_channels {2};  // Default to stereo
    std::unique_ptr<ec2::GranularEngine> m_engine;

    // Helper: update engine parameters from attributes
    void updateEngineParameters() {
        ec2::SynthParameters params;
        params.grainRate = grain_rate;
        params.async = async;
        params.intermittency = intermittency;
        params.streams = streams;
        params.playbackRate = playback_rate;
        params.grainDuration = grain_duration;
        params.envelope = scan_start;  // Note: using scan_start temporarily for envelope
        params.pan = 0.0f;  // TODO: add pan attribute
        params.amplitude = amplitude;
        params.filterFreq = 1000.0f;  // TODO: add filter attributes
        params.resonance = 0.0f;
        params.scanBegin = scan_start;
        params.scanRange = scan_range;
        params.soundFile = 0;  // TODO: implement buffer selection

        m_engine->updateParameters(params);
    }
};

MIN_EXTERNAL(ec2_tilde);
