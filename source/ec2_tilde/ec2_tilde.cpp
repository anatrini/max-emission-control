/// @file ec2_tilde.cpp
/// @brief EmissionControl2 granular synthesis external - Pure Max SDK
/// @author Alessandro Anatrini
/// @license GPL-3.0

#include "ext.h"
#include "ext_obex.h"
#include "z_dsp.h"
#include "ext_buffer.h"
#include <vector>
#include <memory>
#include <cstring>
#include <string>
#include <algorithm>
#include <arpa/inet.h>  // for htonl (network byte order)

// EC2 engine includes
#include "ec2_constants.h"
#include "ec2_engine.h"
#include "ec2_utility.h"
#include "ec2_version.h"

// Buffer loading helper
namespace ec2_buffer_helper {
inline std::shared_ptr<ec2::AudioBuffer<float>>
loadFromMaxBuffer(const std::string& buffer_name) {
  if (buffer_name.empty()) return nullptr;

  auto buf_ref = buffer_ref_new(nullptr, gensym(buffer_name.c_str()));
  if (!buf_ref) return nullptr;

  auto buffer = buffer_ref_getobject(buf_ref);
  if (!buffer) {
    object_free(buf_ref);
    return nullptr;
  }

  long frames = buffer_getframecount(buffer);
  long channels = buffer_getchannelcount(buffer);

  if (frames == 0 || channels == 0) {
    object_free(buf_ref);
    return nullptr;
  }

  float* buffer_data = buffer_locksamples(buffer);
  if (!buffer_data) {
    object_free(buf_ref);
    return nullptr;
  }

  auto audio_buf = std::make_shared<ec2::AudioBuffer<float>>();
  audio_buf->channels = static_cast<int>(channels);
  audio_buf->frames = static_cast<int>(frames);
  audio_buf->size = static_cast<int>(frames * channels);
  audio_buf->data = new float[audio_buf->size];

  std::copy(buffer_data, buffer_data + audio_buf->size, audio_buf->data);

  buffer_unlocksamples(buffer);
  object_free(buf_ref);

  return audio_buf;
}
} // namespace ec2_buffer_helper

// LFO destination structure (up to 8 destinations per LFO)
#define MAX_LFO_DESTINATIONS 8

struct LFODestination {
  std::string param_name;  // Parameter being modulated
  double depth;            // Modulation depth (0.0-1.0)

  LFODestination() : param_name(""), depth(1.0) {}
  LFODestination(const std::string& name, double d) : param_name(name), depth(d) {}
};

struct LFOState {
  double global_depth;                           // Global depth for this LFO (0.0-1.0)
  std::vector<LFODestination> destinations;      // Active destinations (max 8)

  LFOState() : global_depth(1.0) {}
};

// Main object struct
typedef struct _ec2 {
  t_pxobject ob;  // MUST be first

  // Output configuration
  long outputs;
  long mc_mode;
  std::vector<void*>* signal_outlets;
  void* osc_outlet;

  // EC2 engine
  ec2::GranularEngine* engine;

  // OSC buffers
  std::vector<unsigned char>* osc_bundle_buffer;
  std::vector<unsigned char>* input_buffer;
  bool suppress_osc_output;

  // Basic synthesis parameters
  double grain_rate;
  double async;
  double intermittency;
  double streams;
  double playback_rate;
  double grain_duration;
  double envelope_shape;
  double amplitude;

  // Filtering
  double filter_freq;
  double resonance;

  // Spatial/scanning
  double stereo_pan;
  double scan_start;
  double scan_range;
  double scan_speed;

  // Deviation parameters (14 total)
  double grain_rate_dev;
  double async_dev;
  double intermittency_dev;
  double streams_dev;
  double playback_dev;
  double duration_dev;
  double envelope_dev;
  double pan_dev;
  double amp_dev;
  double filterfreq_dev;
  double resonance_dev;
  double scanstart_dev;
  double scanrange_dev;
  double scanspeed_dev;

  // LFO modulation system (6 LFOs, each can modulate up to 8 parameters)
  LFOState lfo_states[6];        // LFO1-LFO6 states

  // LFO base parameters (24 total: 6 LFOs × 4 params)
  // Stored here so they can be modulated by other LFOs
  int lfo1_shape, lfo2_shape, lfo3_shape, lfo4_shape, lfo5_shape, lfo6_shape;
  double lfo1_rate, lfo2_rate, lfo3_rate, lfo4_rate, lfo5_rate, lfo6_rate;
  int lfo1_polarity, lfo2_polarity, lfo3_polarity, lfo4_polarity, lfo5_polarity, lfo6_polarity;
  double lfo1_duty, lfo2_duty, lfo3_duty, lfo4_duty, lfo5_duty, lfo6_duty;

  // Spatial allocation parameters (10 total)
  long alloc_mode;       // 0-6
  long fixed_channel;    // 1-16
  long rr_step;          // 1-16
  double random_spread;  // 0.0-1.0
  double spatial_corr;   // 0.0-1.0
  double pitch_min;      // 20-20000 Hz
  double pitch_max;      // 20-20000 Hz
  long traj_shape;       // 0-3
  double traj_rate;      // 0.001-100.0 Hz
  double traj_depth;     // 0.0-1.0

  // Buffer management
  t_symbol* buffer_name;
  t_buffer_ref* buffer_ref;  // Reference to monitor buffer~ changes
  long sound_file;

  // Signal inputs
  double* scan_signal;
  double* rate_signal;
  double* playback_signal;

} t_ec2;

// Global class pointer
static t_class* ec2_class = nullptr;

// Function declarations
void* ec2_new(t_symbol* s, long argc, t_atom* argv);
void ec2_free(t_ec2* x);
void ec2_assist(t_ec2* x, void* b, long m, long a, char* s);
void ec2_dblclick(t_ec2* x);
t_max_err ec2_notify(t_ec2* x, t_symbol* s, t_symbol* msg, void* sender, void* data);
void ec2_dsp64(t_ec2* x, t_object* dsp64, short* count, double samplerate, long maxvectorsize, long flags);
void ec2_perform64(t_ec2* x, t_object* dsp64, double** ins, long numins, double** outs, long numouts, long sampleframes, long flags, void* userparam);

// Message handlers - Basic synthesis
void ec2_grainrate(t_ec2* x, double v);
void ec2_async(t_ec2* x, double v);
void ec2_intermittency(t_ec2* x, double v);
void ec2_streams(t_ec2* x, double v);
void ec2_playback(t_ec2* x, double v);
void ec2_duration(t_ec2* x, double v);
void ec2_envelope(t_ec2* x, double v);
void ec2_amplitude(t_ec2* x, double v);

// Filtering
void ec2_filterfreq(t_ec2* x, double v);
void ec2_resonance(t_ec2* x, double v);

// Spatial
void ec2_pan(t_ec2* x, double v);
void ec2_scanstart(t_ec2* x, double v);
void ec2_scanrange(t_ec2* x, double v);
void ec2_scanspeed(t_ec2* x, double v);

// Deviation parameters
void ec2_grainrate_dev(t_ec2* x, double v);
void ec2_async_dev(t_ec2* x, double v);
void ec2_intermittency_dev(t_ec2* x, double v);
void ec2_streams_dev(t_ec2* x, double v);
void ec2_playback_dev(t_ec2* x, double v);
void ec2_duration_dev(t_ec2* x, double v);
void ec2_envelope_dev(t_ec2* x, double v);
void ec2_pan_dev(t_ec2* x, double v);
void ec2_amp_dev(t_ec2* x, double v);
void ec2_filterfreq_dev(t_ec2* x, double v);
void ec2_resonance_dev(t_ec2* x, double v);
void ec2_scanstart_dev(t_ec2* x, double v);
void ec2_scanrange_dev(t_ec2* x, double v);
void ec2_scanspeed_dev(t_ec2* x, double v);

// LFO modulation system (new map/unmap approach)
void ec2_lfo_map(t_ec2* x, t_symbol* s, long argc, t_atom* argv);
void ec2_lfo_unmap(t_ec2* x, t_symbol* s, long argc, t_atom* argv);
void ec2_lfo_depth(t_ec2* x, t_symbol* s, long argc, t_atom* argv);

// Helper functions for LFO routing
int ec2_find_lfo_destination(t_ec2* x, int lfo_num, const std::string& param_name);
int ec2_find_param_lfo_source(t_ec2* x, const std::string& param_name);
double ec2_get_lfo_modulation(t_ec2* x, const std::string& param_name);
void ec2_get_lfo_routing_for_engine(t_ec2* x, const std::string& param_name, int& lfo_source, double& depth);

// Spatial allocation parameters (9 total - converted from attributes to messages)
void ec2_fixedchan(t_ec2* x, long v);
void ec2_rrstep(t_ec2* x, long v);
void ec2_randspread(t_ec2* x, double v);
void ec2_spatialcorr(t_ec2* x, double v);
void ec2_pitchmin(t_ec2* x, double v);
void ec2_pitchmax(t_ec2* x, double v);
void ec2_trajshape(t_ec2* x, long v);
void ec2_trajrate(t_ec2* x, double v);
void ec2_trajdepth(t_ec2* x, double v);

// LFO parameters (24 total: 6 LFOs × 4 params each)
void ec2_lfo1shape(t_ec2* x, double v);
void ec2_lfo1rate(t_ec2* x, double v);
void ec2_lfo1polarity(t_ec2* x, double v);
void ec2_lfo1duty(t_ec2* x, double v);
void ec2_lfo2shape(t_ec2* x, double v);
void ec2_lfo2rate(t_ec2* x, double v);
void ec2_lfo2polarity(t_ec2* x, double v);
void ec2_lfo2duty(t_ec2* x, double v);
void ec2_lfo3shape(t_ec2* x, double v);
void ec2_lfo3rate(t_ec2* x, double v);
void ec2_lfo3polarity(t_ec2* x, double v);
void ec2_lfo3duty(t_ec2* x, double v);
void ec2_lfo4shape(t_ec2* x, double v);
void ec2_lfo4rate(t_ec2* x, double v);
void ec2_lfo4polarity(t_ec2* x, double v);
void ec2_lfo4duty(t_ec2* x, double v);
void ec2_lfo5shape(t_ec2* x, double v);
void ec2_lfo5rate(t_ec2* x, double v);
void ec2_lfo5polarity(t_ec2* x, double v);
void ec2_lfo5duty(t_ec2* x, double v);
void ec2_lfo6shape(t_ec2* x, double v);
void ec2_lfo6rate(t_ec2* x, double v);
void ec2_lfo6polarity(t_ec2* x, double v);
void ec2_lfo6duty(t_ec2* x, double v);

// Spatial allocation attributes (use setter functions)
void ec2_allocmode(t_ec2* x, long v);
void ec2_fixedchan(t_ec2* x, long v);
void ec2_rrstep(t_ec2* x, long v);
void ec2_randspread(t_ec2* x, double v);
void ec2_spatialcorr(t_ec2* x, double v);
void ec2_pitchmin(t_ec2* x, double v);
void ec2_pitchmax(t_ec2* x, double v);
void ec2_trajshape(t_ec2* x, long v);
void ec2_trajrate(t_ec2* x, double v);
void ec2_trajdepth(t_ec2* x, double v);

// Buffer management
void ec2_buffer(t_ec2* x, t_symbol* s);
t_max_err ec2_buffer_setter(t_ec2* x, void* attr, long argc, t_atom* argv);

// Special handlers
void ec2_fullpacket(t_ec2* x, t_symbol* s, long argc, t_atom* argv);
long ec2_multichanneloutputs(t_ec2* x, long index);
void ec2_anything(t_ec2* x, t_symbol* s, long argc, t_atom* argv);

// Helper functions
void ec2_update_engine_params(t_ec2* x);
void ec2_send_osc_bundle(t_ec2* x);
void ec2_parse_osc_bundle(t_ec2* x, const unsigned char* data, size_t size);
void ec2_parse_osc_message(t_ec2* x, const unsigned char* data, size_t size);
void ec2_handle_osc_parameter(t_ec2* x, const std::string& param_name, double value);
std::shared_ptr<ec2::AudioBuffer<float>> ec2_load_buffer(const char* name);

// ==================================================================
// MAIN ENTRY POINT
// ==================================================================

extern "C" void ext_main(void* r) {
  t_class* c = class_new("ec2~",
                         (method)ec2_new,
                         (method)ec2_free,
                         sizeof(t_ec2),
                         nullptr,
                         A_GIMME,
                         0);

  // DSP
  class_addmethod(c, (method)ec2_dsp64, "dsp64", A_CANT, 0);

  // Multichannel support
  class_addmethod(c, (method)ec2_multichanneloutputs, "multichanneloutputs", A_CANT, 0);

  // FullPacket handler (CRITICAL: A_GIMME for udpreceive compatibility)
  class_addmethod(c, (method)ec2_fullpacket, "FullPacket", A_GIMME, 0);

  // Assist and UI
  class_addmethod(c, (method)ec2_assist, "assist", A_CANT, 0);
  class_addmethod(c, (method)ec2_dblclick, "dblclick", A_CANT, 0);
  class_addmethod(c, (method)ec2_notify, "notify", A_CANT, 0);

  // Basic synthesis parameters (float messages)
  class_addmethod(c, (method)ec2_grainrate, "grainrate", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_async, "async", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_intermittency, "intermittency", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_streams, "streams", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_playback, "playback", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_duration, "duration", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_envelope, "envelope", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_amplitude, "amp", A_FLOAT, 0);

  // Filtering
  class_addmethod(c, (method)ec2_filterfreq, "filterfreq", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_resonance, "resonance", A_FLOAT, 0);

  // Spatial
  class_addmethod(c, (method)ec2_pan, "pan", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_scanstart, "scanstart", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_scanrange, "scanrange", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_scanspeed, "scanspeed", A_FLOAT, 0);

  // Deviation parameters
  class_addmethod(c, (method)ec2_grainrate_dev, "grainrate_dev", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_async_dev, "async_dev", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_intermittency_dev, "intermittency_dev", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_streams_dev, "streams_dev", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_playback_dev, "playback_dev", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_duration_dev, "duration_dev", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_envelope_dev, "envelope_dev", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_pan_dev, "pan_dev", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_amp_dev, "amp_dev", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_filterfreq_dev, "filterfreq_dev", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_resonance_dev, "resonance_dev", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_scanstart_dev, "scanstart_dev", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_scanrange_dev, "scanrange_dev", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_scanspeed_dev, "scanspeed_dev", A_FLOAT, 0);

  // LFO modulation system (new map/unmap messages)
  // Format: /lfo<N>_to_<param> map [depth]  or  /lfo<N>_to_<param> unmap
  // These are registered as typed messages with A_GIMME to accept variable arguments
  class_addmethod(c, (method)ec2_lfo_map, "anything", A_GIMME, 0);  // Catch-all for /lfo* messages

  // Spatial allocation parameters (9 total - real-time control)
  class_addmethod(c, (method)ec2_fixedchan, "fixedchan", A_LONG, 0);
  class_addmethod(c, (method)ec2_rrstep, "rrstep", A_LONG, 0);
  class_addmethod(c, (method)ec2_randspread, "randspread", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_spatialcorr, "spatialcorr", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_pitchmin, "pitchmin", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_pitchmax, "pitchmax", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_trajshape, "trajshape", A_LONG, 0);
  class_addmethod(c, (method)ec2_trajrate, "trajrate", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_trajdepth, "trajdepth", A_FLOAT, 0);

  // LFO parameters (24 total)
  class_addmethod(c, (method)ec2_lfo1shape, "lfo1shape", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo1rate, "lfo1rate", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo1polarity, "lfo1polarity", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo1duty, "lfo1duty", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo2shape, "lfo2shape", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo2rate, "lfo2rate", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo2polarity, "lfo2polarity", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo2duty, "lfo2duty", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo3shape, "lfo3shape", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo3rate, "lfo3rate", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo3polarity, "lfo3polarity", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo3duty, "lfo3duty", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo4shape, "lfo4shape", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo4rate, "lfo4rate", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo4polarity, "lfo4polarity", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo4duty, "lfo4duty", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo5shape, "lfo5shape", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo5rate, "lfo5rate", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo5polarity, "lfo5polarity", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo5duty, "lfo5duty", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo6shape, "lfo6shape", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo6rate, "lfo6rate", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo6polarity, "lfo6polarity", A_FLOAT, 0);
  class_addmethod(c, (method)ec2_lfo6duty, "lfo6duty", A_FLOAT, 0);

  // Buffer management - using attribute setter instead of message handler
  // (Attribute @buffer is registered below with CLASS_ATTR_SYM + setter)

  // Attributes - Output configuration
  // Note: outputs and mc cannot be changed at runtime - they require object recreation
  CLASS_ATTR_LONG(c, "outputs", 0, t_ec2, outputs);
  CLASS_ATTR_FILTER_CLIP(c, "outputs", 1, 16);
  CLASS_ATTR_LABEL(c, "outputs", 0, "Number of output channels (set at creation only)");
  CLASS_ATTR_SAVE(c, "outputs", 0);
  CLASS_ATTR_STYLE(c, "outputs", 0, "text");  // Text only, discourage runtime editing

  CLASS_ATTR_LONG(c, "mc", 0, t_ec2, mc_mode);
  CLASS_ATTR_STYLE_LABEL(c, "mc", 0, "onoff", "Multichannel mode (set at creation only)");
  CLASS_ATTR_SAVE(c, "mc", 0);

  // Spatial allocation mode attribute (structural - set at creation)
  CLASS_ATTR_LONG(c, "allocmode", 0, t_ec2, alloc_mode);
  CLASS_ATTR_FILTER_CLIP(c, "allocmode", 0, 6);
  CLASS_ATTR_LABEL(c, "allocmode", 0, "Spatial allocation mode (0-6)");
  CLASS_ATTR_SAVE(c, "allocmode", 0);

  // Note: allocation mode parameters (fixedchan, rrstep, etc.) are now MESSAGES
  // for real-time control - see message handlers above

  // Buffer attribute
  CLASS_ATTR_SYM(c, "buffer", 0, t_ec2, buffer_name);
  CLASS_ATTR_ACCESSORS(c, "buffer", nullptr, ec2_buffer_setter);
  CLASS_ATTR_LABEL(c, "buffer", 0, "Buffer~ name");
  CLASS_ATTR_SAVE(c, "buffer", 0);

  CLASS_ATTR_LONG(c, "soundfile", 0, t_ec2, sound_file);
  CLASS_ATTR_FILTER_CLIP(c, "soundfile", 0, 15);
  CLASS_ATTR_LABEL(c, "soundfile", 0, "Sound file index");
  CLASS_ATTR_SAVE(c, "soundfile", 0);

  // Register "anything" handler LAST so specific handlers take precedence
  class_addmethod(c, (method)ec2_anything, "anything", A_GIMME, 0);

  class_dspinit(c);
  class_register(CLASS_BOX, c);
  ec2_class = c;
}

// ==================================================================
// OBJECT LIFECYCLE
// ==================================================================

void* ec2_new(t_symbol* s, long argc, t_atom* argv) {
  t_ec2* x = (t_ec2*)object_alloc(ec2_class);

  // Initialize DSP
  dsp_setup((t_pxobject*)x, 3);  // 3 signal inlets: scan, rate, playback

  // Default values
  x->outputs = 2;
  x->mc_mode = 0;

  // Create C++ objects BEFORE attr_args_process (so callbacks can use engine)
  x->engine = new ec2::GranularEngine(2048);
  x->signal_outlets = new std::vector<void*>();
  x->osc_bundle_buffer = new std::vector<unsigned char>();
  x->input_buffer = new std::vector<unsigned char>();
  x->osc_outlet = nullptr;
  x->suppress_osc_output = false;

  // Initialize synthesis parameters to defaults
  x->grain_rate = 20.0;
  x->async = 0.0;
  x->intermittency = 0.0;
  x->streams = 1.0;
  x->playback_rate = 1.0;
  x->grain_duration = 100.0;
  x->envelope_shape = 0.5;
  x->amplitude = 0.5;
  x->filter_freq = 1000.0;
  x->resonance = 0.0;
  x->stereo_pan = 0.0;
  x->scan_start = 0.5;
  x->scan_range = 1.0;
  x->scan_speed = 1.0;

  // Initialize deviation parameters to 0
  x->grain_rate_dev = 0.0;
  x->async_dev = 0.0;
  x->intermittency_dev = 0.0;
  x->streams_dev = 0.0;
  x->playback_dev = 0.0;
  x->duration_dev = 0.0;
  x->envelope_dev = 0.0;
  x->pan_dev = 0.0;
  x->amp_dev = 0.0;
  x->filterfreq_dev = 0.0;
  x->resonance_dev = 0.0;
  x->scanstart_dev = 0.0;
  x->scanrange_dev = 0.0;
  x->scanspeed_dev = 0.0;

  // Initialize LFO states (6 LFOs, each with global_depth=1.0 and empty destinations)
  for (int i = 0; i < 6; i++) {
    x->lfo_states[i].global_depth = 1.0;
    x->lfo_states[i].destinations.clear();
  }

  // Initialize LFO base parameters (defaults match EC2 engine defaults)
  x->lfo1_shape = x->lfo2_shape = x->lfo3_shape = x->lfo4_shape = x->lfo5_shape = x->lfo6_shape = 0;  // Sine
  x->lfo1_rate = x->lfo2_rate = x->lfo3_rate = x->lfo4_rate = x->lfo5_rate = x->lfo6_rate = 1.0;
  x->lfo1_polarity = x->lfo2_polarity = x->lfo3_polarity = x->lfo4_polarity = x->lfo5_polarity = x->lfo6_polarity = 0;  // Bipolar
  x->lfo1_duty = x->lfo2_duty = x->lfo3_duty = x->lfo4_duty = x->lfo5_duty = x->lfo6_duty = 0.5;

  // Initialize spatial allocation to defaults
  x->alloc_mode = 1;  // roundrobin
  x->fixed_channel = 1;  // 1-16 (user-facing channel numbers)
  x->rr_step = 1;
  x->random_spread = 0.0;
  x->spatial_corr = 0.0;
  x->pitch_min = 20.0;
  x->pitch_max = 20000.0;
  x->traj_shape = 0;
  x->traj_rate = 0.5;
  x->traj_depth = 1.0;

  x->buffer_name = gensym("");
  x->buffer_ref = nullptr;
  x->sound_file = 0;

  // Parse first argument as buffer name (if provided and not an attribute)
  if (argc > 0 && atom_gettype(argv) == A_SYM) {
    t_symbol* first_arg = atom_getsym(argv);
    // Check if it's not an attribute (doesn't start with @)
    if (first_arg->s_name[0] != '@') {
      x->buffer_name = first_arg;

      // Create buffer_ref to monitor buffer~ changes
      x->buffer_ref = buffer_ref_new((t_object*)x, first_arg);

      // Load the buffer
      auto audio_buf = ec2_buffer_helper::loadFromMaxBuffer(first_arg->s_name);
      if (audio_buf) {
        x->engine->setAudioBuffer(audio_buf, 0);
      }
      // Skip first arg for attr_args_process
      argc--;
      argv++;
    }
  }

  // Process remaining attributes AFTER engine is created
  attr_args_process(x, argc, argv);

  // Create outlets (right to left in Max)
  x->osc_outlet = outlet_new(x, nullptr);  // Rightmost: OSC messages

  if (x->mc_mode == 1) {
    // MC mode: ONE multichannelsignal outlet
    void* sig_outlet = outlet_new(x, "multichannelsignal");
    x->signal_outlets->push_back(sig_outlet);
    object_attr_setlong(sig_outlet, gensym("chans"), x->outputs);
  } else {
    // Separated mode: N signal outlets (right to left)
    for (int i = x->outputs - 1; i >= 0; --i) {
      void* sig_outlet = outlet_new(x, "signal");
      x->signal_outlets->insert(x->signal_outlets->begin(), sig_outlet);
    }
  }

  // Initialize engine
  x->engine->initialize(sys_getsr());
  ec2_update_engine_params(x);

  // Print banner on first instantiation only
  static bool banner_printed = false;
  if (!banner_printed) {
    // Extract year from build date for copyright
    std::string build_date(EC2_BUILD_DATE);
    std::string year = build_date.substr(build_date.length() - 4);  // Last 4 chars = year

    post("——————————————————————————————————————————————————————————————————");
    post("ec2~ version %s (compiled %s %s)", EC2_VERSION, EC2_BUILD_DATE, EC2_BUILD_TIME);
    post("based on EmissionControl2 by Curtis Roads, Jack Kilgore, Rodney DuPlessis");
    post("Max port, spatial audio & multichannel allocation by Alessandro Anatrini ©%s", year.c_str());
    post("——————————————————————————————————————————————————————————————————");
    banner_printed = true;
  }

  return x;
}

void ec2_free(t_ec2* x) {
  dsp_free((t_pxobject*)x);

  if (x->buffer_ref) object_free(x->buffer_ref);
  if (x->engine) delete x->engine;
  if (x->signal_outlets) delete x->signal_outlets;
  if (x->osc_bundle_buffer) delete x->osc_bundle_buffer;
  if (x->input_buffer) delete x->input_buffer;
}

void ec2_assist(t_ec2* x, void* b, long m, long a, char* s) {
  if (m == ASSIST_INLET) {
    switch (a) {
      case 0: snprintf(s, 256, "(signal) Scan position"); break;
      case 1: snprintf(s, 256, "(signal) Grain rate (Hz)"); break;
      case 2: snprintf(s, 256, "(signal) Playback rate"); break;
    }
  } else {
    if (a < x->outputs) {
      snprintf(s, 256, "(signal) Audio out %ld", a + 1);
    } else {
      snprintf(s, 256, "(OSC) Parameters");
    }
  }
}

void ec2_dblclick(t_ec2* x) {
  // Open buffer editor when double-clicking the object
  if (!x->buffer_name || x->buffer_name == gensym("")) {
    object_error((t_object*)x, "no buffer set");
    return;
  }

  t_buffer_ref* buf_ref = buffer_ref_new((t_object*)x, x->buffer_name);
  if (!buf_ref) {
    object_error((t_object*)x, "buffer '%s' not found", x->buffer_name->s_name);
    return;
  }

  t_buffer_obj* buffer = buffer_ref_getobject(buf_ref);
  if (buffer) {
    // Open the buffer editor
    mess0(buffer, gensym("dblclick"));
  }

  object_free(buf_ref);
}

t_max_err ec2_notify(t_ec2* x, t_symbol* s, t_symbol* msg, void* sender, void* data) {
  // Check if notification is from our buffer_ref
  if (msg == gensym("buffer_modified") || msg == gensym("globalsymbol_binding")) {
    // Reload buffer when it changes
    if (x->buffer_name && x->buffer_name != gensym("")) {
      auto audio_buf = ec2_buffer_helper::loadFromMaxBuffer(x->buffer_name->s_name);
      if (audio_buf) {
        x->engine->setAudioBuffer(audio_buf, 0);
        // Update engine parameters after loading buffer
        ec2_update_engine_params(x);
      }
    }
  }

  return MAX_ERR_NONE;
}

// ==================================================================
// DSP
// ==================================================================

void ec2_dsp64(t_ec2* x, t_object* dsp64, short* count, double samplerate, long maxvectorsize, long flags) {
  x->engine->setSampleRate(samplerate);

  // Store signal connection status
  // count[0] = scan inlet connected
  // count[1] = rate inlet connected
  // count[2] = playback inlet connected
  object_method(dsp64, gensym("dsp_add64"), x, ec2_perform64, 0, nullptr);
}

void ec2_perform64(t_ec2* x, t_object* dsp64, double** ins, long numins, double** outs, long numouts, long sampleframes, long flags, void* userparam) {
  // CRITICAL: Update engine parameters every audio callback (matches old ec2~)
  ec2_update_engine_params(x);

  // Process audio
  float** outBuffers = new float*[x->outputs];
  for (int i = 0; i < x->outputs; ++i) {
    outBuffers[i] = new float[sampleframes];
    memset(outBuffers[i], 0, sampleframes * sizeof(float));
  }

  // Signal inputs disabled - always use parameter values
  // TODO: Implement proper signal connection detection using count array from dsp64
  float* scan_in = nullptr;
  float* rate_in = nullptr;
  float* playback_in = nullptr;

  // Process audio through engine
  x->engine->processWithSignals(outBuffers, x->outputs, sampleframes,
                                scan_in, rate_in, playback_in);

  // Copy to Max outputs and convert to double
  for (int ch = 0; ch < x->outputs && ch < numouts; ++ch) {
    for (long i = 0; i < sampleframes; ++i) {
      outs[ch][i] = outBuffers[ch][i];
    }
  }

  // Cleanup
  for (int i = 0; i < x->outputs; ++i) {
    delete[] outBuffers[i];
  }
  delete[] outBuffers;
}

// ==================================================================
// MULTICHANNEL SUPPORT
// ==================================================================

long ec2_multichanneloutputs(t_ec2* x, long index) {
  if (index == 0 && x->mc_mode == 1) {
    return x->outputs;
  }
  return 0;
}

// ==================================================================
// MESSAGE HANDLERS - BASIC SYNTHESIS
// ==================================================================

void ec2_grainrate(t_ec2* x, double v) {
  x->grain_rate = std::max(0.1, std::min(500.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_async(t_ec2* x, double v) {
  x->async = std::max(0.0, std::min(1.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_intermittency(t_ec2* x, double v) {
  x->intermittency = std::max(0.0, std::min(1.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_streams(t_ec2* x, double v) {
  x->streams = std::max(1.0, std::min(20.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_playback(t_ec2* x, double v) {
  x->playback_rate = std::max(-32.0, std::min(32.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_duration(t_ec2* x, double v) {
  x->grain_duration = std::max(1.0, std::min(1000.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_envelope(t_ec2* x, double v) {
  x->envelope_shape = std::max(0.0, std::min(1.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_amplitude(t_ec2* x, double v) {
  x->amplitude = std::max(0.0, std::min(1.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

// ==================================================================
// FILTERING
// ==================================================================

void ec2_filterfreq(t_ec2* x, double v) {
  x->filter_freq = std::max(20.0, std::min(22000.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_resonance(t_ec2* x, double v) {
  x->resonance = std::max(0.0, std::min(1.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

// ==================================================================
// SPATIAL/SCANNING
// ==================================================================

void ec2_pan(t_ec2* x, double v) {
  x->stereo_pan = std::max(-1.0, std::min(1.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_scanstart(t_ec2* x, double v) {
  x->scan_start = std::max(0.0, std::min(1.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_scanrange(t_ec2* x, double v) {
  x->scan_range = std::max(0.0, std::min(1.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_scanspeed(t_ec2* x, double v) {
  x->scan_speed = std::max(-32.0, std::min(32.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

// ==================================================================
// DEVIATION PARAMETERS (14 total)
// ==================================================================

void ec2_grainrate_dev(t_ec2* x, double v) {
  x->grain_rate_dev = std::max(0.0, std::min(250.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_async_dev(t_ec2* x, double v) {
  x->async_dev = std::max(0.0, std::min(0.5, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_intermittency_dev(t_ec2* x, double v) {
  x->intermittency_dev = std::max(0.0, std::min(0.5, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_streams_dev(t_ec2* x, double v) {
  x->streams_dev = std::max(0.0, std::min(10.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_playback_dev(t_ec2* x, double v) {
  x->playback_dev = std::max(0.0, std::min(16.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_duration_dev(t_ec2* x, double v) {
  x->duration_dev = std::max(0.0, std::min(500.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_envelope_dev(t_ec2* x, double v) {
  x->envelope_dev = std::max(0.0, std::min(0.5, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_pan_dev(t_ec2* x, double v) {
  x->pan_dev = std::max(0.0, std::min(1.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_amp_dev(t_ec2* x, double v) {
  x->amp_dev = std::max(0.0, std::min(0.5, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_filterfreq_dev(t_ec2* x, double v) {
  x->filterfreq_dev = std::max(0.0, std::min(11000.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_resonance_dev(t_ec2* x, double v) {
  x->resonance_dev = std::max(0.0, std::min(0.5, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_scanstart_dev(t_ec2* x, double v) {
  x->scanstart_dev = std::max(0.0, std::min(0.5, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_scanrange_dev(t_ec2* x, double v) {
  x->scanrange_dev = std::max(0.0, std::min(0.5, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_scanspeed_dev(t_ec2* x, double v) {
  x->scanspeed_dev = std::max(0.0, std::min(16.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

// ==================================================================
// LFO PARAMETERS (24 total: 6 LFOs × 4 params)
// ==================================================================

// Helper function to apply LFO-to-LFO modulation and update engine
// This allows one LFO to modulate another LFO's parameters
void ec2_update_lfo_with_modulation(t_ec2* x, int lfo_index) {
  if (lfo_index < 0 || lfo_index >= 6) return;

  auto lfo = x->engine->getLFO(lfo_index);
  if (!lfo) return;

  // Get base values based on LFO index
  int base_shape, base_polarity;
  double base_rate, base_duty;

  switch (lfo_index) {
    case 0: base_shape = x->lfo1_shape; base_rate = x->lfo1_rate; base_polarity = x->lfo1_polarity; base_duty = x->lfo1_duty; break;
    case 1: base_shape = x->lfo2_shape; base_rate = x->lfo2_rate; base_polarity = x->lfo2_polarity; base_duty = x->lfo2_duty; break;
    case 2: base_shape = x->lfo3_shape; base_rate = x->lfo3_rate; base_polarity = x->lfo3_polarity; base_duty = x->lfo3_duty; break;
    case 3: base_shape = x->lfo4_shape; base_rate = x->lfo4_rate; base_polarity = x->lfo4_polarity; base_duty = x->lfo4_duty; break;
    case 4: base_shape = x->lfo5_shape; base_rate = x->lfo5_rate; base_polarity = x->lfo5_polarity; base_duty = x->lfo5_duty; break;
    case 5: base_shape = x->lfo6_shape; base_rate = x->lfo6_rate; base_polarity = x->lfo6_polarity; base_duty = x->lfo6_duty; break;
    default: return;
  }

  // Get LFO modulation for each parameter (from OTHER LFOs only - no self-modulation)
  std::string lfo_num_str = std::to_string(lfo_index + 1);
  double shape_mod = ec2_get_lfo_modulation(x, "lfo" + lfo_num_str + "shape");
  double rate_mod = ec2_get_lfo_modulation(x, "lfo" + lfo_num_str + "rate");
  double polarity_mod = ec2_get_lfo_modulation(x, "lfo" + lfo_num_str + "polarity");
  double duty_mod = ec2_get_lfo_modulation(x, "lfo" + lfo_num_str + "duty");

  // Apply modulation
  // For discrete params (shape, polarity): add offset based on LFO value
  // For continuous params (rate, duty): multiply by (1.0 + lfo_mod)
  int modulated_shape = base_shape + static_cast<int>(shape_mod * 4);
  modulated_shape = std::max(0, std::min(4, modulated_shape));

  double modulated_rate = base_rate * (1.0 + rate_mod);
  modulated_rate = std::max(0.001, std::min(100.0, modulated_rate));

  int modulated_polarity = base_polarity + static_cast<int>(polarity_mod * 2);
  modulated_polarity = std::max(0, std::min(2, modulated_polarity));

  double modulated_duty = base_duty * (1.0 + duty_mod);
  modulated_duty = std::max(0.0, std::min(1.0, modulated_duty));

  // Update engine
  lfo->setShape(static_cast<ec2::LFOShape>(modulated_shape));
  lfo->setFrequency(modulated_rate);
  lfo->setPolarity(static_cast<ec2::LFOPolarity>(modulated_polarity));
  lfo->setDuty(modulated_duty);
}

// LFO 1
void ec2_lfo1shape(t_ec2* x, double v) {
  x->lfo1_shape = std::max(0, std::min(4, (int)v));
  ec2_update_lfo_with_modulation(x, 0);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_lfo1rate(t_ec2* x, double v) {
  x->lfo1_rate = std::max(0.001, std::min(100.0, v));
  ec2_update_lfo_with_modulation(x, 0);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_lfo1polarity(t_ec2* x, double v) {
  x->lfo1_polarity = std::max(0, std::min(2, (int)v));
  ec2_update_lfo_with_modulation(x, 0);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_lfo1duty(t_ec2* x, double v) {
  x->lfo1_duty = std::max(0.0, std::min(1.0, v));
  ec2_update_lfo_with_modulation(x, 0);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

// LFO 2
void ec2_lfo2shape(t_ec2* x, double v) {
  x->lfo2_shape = std::max(0, std::min(4, (int)v));
  ec2_update_lfo_with_modulation(x, 1);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_lfo2rate(t_ec2* x, double v) {
  x->lfo2_rate = std::max(0.001, std::min(100.0, v));
  ec2_update_lfo_with_modulation(x, 1);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_lfo2polarity(t_ec2* x, double v) {
  x->lfo2_polarity = std::max(0, std::min(2, (int)v));
  ec2_update_lfo_with_modulation(x, 1);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_lfo2duty(t_ec2* x, double v) {
  x->lfo2_duty = std::max(0.0, std::min(1.0, v));
  ec2_update_lfo_with_modulation(x, 1);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

// LFO 3
void ec2_lfo3shape(t_ec2* x, double v) {
  x->lfo3_shape = std::max(0, std::min(4, (int)v));
  ec2_update_lfo_with_modulation(x, 2);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_lfo3rate(t_ec2* x, double v) {
  x->lfo3_rate = std::max(0.001, std::min(100.0, v));
  ec2_update_lfo_with_modulation(x, 2);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_lfo3polarity(t_ec2* x, double v) {
  x->lfo3_polarity = std::max(0, std::min(2, (int)v));
  ec2_update_lfo_with_modulation(x, 2);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_lfo3duty(t_ec2* x, double v) {
  x->lfo3_duty = std::max(0.0, std::min(1.0, v));
  ec2_update_lfo_with_modulation(x, 2);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

// LFO 4
void ec2_lfo4shape(t_ec2* x, double v) {
  x->lfo4_shape = std::max(0, std::min(4, (int)v));
  ec2_update_lfo_with_modulation(x, 3);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_lfo4rate(t_ec2* x, double v) {
  x->lfo4_rate = std::max(0.001, std::min(100.0, v));
  ec2_update_lfo_with_modulation(x, 3);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_lfo4polarity(t_ec2* x, double v) {
  x->lfo4_polarity = std::max(0, std::min(2, (int)v));
  ec2_update_lfo_with_modulation(x, 3);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_lfo4duty(t_ec2* x, double v) {
  x->lfo4_duty = std::max(0.0, std::min(1.0, v));
  ec2_update_lfo_with_modulation(x, 3);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

// LFO 5
void ec2_lfo5shape(t_ec2* x, double v) {
  x->lfo5_shape = std::max(0, std::min(4, (int)v));
  ec2_update_lfo_with_modulation(x, 4);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_lfo5rate(t_ec2* x, double v) {
  x->lfo5_rate = std::max(0.001, std::min(100.0, v));
  ec2_update_lfo_with_modulation(x, 4);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_lfo5polarity(t_ec2* x, double v) {
  x->lfo5_polarity = std::max(0, std::min(2, (int)v));
  ec2_update_lfo_with_modulation(x, 4);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_lfo5duty(t_ec2* x, double v) {
  x->lfo5_duty = std::max(0.0, std::min(1.0, v));
  ec2_update_lfo_with_modulation(x, 4);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

// LFO 6
void ec2_lfo6shape(t_ec2* x, double v) {
  x->lfo6_shape = std::max(0, std::min(4, (int)v));
  ec2_update_lfo_with_modulation(x, 5);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_lfo6rate(t_ec2* x, double v) {
  x->lfo6_rate = std::max(0.001, std::min(100.0, v));
  ec2_update_lfo_with_modulation(x, 5);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_lfo6polarity(t_ec2* x, double v) {
  x->lfo6_polarity = std::max(0, std::min(2, (int)v));
  ec2_update_lfo_with_modulation(x, 5);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_lfo6duty(t_ec2* x, double v) {
  x->lfo6_duty = std::max(0.0, std::min(1.0, v));
  ec2_update_lfo_with_modulation(x, 5);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

// ==================================================================
// LFO MODULATION SYSTEM - Helper Functions
// ==================================================================

// Find if a parameter is already assigned to an LFO destination
// Returns the LFO destination index within that LFO, or -1 if not found
int ec2_find_lfo_destination(t_ec2* x, int lfo_num, const std::string& param_name) {
  if (lfo_num < 1 || lfo_num > 6) return -1;

  LFOState& lfo = x->lfo_states[lfo_num - 1];
  for (size_t i = 0; i < lfo.destinations.size(); i++) {
    if (lfo.destinations[i].param_name == param_name) {
      return static_cast<int>(i);
    }
  }
  return -1;
}

// Find which LFO (if any) is currently modulating a parameter
// Returns LFO number (1-6) or 0 if not modulated
int ec2_find_param_lfo_source(t_ec2* x, const std::string& param_name) {
  for (int lfo_num = 1; lfo_num <= 6; lfo_num++) {
    if (ec2_find_lfo_destination(x, lfo_num, param_name) >= 0) {
      return lfo_num;
    }
  }
  return 0;
}

// Get the effective modulation value for a parameter from its assigned LFO
// For deviation/spatial/LFO parameters (Max-level modulation)
// Returns modulation value in range based on LFO polarity
double ec2_get_lfo_modulation(t_ec2* x, const std::string& param_name) {
  int lfo_num = ec2_find_param_lfo_source(x, param_name);
  if (lfo_num == 0) return 0.0;

  int dest_idx = ec2_find_lfo_destination(x, lfo_num, param_name);
  if (dest_idx < 0) return 0.0;

  LFOState& lfo = x->lfo_states[lfo_num - 1];
  double destination_depth = lfo.destinations[dest_idx].depth;
  double global_depth = lfo.global_depth;

  // Get LFO current output from engine
  // Note: We approximate by reading LFO parameters since engine doesn't expose current value
  // For accurate modulation, the engine applies LFO internally
  // This function is used only for Max-level parameters (deviation, spatial, LFO-to-LFO)

  // Return effective depth (engine will multiply by actual LFO value at audio rate)
  return global_depth * destination_depth;
}

// Helper to get LFO routing info for engine params (lfoSource and effective depth)
// Sets lfoSource (0-6) and depth (0.0-1.0) for a parameter
void ec2_get_lfo_routing_for_engine(t_ec2* x, const std::string& param_name, int& lfo_source, double& depth) {
  int lfo_num = ec2_find_param_lfo_source(x, param_name);
  if (lfo_num == 0) {
    lfo_source = 0;
    depth = 0.0;
    return;
  }

  int dest_idx = ec2_find_lfo_destination(x, lfo_num, param_name);
  if (dest_idx < 0) {
    lfo_source = 0;
    depth = 0.0;
    return;
  }

  LFOState& lfo = x->lfo_states[lfo_num - 1];
  lfo_source = lfo_num;
  // Effective depth = global_depth × destination_depth
  depth = lfo.global_depth * lfo.destinations[dest_idx].depth;
}

// ==================================================================
// LFO MODULATION SYSTEM - Message Handlers
// ==================================================================

// Main message handler for LFO routing
// Handles: /lfo<N>_to_<param> map [depth]
//          /lfo<N>_to_<param> unmap
//          /lfo<N>_depth <value>
void ec2_lfo_map(t_ec2* x, t_symbol* s, long argc, t_atom* argv) {
  std::string msg = s->s_name;

  // Check for /lfo<N>_depth message
  if (msg.find("/lfo") == 0 && msg.find("_depth") != std::string::npos) {
    // Extract LFO number from "/lfo<N>_depth"
    size_t lfo_start = 4;  // After "/lfo"
    size_t lfo_end = msg.find("_depth");
    if (lfo_end == std::string::npos || lfo_end <= lfo_start) {
      object_error((t_object*)x, "invalid LFO depth message format: %s", msg.c_str());
      return;
    }

    std::string lfo_num_str = msg.substr(lfo_start, lfo_end - lfo_start);
    int lfo_num = std::atoi(lfo_num_str.c_str());

    if (lfo_num < 1 || lfo_num > 6) {
      object_error((t_object*)x, "invalid LFO number: %d (must be 1-6)", lfo_num);
      return;
    }

    if (argc < 1) {
      object_error((t_object*)x, "/lfo%d_depth requires a value", lfo_num);
      return;
    }

    double depth = atom_getfloat(argv);
    depth = std::max(0.0, std::min(1.0, depth));

    x->lfo_states[lfo_num - 1].global_depth = depth;

    // Check if LFO has any destinations
    if (x->lfo_states[lfo_num - 1].destinations.empty()) {
      object_warn((t_object*)x, "LFO%d is not mapped to any parameters", lfo_num);
    }

    ec2_update_engine_params(x);
    if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
    return;
  }

  // Check for /lfo<N>_to_<param> messages
  if (msg.find("/lfo") == 0 && msg.find("_to_") != std::string::npos) {
    // Extract LFO number and parameter name
    size_t lfo_start = 4;  // After "/lfo"
    size_t to_pos = msg.find("_to_");
    if (to_pos == std::string::npos) return;

    std::string lfo_num_str = msg.substr(lfo_start, to_pos - lfo_start);
    int lfo_num = std::atoi(lfo_num_str.c_str());

    if (lfo_num < 1 || lfo_num > 6) {
      object_error((t_object*)x, "invalid LFO number: %d (must be 1-6)", lfo_num);
      return;
    }

    std::string param_name = msg.substr(to_pos + 4);  // After "_to_"

    // Check if we have a command (map/unmap)
    if (argc < 1) {
      object_error((t_object*)x, "%s requires 'map' or 'unmap' command", msg.c_str());
      return;
    }

    t_symbol* cmd = atom_getsym(argv);
    std::string command = cmd->s_name;

    if (command == "map") {
      // Map LFO to parameter

      // Check for self-modulation (LFO cannot modulate itself)
      if (param_name.find("lfo" + std::to_string(lfo_num)) == 0) {
        object_error((t_object*)x, "LFO%d cannot modulate its own parameters (attempted: %s)",
                     lfo_num, param_name.c_str());
        return;
      }

      // Check if parameter is already mapped to a different LFO
      int existing_lfo = ec2_find_param_lfo_source(x, param_name);
      if (existing_lfo != 0 && existing_lfo != lfo_num) {
        object_error((t_object*)x, "parameter '%s' is already modulated by LFO%d. Unmap first with: /lfo%d_to_%s unmap",
                     param_name.c_str(), existing_lfo, existing_lfo, param_name.c_str());
        return;
      }

      // Check if LFO already has this destination
      int dest_idx = ec2_find_lfo_destination(x, lfo_num, param_name);
      if (dest_idx >= 0) {
        // Already mapped, just update depth if provided
        if (argc >= 2) {
          double depth = atom_getfloat(argv + 1);
          depth = std::max(0.0, std::min(1.0, depth));
          x->lfo_states[lfo_num - 1].destinations[dest_idx].depth = depth;
        }
        post("ec2~: LFO%d already mapped to %s, depth updated", lfo_num, param_name.c_str());
        ec2_update_engine_params(x);
        if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
        return;
      }

      // Check if LFO has reached max destinations
      LFOState& lfo = x->lfo_states[lfo_num - 1];
      if (lfo.destinations.size() >= MAX_LFO_DESTINATIONS) {
        object_error((t_object*)x, "LFO%d has reached maximum destinations (%d/%d). Unmap a parameter first.",
                     lfo_num, (int)lfo.destinations.size(), MAX_LFO_DESTINATIONS);
        return;
      }

      // Get depth (default 1.0)
      double depth = 1.0;
      if (argc >= 2) {
        depth = atom_getfloat(argv + 1);
        depth = std::max(0.0, std::min(1.0, depth));
      }

      // Check for spatial allocation parameter coherence
      if (param_name == "fixedchan" && x->alloc_mode != 0) {
        object_warn((t_object*)x, "LFO%d mapped to 'fixedchan', but allocmode is %ld (not Fixed Channel mode 0). This parameter has no effect.",
                   lfo_num, x->alloc_mode);
      } else if (param_name == "rrstep" && x->alloc_mode != 1) {
        object_warn((t_object*)x, "LFO%d mapped to 'rrstep', but allocmode is %ld (not Round-Robin mode 1). This parameter has no effect.",
                   lfo_num, x->alloc_mode);
      } else if ((param_name == "randspread" || param_name == "spatialcorr") &&
                 (x->alloc_mode != 2 && x->alloc_mode != 3)) {
        object_warn((t_object*)x, "LFO%d mapped to '%s', but allocmode is %ld (not Random mode 2 or Weighted Random mode 3). This parameter has no effect.",
                   lfo_num, param_name.c_str(), x->alloc_mode);
      } else if ((param_name == "pitchmin" || param_name == "pitchmax") && x->alloc_mode != 5) {
        object_warn((t_object*)x, "LFO%d mapped to '%s', but allocmode is %ld (not Pitch-to-Space mode 5). This parameter has no effect.",
                   lfo_num, param_name.c_str(), x->alloc_mode);
      } else if ((param_name == "trajshape" || param_name == "trajrate" || param_name == "trajdepth") &&
                 x->alloc_mode != 6) {
        object_warn((t_object*)x, "LFO%d mapped to '%s', but allocmode is %ld (not Trajectory mode 6). This parameter has no effect.",
                   lfo_num, param_name.c_str(), x->alloc_mode);
      }

      // Add new destination
      lfo.destinations.push_back(LFODestination(param_name, depth));
      post("ec2~: LFO%d mapped to %s (depth %.2f)", lfo_num, param_name.c_str(), depth);

      ec2_update_engine_params(x);
      if (!x->suppress_osc_output) ec2_send_osc_bundle(x);

    } else if (command == "unmap") {
      // Unmap LFO from parameter

      int dest_idx = ec2_find_lfo_destination(x, lfo_num, param_name);
      if (dest_idx < 0) {
        object_warn((t_object*)x, "LFO%d is not mapped to %s", lfo_num, param_name.c_str());
        return;
      }

      // Remove destination
      LFOState& lfo = x->lfo_states[lfo_num - 1];
      lfo.destinations.erase(lfo.destinations.begin() + dest_idx);
      post("ec2~: LFO%d unmapped from %s", lfo_num, param_name.c_str());

      ec2_update_engine_params(x);
      if (!x->suppress_osc_output) ec2_send_osc_bundle(x);

    } else {
      object_error((t_object*)x, "unknown command '%s' (expected 'map' or 'unmap')", command.c_str());
    }
  }
}

// ==================================================================
// SPATIAL ALLOCATION PARAMETERS (9 total - real-time messages)
// ==================================================================

void ec2_fixedchan(t_ec2* x, long v) {
  x->fixed_channel = std::max(1L, std::min(16L, v));  // User-facing: 1-16
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_rrstep(t_ec2* x, long v) {
  x->rr_step = std::max(1L, std::min(16L, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_randspread(t_ec2* x, double v) {
  x->random_spread = std::max(0.0, std::min(1.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_spatialcorr(t_ec2* x, double v) {
  x->spatial_corr = std::max(0.0, std::min(1.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_pitchmin(t_ec2* x, double v) {
  x->pitch_min = std::max(20.0, std::min(20000.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_pitchmax(t_ec2* x, double v) {
  x->pitch_max = std::max(20.0, std::min(20000.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_trajshape(t_ec2* x, long v) {
  x->traj_shape = std::max(0L, std::min(3L, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_trajrate(t_ec2* x, double v) {
  x->traj_rate = std::max(0.001, std::min(100.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

void ec2_trajdepth(t_ec2* x, double v) {
  x->traj_depth = std::max(0.0, std::min(1.0, v));
  ec2_update_engine_params(x);
  if (!x->suppress_osc_output) ec2_send_osc_bundle(x);
}

// ==================================================================
// BUFFER MANAGEMENT
// ==================================================================

t_max_err ec2_buffer_setter(t_ec2* x, void* attr, long argc, t_atom* argv) {
  if (!x || !x->engine) return MAX_ERR_NONE;

  if (argc && argv) {
    t_symbol* s = atom_getsym(argv);
    if (s && s != gensym("")) {
      x->buffer_name = s;

      // Free old buffer_ref if exists
      if (x->buffer_ref) {
        object_free(x->buffer_ref);
      }

      // Create buffer_ref to monitor buffer~ changes
      x->buffer_ref = buffer_ref_new((t_object*)x, s);

      auto audio_buf = ec2_buffer_helper::loadFromMaxBuffer(s->s_name);
      if (audio_buf) {
        x->engine->setAudioBuffer(audio_buf, 0);
      }
    }
  }
  return MAX_ERR_NONE;
}

void ec2_buffer(t_ec2* x, t_symbol* s) {
  if (!x || !x->engine) return;

  if (!s || s == gensym("")) {
    if (x->buffer_ref) {
      object_free(x->buffer_ref);
      x->buffer_ref = nullptr;
    }
    x->engine->setAudioBuffer(nullptr, 0);
    return;
  }

  x->buffer_name = s;

  // Free old buffer_ref if exists
  if (x->buffer_ref) {
    object_free(x->buffer_ref);
  }

  // Create buffer_ref to monitor buffer~ changes
  x->buffer_ref = buffer_ref_new((t_object*)x, s);

  auto audio_buf = ec2_buffer_helper::loadFromMaxBuffer(s->s_name);
  if (audio_buf) {
    post("ec2_buffer: loaded buffer '%s', size=%d, frames=%d, channels=%d",
         s->s_name, audio_buf->size, audio_buf->frames, audio_buf->channels);
    x->engine->setAudioBuffer(audio_buf, 0);
  } else {
    post("ec2_buffer: buffer '%s' not found yet (will load when available)", s->s_name);
  }
}

// ==================================================================
// FULLPACKET HANDLER (OSC from udpreceive)
// ==================================================================

void ec2_fullpacket(t_ec2* x, t_symbol* s, long argc, t_atom* argv) {
  if (argc < 2) return;

  long bundle_size = atom_getlong(&argv[0]);
  long bundle_ptr_val = atom_getlong(&argv[1]);

  if (bundle_ptr_val == 0 || bundle_size <= 0 || bundle_size >= 1048576) {
    return;
  }

  char* data = (char*)bundle_ptr_val;
  if (!data) return;

  // Check for #bundle header
  if (bundle_size < 8 || memcmp(data, "#bundle", 8) != 0) {
    return;
  }

  // CRITICAL: Copy immediately (udpreceive will free the buffer)
  x->input_buffer->resize(bundle_size);
  std::memcpy(x->input_buffer->data(), data, bundle_size);

  // Parse and update
  x->suppress_osc_output = true;
  ec2_parse_osc_bundle(x, x->input_buffer->data(), bundle_size);
  x->suppress_osc_output = false;

  ec2_update_engine_params(x);
  ec2_send_osc_bundle(x);
}

// ==================================================================
// ANYTHING HANDLER (OSC-style messages)
// ==================================================================

void ec2_anything(t_ec2* x, t_symbol* s, long argc, t_atom* argv) {
  // Handle OSC-style messages like "/grainrate 50"
  if (s && s->s_name[0] == '/') {
    std::string param_name = s->s_name + 1;  // Skip '/'
    if (argc > 0) {
      double value = atom_getfloat(&argv[0]);
      ec2_handle_osc_parameter(x, param_name, value);
    }
  }
}

// ==================================================================
// HELPER FUNCTIONS
// ==================================================================

void ec2_update_engine_params(t_ec2* x) {
  ec2::SynthParameters params;

  // Basic synthesis
  params.grainRate = x->grain_rate;
  params.async = x->async;
  params.intermittency = x->intermittency;
  params.streams = (int)x->streams;
  params.playbackRate = x->playback_rate;
  params.grainDuration = x->grain_duration;
  params.envelope = x->envelope_shape;

  // Amplitude is linear (0-1)
  params.amplitude = x->amplitude;

  // Filtering
  params.filterFreq = x->filter_freq;
  params.resonance = x->resonance;

  // Spatial
  params.pan = x->stereo_pan;
  params.scanBegin = x->scan_start;
  params.scanRange = x->scan_range;
  params.scanSpeed = x->scan_speed;

  // Deviations (with LFO modulation applied)
  // LFO modulation multiplies deviation values: modulated_dev = base_dev * (1.0 + lfo_mod)
  double grainrate_dev_mod = ec2_get_lfo_modulation(x, "grainrate_dev");
  double async_dev_mod = ec2_get_lfo_modulation(x, "async_dev");
  double intermittency_dev_mod = ec2_get_lfo_modulation(x, "intermittency_dev");
  double streams_dev_mod = ec2_get_lfo_modulation(x, "streams_dev");
  double playback_dev_mod = ec2_get_lfo_modulation(x, "playback_dev");
  double duration_dev_mod = ec2_get_lfo_modulation(x, "duration_dev");
  double envelope_dev_mod = ec2_get_lfo_modulation(x, "envelope_dev");
  double pan_dev_mod = ec2_get_lfo_modulation(x, "pan_dev");
  double amp_dev_mod = ec2_get_lfo_modulation(x, "amp_dev");
  double filterfreq_dev_mod = ec2_get_lfo_modulation(x, "filterfreq_dev");
  double resonance_dev_mod = ec2_get_lfo_modulation(x, "resonance_dev");
  double scanstart_dev_mod = ec2_get_lfo_modulation(x, "scanstart_dev");
  double scanrange_dev_mod = ec2_get_lfo_modulation(x, "scanrange_dev");
  double scanspeed_dev_mod = ec2_get_lfo_modulation(x, "scanspeed_dev");

  params.grainRateDeviation = x->grain_rate_dev * (1.0 + grainrate_dev_mod);
  params.asyncDeviation = x->async_dev * (1.0 + async_dev_mod);
  params.intermittencyDeviation = x->intermittency_dev * (1.0 + intermittency_dev_mod);
  params.streamsDeviation = x->streams_dev * (1.0 + streams_dev_mod);
  params.playbackDeviation = x->playback_dev * (1.0 + playback_dev_mod);
  params.durationDeviation = x->duration_dev * (1.0 + duration_dev_mod);
  params.envelopeDeviation = x->envelope_dev * (1.0 + envelope_dev_mod);
  params.panDeviation = x->pan_dev * (1.0 + pan_dev_mod);
  params.amplitudeDeviation = x->amp_dev * (1.0 + amp_dev_mod);
  params.filterFreqDeviation = x->filterfreq_dev * (1.0 + filterfreq_dev_mod);
  params.resonanceDeviation = x->resonance_dev * (1.0 + resonance_dev_mod);
  params.scanBeginDeviation = x->scanstart_dev * (1.0 + scanstart_dev_mod);
  params.scanRangeDeviation = x->scanrange_dev * (1.0 + scanrange_dev_mod);
  params.scanSpeedDeviation = x->scanspeed_dev * (1.0 + scanspeed_dev_mod);

  // Spatial allocation (with LFO modulation applied)
  params.spatial.mode = static_cast<ec2::AllocationMode>(x->alloc_mode);
  params.spatial.numChannels = x->outputs;  // CRITICAL: Set number of output channels!

  // Apply LFO modulation to spatial parameters
  // For int params: modulated_value = base_value + (int)(lfo_mod * range)
  // For float params: modulated_value = base_value * (1.0 + lfo_mod)
  double fixedchan_mod = ec2_get_lfo_modulation(x, "fixedchan");
  double rrstep_mod = ec2_get_lfo_modulation(x, "rrstep");
  double randspread_mod = ec2_get_lfo_modulation(x, "randspread");
  double spatialcorr_mod = ec2_get_lfo_modulation(x, "spatialcorr");
  double pitchmin_mod = ec2_get_lfo_modulation(x, "pitchmin");
  double pitchmax_mod = ec2_get_lfo_modulation(x, "pitchmax");
  double trajshape_mod = ec2_get_lfo_modulation(x, "trajshape");
  double trajrate_mod = ec2_get_lfo_modulation(x, "trajrate");
  double trajdepth_mod = ec2_get_lfo_modulation(x, "trajdepth");

  // Convert from 1-based (user-facing) to 0-based (engine internal)
  params.spatial.fixedChannel = (x->fixed_channel - 1) + static_cast<int>(fixedchan_mod * x->outputs);
  params.spatial.roundRobinStep = x->rr_step + static_cast<int>(rrstep_mod * 16);
  params.spatial.spread = x->random_spread * (1.0 + randspread_mod);
  params.spatial.spatialCorr = x->spatial_corr * (1.0 + spatialcorr_mod);
  params.spatial.pitchMin = x->pitch_min * (1.0 + pitchmin_mod);
  params.spatial.pitchMax = x->pitch_max * (1.0 + pitchmax_mod);
  params.spatial.trajShape = static_cast<ec2::TrajectoryShape>(x->traj_shape + static_cast<int>(trajshape_mod * 4));
  params.spatial.trajRate = x->traj_rate * (1.0 + trajrate_mod);
  params.spatial.trajDepth = x->traj_depth * (1.0 + trajdepth_mod);

  // Modulation routing (14 parameters - using new LFO routing system)
  // Use temporary doubles for conversion from helper function, then assign to float members
  double temp_depth;

  ec2_get_lfo_routing_for_engine(x, "grainrate", params.modGrainRate.lfoSource, temp_depth);
  params.modGrainRate.depth = static_cast<float>(temp_depth);

  ec2_get_lfo_routing_for_engine(x, "async", params.modAsync.lfoSource, temp_depth);
  params.modAsync.depth = static_cast<float>(temp_depth);

  ec2_get_lfo_routing_for_engine(x, "intermittency", params.modIntermittency.lfoSource, temp_depth);
  params.modIntermittency.depth = static_cast<float>(temp_depth);

  ec2_get_lfo_routing_for_engine(x, "streams", params.modStreams.lfoSource, temp_depth);
  params.modStreams.depth = static_cast<float>(temp_depth);

  ec2_get_lfo_routing_for_engine(x, "playback", params.modPlaybackRate.lfoSource, temp_depth);
  params.modPlaybackRate.depth = static_cast<float>(temp_depth);

  ec2_get_lfo_routing_for_engine(x, "duration", params.modGrainDuration.lfoSource, temp_depth);
  params.modGrainDuration.depth = static_cast<float>(temp_depth);

  ec2_get_lfo_routing_for_engine(x, "envelope", params.modEnvelope.lfoSource, temp_depth);
  params.modEnvelope.depth = static_cast<float>(temp_depth);

  ec2_get_lfo_routing_for_engine(x, "filterfreq", params.modFilterFreq.lfoSource, temp_depth);
  params.modFilterFreq.depth = static_cast<float>(temp_depth);

  ec2_get_lfo_routing_for_engine(x, "resonance", params.modResonance.lfoSource, temp_depth);
  params.modResonance.depth = static_cast<float>(temp_depth);

  ec2_get_lfo_routing_for_engine(x, "pan", params.modPan.lfoSource, temp_depth);
  params.modPan.depth = static_cast<float>(temp_depth);

  ec2_get_lfo_routing_for_engine(x, "amplitude", params.modAmplitude.lfoSource, temp_depth);
  params.modAmplitude.depth = static_cast<float>(temp_depth);

  ec2_get_lfo_routing_for_engine(x, "scanstart", params.modScanBegin.lfoSource, temp_depth);
  params.modScanBegin.depth = static_cast<float>(temp_depth);

  ec2_get_lfo_routing_for_engine(x, "scanrange", params.modScanRange.lfoSource, temp_depth);
  params.modScanRange.depth = static_cast<float>(temp_depth);

  ec2_get_lfo_routing_for_engine(x, "scanspeed", params.modScanSpeed.lfoSource, temp_depth);
  params.modScanSpeed.depth = static_cast<float>(temp_depth);

  x->engine->updateParameters(params);
}

void ec2_send_osc_bundle(t_ec2* x) {
  // Check suppress flag (matches old ec2~old.mxo at offset 0x4ae1)
  if (x->suppress_osc_output) return;

  // Build OSC bundle with all current parameters
  x->osc_bundle_buffer->clear();

  // OSC bundle header: "#bundle\0" (8 bytes)
  const char* bundle_header = "#bundle";
  for (int i = 0; i < 8; i++) {
    x->osc_bundle_buffer->push_back(i < 7 ? bundle_header[i] : 0);
  }

  // Timetag (8 bytes) - immediate (0x0000000000000001)
  for (int i = 0; i < 7; i++) x->osc_bundle_buffer->push_back(0);
  x->osc_bundle_buffer->push_back(1);

  // Helper lambda to add OSC message to bundle (EXACT copy from decompiled ec2~old.mxo)
  // Lambda signature: takes float, converts to double, stores as double with ',d' type tag
  auto add_message = [&](std::vector<unsigned char>& vec, const std::string& addr, float value) {
    size_t start_pos = vec.size();

    // Add size placeholder (4 zero bytes) - will be back-filled later
    vec.push_back(0);
    vec.push_back(0);
    vec.push_back(0);
    vec.push_back(0);

    // Add "/" + address string
    std::string full_addr = std::string("/") + addr;
    for (char c : full_addr) {
      vec.push_back(static_cast<unsigned char>(c));
    }
    vec.push_back(0); // null terminator

    // Pad to 4-byte boundary
    while (vec.size() % 4 != 0) {
      vec.push_back(0);
    }

    // Type tag string ",d\0\0" (4 bytes) - DOUBLE type tag
    vec.push_back(',');
    vec.push_back('d'); // 'd' for double (8 bytes)
    vec.push_back(0);
    vec.push_back(0);

    // Convert float to double, then store as 8-byte big-endian double
    double dval = static_cast<double>(value);
    union { double d; uint64_t i; } u;
    u.d = dval;

    // Store as big-endian (network byte order)
    uint64_t val = u.i;
    vec.push_back(static_cast<unsigned char>((val >> 56) & 0xFF));
    vec.push_back(static_cast<unsigned char>((val >> 48) & 0xFF));
    vec.push_back(static_cast<unsigned char>((val >> 40) & 0xFF));
    vec.push_back(static_cast<unsigned char>((val >> 32) & 0xFF));
    vec.push_back(static_cast<unsigned char>((val >> 24) & 0xFF));
    vec.push_back(static_cast<unsigned char>((val >> 16) & 0xFF));
    vec.push_back(static_cast<unsigned char>((val >> 8) & 0xFF));
    vec.push_back(static_cast<unsigned char>(val & 0xFF));

    // Back-fill message size (excluding the 4-byte size field itself)
    uint32_t msg_size = static_cast<uint32_t>(vec.size() - start_pos - 4);
    // Store as big-endian (network byte order) - MSB first
    vec[start_pos + 0] = static_cast<unsigned char>((msg_size >> 24) & 0xFF);
    vec[start_pos + 1] = static_cast<unsigned char>((msg_size >> 16) & 0xFF);
    vec[start_pos + 2] = static_cast<unsigned char>((msg_size >> 8) & 0xFF);
    vec[start_pos + 3] = static_cast<unsigned char>(msg_size & 0xFF);
  };

  // Add parameters in EXACT order from old ec2~old.mxo disassembly (addresses 0x4b96-0x500f)
  // Order: grainrate, async, intermittency, streams, playback, duration, envelope,
  //        scanstart, scanrange, amplitude, filterfreq, resonance, pan, scanspeed
  // Then all deviation parameters in same order
  add_message(*x->osc_bundle_buffer, "grainrate", static_cast<float>(x->grain_rate));
  add_message(*x->osc_bundle_buffer, "async", static_cast<float>(x->async));
  add_message(*x->osc_bundle_buffer, "intermittency", static_cast<float>(x->intermittency));
  add_message(*x->osc_bundle_buffer, "streams", static_cast<float>(x->streams));
  add_message(*x->osc_bundle_buffer, "playback", static_cast<float>(x->playback_rate));
  add_message(*x->osc_bundle_buffer, "duration", static_cast<float>(x->grain_duration));
  add_message(*x->osc_bundle_buffer, "envelope", static_cast<float>(x->envelope_shape));
  add_message(*x->osc_bundle_buffer, "scanstart", static_cast<float>(x->scan_start));
  add_message(*x->osc_bundle_buffer, "scanrange", static_cast<float>(x->scan_range));
  add_message(*x->osc_bundle_buffer, "amplitude", static_cast<float>(x->amplitude));
  add_message(*x->osc_bundle_buffer, "filterfreq", static_cast<float>(x->filter_freq));
  add_message(*x->osc_bundle_buffer, "resonance", static_cast<float>(x->resonance));
  add_message(*x->osc_bundle_buffer, "pan", static_cast<float>(x->stereo_pan));
  add_message(*x->osc_bundle_buffer, "scanspeed", static_cast<float>(x->scan_speed));

  // Deviation parameters in matching order
  add_message(*x->osc_bundle_buffer, "grainrate_dev", static_cast<float>(x->grain_rate_dev));
  add_message(*x->osc_bundle_buffer, "async_dev", static_cast<float>(x->async_dev));
  add_message(*x->osc_bundle_buffer, "intermittency_dev", static_cast<float>(x->intermittency_dev));
  add_message(*x->osc_bundle_buffer, "streams_dev", static_cast<float>(x->streams_dev));
  add_message(*x->osc_bundle_buffer, "playback_dev", static_cast<float>(x->playback_dev));
  add_message(*x->osc_bundle_buffer, "duration_dev", static_cast<float>(x->duration_dev));
  add_message(*x->osc_bundle_buffer, "envelope_dev", static_cast<float>(x->envelope_dev));
  add_message(*x->osc_bundle_buffer, "pan_dev", static_cast<float>(x->pan_dev));
  add_message(*x->osc_bundle_buffer, "amp_dev", static_cast<float>(x->amp_dev));
  add_message(*x->osc_bundle_buffer, "filterfreq_dev", static_cast<float>(x->filterfreq_dev));
  add_message(*x->osc_bundle_buffer, "resonance_dev", static_cast<float>(x->resonance_dev));
  add_message(*x->osc_bundle_buffer, "scanstart_dev", static_cast<float>(x->scanstart_dev));
  add_message(*x->osc_bundle_buffer, "scanrange_dev", static_cast<float>(x->scanrange_dev));
  add_message(*x->osc_bundle_buffer, "scanspeed_dev", static_cast<float>(x->scanspeed_dev));

  // LFO parameters (24 total: 6 LFOs × 4 params each)
  // LFO values are read directly from engine
  for (int i = 0; i < 6; i++) {
    auto lfo = x->engine->getLFO(i);
    if (lfo) {
      std::string prefix = "lfo" + std::to_string(i + 1);
      add_message(*x->osc_bundle_buffer, prefix + "shape", static_cast<float>(static_cast<int>(lfo->getShape())));
      add_message(*x->osc_bundle_buffer, prefix + "rate", lfo->getFrequency());
      add_message(*x->osc_bundle_buffer, prefix + "polarity", static_cast<float>(static_cast<int>(lfo->getPolarity())));
      add_message(*x->osc_bundle_buffer, prefix + "duty", lfo->getDuty());
    }
  }

  // LFO modulation routing (new system: global depths + active destinations)
  // Output LFO global depths (6 values)
  for (int i = 0; i < 6; i++) {
    std::string depth_msg = "/lfo" + std::to_string(i + 1) + "_depth";
    add_message(*x->osc_bundle_buffer, depth_msg, static_cast<float>(x->lfo_states[i].global_depth));
  }

  // Output active LFO mappings (variable number based on actual mappings)
  for (int i = 0; i < 6; i++) {
    const LFOState& lfo = x->lfo_states[i];
    for (const auto& dest : lfo.destinations) {
      // Format: /lfo<N>_to_<param>_depth <value>
      std::string map_msg = "/lfo" + std::to_string(i + 1) + "_to_" + dest.param_name + "_depth";
      add_message(*x->osc_bundle_buffer, map_msg, static_cast<float>(dest.depth));
    }
  }

  // Spatial allocation parameters (9 total - real-time messages)
  add_message(*x->osc_bundle_buffer, "fixedchan", static_cast<float>(x->fixed_channel));
  add_message(*x->osc_bundle_buffer, "rrstep", static_cast<float>(x->rr_step));
  add_message(*x->osc_bundle_buffer, "randspread", static_cast<float>(x->random_spread));
  add_message(*x->osc_bundle_buffer, "spatialcorr", static_cast<float>(x->spatial_corr));
  add_message(*x->osc_bundle_buffer, "pitchmin", static_cast<float>(x->pitch_min));
  add_message(*x->osc_bundle_buffer, "pitchmax", static_cast<float>(x->pitch_max));
  add_message(*x->osc_bundle_buffer, "trajshape", static_cast<float>(x->traj_shape));
  add_message(*x->osc_bundle_buffer, "trajrate", static_cast<float>(x->traj_rate));
  add_message(*x->osc_bundle_buffer, "trajdepth", static_cast<float>(x->traj_depth));

  // Output as FullPacket (size + pointer)
  t_atom out_atoms[2];
  long bundle_size = x->osc_bundle_buffer->size();
  unsigned char* bundle_ptr = x->osc_bundle_buffer->data();


  atom_setlong(&out_atoms[0], bundle_size);
  atom_setlong(&out_atoms[1], (t_atom_long)bundle_ptr);
  outlet_anything(x->osc_outlet, gensym("FullPacket"), 2, out_atoms);
}

void ec2_parse_osc_bundle(t_ec2* x, const unsigned char* data, size_t size) {
  if (size < 16) return;  // Minimum bundle size: 8 (header) + 8 (timetag)

  // Verify bundle header "#bundle\0"
  if (memcmp(data, "#bundle", 8) != 0) return;

  size_t pos = 16;  // Skip header (8) + timetag (8)

  // Parse all messages in bundle
  while (pos + 4 <= size) {
    // Read message size (big-endian)
    uint32_t msg_size = (data[pos] << 24) | (data[pos+1] << 16) |
                        (data[pos+2] << 8) | data[pos+3];
    pos += 4;

    if (pos + msg_size > size) break;

    // Parse this message
    ec2_parse_osc_message(x, data + pos, msg_size);

    pos += msg_size;
  }
}

void ec2_parse_osc_message(t_ec2* x, const unsigned char* data, size_t size) {
  if (size < 4) return;

  // Extract OSC address (null-terminated string)
  std::string address;
  size_t pos = 0;
  while (pos < size && data[pos] != 0) {
    address += data[pos++];
  }
  if (pos >= size) return;

  // Skip to 4-byte boundary after address
  pos = (pos + 4) & ~3;
  if (pos >= size) return;

  // Extract type tag string (starts with ',')
  if (data[pos] != ',') return;
  pos++;

  char type_tag = (pos < size) ? data[pos] : 0;
  pos++;

  // Skip to 4-byte boundary after type tags
  pos = (pos + 3) & ~3;
  if (pos >= size) return;

  // Parse value based on type tag
  double value = 0.0;
  if (type_tag == 'f') {
    // Float (4 bytes, big-endian)
    if (pos + 4 > size) return;
    uint32_t raw = (data[pos] << 24) | (data[pos+1] << 16) |
                   (data[pos+2] << 8) | data[pos+3];
    float fval;
    memcpy(&fval, &raw, 4);
    value = fval;
  } else if (type_tag == 'd') {
    // Double (8 bytes, big-endian)
    if (pos + 8 > size) return;
    uint64_t raw = ((uint64_t)data[pos] << 56) | ((uint64_t)data[pos+1] << 48) |
                   ((uint64_t)data[pos+2] << 40) | ((uint64_t)data[pos+3] << 32) |
                   ((uint64_t)data[pos+4] << 24) | ((uint64_t)data[pos+5] << 16) |
                   ((uint64_t)data[pos+6] << 8) | (uint64_t)data[pos+7];
    memcpy(&value, &raw, 8);
  } else if (type_tag == 'i') {
    // Integer (4 bytes, big-endian)
    if (pos + 4 > size) return;
    int32_t ival = (data[pos] << 24) | (data[pos+1] << 16) |
                   (data[pos+2] << 8) | data[pos+3];
    value = ival;
  }

  // Remove leading '/' from address if present
  std::string param_name = address;
  if (!param_name.empty() && param_name[0] == '/') {
    param_name = param_name.substr(1);
  }

  // Route to parameter handler
  ec2_handle_osc_parameter(x, param_name, value);
}

void ec2_handle_osc_parameter(t_ec2* x, const std::string& param_name, double value) {
  // Route OSC parameter to appropriate handler
  if (param_name == "grainrate") ec2_grainrate(x, value);
  else if (param_name == "async") ec2_async(x, value);
  else if (param_name == "intermittency") ec2_intermittency(x, value);
  else if (param_name == "streams") ec2_streams(x, value);
  else if (param_name == "playback") ec2_playback(x, value);
  else if (param_name == "duration") ec2_duration(x, value);
  else if (param_name == "envelope") ec2_envelope(x, value);
  else if (param_name == "amplitude" || param_name == "amp") ec2_amplitude(x, value);
  else if (param_name == "filterfreq") ec2_filterfreq(x, value);
  else if (param_name == "resonance") ec2_resonance(x, value);
  else if (param_name == "pan") ec2_pan(x, value);
  else if (param_name == "scanstart") ec2_scanstart(x, value);
  else if (param_name == "scanrange") ec2_scanrange(x, value);
  else if (param_name == "scanspeed") ec2_scanspeed(x, value);
  // Deviations
  else if (param_name == "grainrate_dev") ec2_grainrate_dev(x, value);
  else if (param_name == "async_dev") ec2_async_dev(x, value);
  else if (param_name == "intermittency_dev") ec2_intermittency_dev(x, value);
  else if (param_name == "streams_dev") ec2_streams_dev(x, value);
  else if (param_name == "playback_dev") ec2_playback_dev(x, value);
  else if (param_name == "duration_dev") ec2_duration_dev(x, value);
  else if (param_name == "envelope_dev") ec2_envelope_dev(x, value);
  else if (param_name == "pan_dev") ec2_pan_dev(x, value);
  else if (param_name == "amp_dev") ec2_amp_dev(x, value);
  else if (param_name == "filterfreq_dev") ec2_filterfreq_dev(x, value);
  else if (param_name == "resonance_dev") ec2_resonance_dev(x, value);
  else if (param_name == "scanstart_dev") ec2_scanstart_dev(x, value);
  else if (param_name == "scanrange_dev") ec2_scanrange_dev(x, value);
  else if (param_name == "scanspeed_dev") ec2_scanspeed_dev(x, value);
  // LFOs
  else if (param_name == "lfo1shape") ec2_lfo1shape(x, value);
  else if (param_name == "lfo1rate") ec2_lfo1rate(x, value);
  else if (param_name == "lfo1polarity") ec2_lfo1polarity(x, value);
  else if (param_name == "lfo1duty") ec2_lfo1duty(x, value);
  else if (param_name == "lfo2shape") ec2_lfo2shape(x, value);
  else if (param_name == "lfo2rate") ec2_lfo2rate(x, value);
  else if (param_name == "lfo2polarity") ec2_lfo2polarity(x, value);
  else if (param_name == "lfo2duty") ec2_lfo2duty(x, value);
  else if (param_name == "lfo3shape") ec2_lfo3shape(x, value);
  else if (param_name == "lfo3rate") ec2_lfo3rate(x, value);
  else if (param_name == "lfo3polarity") ec2_lfo3polarity(x, value);
  else if (param_name == "lfo3duty") ec2_lfo3duty(x, value);
  else if (param_name == "lfo4shape") ec2_lfo4shape(x, value);
  else if (param_name == "lfo4rate") ec2_lfo4rate(x, value);
  else if (param_name == "lfo4polarity") ec2_lfo4polarity(x, value);
  else if (param_name == "lfo4duty") ec2_lfo4duty(x, value);
  else if (param_name == "lfo5shape") ec2_lfo5shape(x, value);
  else if (param_name == "lfo5rate") ec2_lfo5rate(x, value);
  else if (param_name == "lfo5polarity") ec2_lfo5polarity(x, value);
  else if (param_name == "lfo5duty") ec2_lfo5duty(x, value);
  else if (param_name == "lfo6shape") ec2_lfo6shape(x, value);
  else if (param_name == "lfo6rate") ec2_lfo6rate(x, value);
  else if (param_name == "lfo6polarity") ec2_lfo6polarity(x, value);
  else if (param_name == "lfo6duty") ec2_lfo6duty(x, value);
  // NOTE: LFO modulation routing is now handled by ec2_lfo_map() via "anything" messages
  // Spatial allocation parameters
  else if (param_name == "fixedchan") ec2_fixedchan(x, (long)value);
  else if (param_name == "rrstep") ec2_rrstep(x, (long)value);
  else if (param_name == "randspread") ec2_randspread(x, value);
  else if (param_name == "spatialcorr") ec2_spatialcorr(x, value);
  else if (param_name == "pitchmin") ec2_pitchmin(x, value);
  else if (param_name == "pitchmax") ec2_pitchmax(x, value);
  else if (param_name == "trajshape") ec2_trajshape(x, (long)value);
  else if (param_name == "trajrate") ec2_trajrate(x, value);
  else if (param_name == "trajdepth") ec2_trajdepth(x, value);
}
