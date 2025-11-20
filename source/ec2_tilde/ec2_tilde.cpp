/// @file ec2_tilde.cpp
/// @brief EmissionControl2 granular synthesis external with multichannel output
/// @author Alessandro Anatrini
/// @license GPL-3.0

#include "c74_min.h"
#include "ec2_constants.h"
#include "ec2_utility.h"

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

            // TODO: Initialize EC2 audio engine here
            // - Set up grain scheduler
            // - Initialize audio buffers
            // - Configure sample rate

            return {};
        }
    };

    message<> clear {
        this, "clear",
        MIN_FUNCTION {
            cout << "ec2~ clear: stopping all grains" << endl;
            // TODO: Stop all active grains
            return {};
        }
    };

    message<> m_read {
        this, "read",
        MIN_FUNCTION {
            symbol filename = args[0];
            cout << "ec2~ loading sound file: " << filename << endl;

            // TODO: Load audio file into buffer
            // - Support multiple simultaneous sound files
            // - Use libsndfile or Max's buffer~ infrastructure

            return {};
        }
    };

    // Audio processing
    void operator()(audio_bundle input, audio_bundle output) {
        // Get number of output channels
        auto out_channels = output.channel_count();
        auto frame_count = output.frame_count();

        // TODO: Replace this with actual EC2 grain synthesis
        // For now, output silence
        for (auto channel = 0; channel < out_channels; ++channel) {
            auto out = output.samples(channel);
            for (auto i = 0; i < frame_count; ++i) {
                out[i] = 0.0;
            }
        }

        /*
         * GRAIN SYNTHESIS PIPELINE (to be implemented):
         *
         * 1. Update grain scheduler based on grain_rate and async
         * 2. Trigger new grains based on scheduling
         * 3. For each active grain:
         *    - Read from source buffer at playback_rate
         *    - Apply envelope (from scan position)
         *    - Apply amplitude
         *    - Assign to output channel based on spatial_mode
         * 4. Mix all grains to output channels
         * 5. Handle multichannel distribution:
         *    - Mode 0 (mono): all grains to all channels equally
         *    - Mode 1 (stereo): grains distributed L-R
         *    - Mode 2 (multichannel): grains round-robin or spatially distributed
         */
    }

private:
    int m_num_channels {2};  // Default to stereo

    // TODO: Add EC2 synthesis engine members
    // - Grain pool/scheduler
    // - Audio buffers for loaded files
    // - LFO modulators
    // - Filter states
};

MIN_EXTERNAL(ec2_tilde);
