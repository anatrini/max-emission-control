# EC2 to Max/MSP Porting Strategy

## Executive Summary

This document outlines the strategy for extracting EmissionControl2's grain synthesis engine from allolib and integrating it into a Max/MSP external with multichannel support.

## Current EC2 Architecture Analysis

### Core Components

#### 1. **ecSynth** (main synthesis controller)
- Inherits from `al::SynthVoice` (allolib's voice base class)
- Manages grain scheduling via `voiceScheduler`
- Controls polyphonic grain synthesis via `al::PolySynth`
- Handles parameter management (15 parameters total)
- Manages LFO modulators (6 LFOs)
- Loads/manages audio files
- **Dependencies**: allolib, Gamma DSP

#### 2. **Grain** (individual grain voice)
- Inherits from `al::SynthVoice`
- Per-grain processing:
  - Playback index calculation (with interpolation)
  - Envelope application (`grainEnvelope` - expo/tukey wrapper)
  - Filtering (3-stage biquad cascade from Gamma)
  - Panning (stereo)
  - Amplitude scaling
- **Dependencies**: allolib, Gamma DSP (Biquad filters)

#### 3. **voiceScheduler** (grain emission scheduler)
- Determines when to trigger new grains
- Handles:
  - Grain rate (Hz)
  - Asynchronicity (randomization)
  - Intermittency (probability)
  - Multiple streams (polyphonic grain streams)
- **Dependencies**: None (pure C++)

#### 4. **Utility Classes** (utility.h)
- `buffer<T>`: Audio buffer with interpolation
- `line<T>`: Linear ramp generator
- `expo`: Exponential envelope
- `tukey`: Tukey window envelope
- `RingBuffer`: For visualization (can be stripped)
- `FastTrig`: Optimized trig lookup table
- **Dependencies**: Gamma (for some DSP), libsndfile (for loading)

#### 5. **Parameters** (ecParameter, ecModParameter)
- Parameter management with modulation
- LFO assignment
- OSC/MIDI mapping (we keep OSC, strip MIDI)
- **Dependencies**: allolib parameter system

### What Must Be STRIPPED

1. **UI Components** (ecInterface.h/cpp)
   - Entire ImGui interface
   - All visualization code
   - MIDI learning interface
   - Preset GUI

2. **Allolib-Specific**
   - `al::SynthVoice` base class → replace with plain C++ class
   - `al::PolySynth` → create custom voice pool
   - `al::AudioIOData` → use Max's MSP audio buffers
   - `al::Parameter` → use min-devkit attributes
   - File dialog (NFD) → use Max's buffer~ infrastructure

3. **Visualization**
   - Oscilloscope ring buffers
   - VU meters
   - Peak detection (unless needed for DSP)
   - Grain visualizers

### What Must Be ADAPTED

1. **Audio Callback**
   - FROM: `onProcess(al::AudioIOData &io)`
   - TO: min-devkit's `operator()(audio_bundle input, audio_bundle output)`

2. **Parameter System**
   - FROM: allolib `Parameter` objects
   - TO: min-devkit `attribute<>` objects

3. **Voice Management**
   - FROM: `al::PolySynth::allocatePolyphony<Grain>(2048)`
   - TO: Custom voice pool with free list

4. **File Loading**
   - FROM: allolib's `util::load()` with libsndfile
   - TO: Either keep libsndfile OR use Max's `buffer~` API

5. **Multichannel Output**
   - **CURRENT**: Fixed stereo (2 channels)
   - **NEW**: Up to 16 channels with grain allocation strategies
   - Need to implement grain-to-channel routing logic

### What Can Be KEPT As-Is

1. **Core DSP (Gamma library)**
   - `gam::Biquad<>` filters
   - Can bundle Gamma or extract just the filter code

2. **Utility Classes**
   - `util::buffer<T>` with interpolation
   - `util::line<T>` ramp
   - `util::expo` and `util::tukey` envelopes
   - `FastTrig` lookup table

3. **Grain Scheduling Logic**
   - `voiceScheduler` class (pure C++, no dependencies)

4. **Grain Processing Algorithm**
   - Core grain synthesis in `Grain::onProcess()`
   - Just need to adapt I/O interface

## Porting Strategy - Phase by Phase

### Phase 1: Extract Core Utility Classes ✅ COMPLETED
**Goal**: Create standalone versions of utility classes without allolib dependencies

**Completed Tasks**:
1. ✅ Created `ec2_constants.h` with all synthesis constants
2. ✅ Created `ec2_utility.h/cpp` with standalone DSP utilities
3. ✅ Removed all allolib includes
4. ✅ Extended MAX_AUDIO_OUTS from 2 to 16 channels
5. ✅ Added multichannel spatial modes

**Deliverable**: ✅ Standalone utility library compiles (858KB .mxo)

**Commit**: "Phase 1: Extract EC2 utility classes as standalone library"

---

### Phase 2: Port Scheduler, Envelope, and Filter ✅ COMPLETED
**Goal**: Create standalone grain scheduler, envelope generator, and filters

**Completed Tasks**:
1. ✅ Ported `voiceScheduler` → `ec2_scheduler.h/cpp` (GrainScheduler)
2. ✅ Replaced `al::rnd::Random` with C++ `<random>`
3. ✅ Ported `grainEnvelope` → `ec2_envelope.h/cpp` (GrainEnvelope)
4. ✅ Created standalone `ec2_filter.h` (Biquad, replaces Gamma)
5. ✅ Direct Form II filter implementation

**Deliverable**: ✅ All components compile (871KB .mxo)

**Commit**: "Phase 2: Add grain scheduler, envelope, and filter"

---

### Phase 3: Port Grain Synthesis Engine ✅ COMPLETED
**Goal**: Extract individual grain voice from allolib constraints

**Completed Tasks**:
1. ✅ Ported `Grain` class without `al::SynthVoice` inheritance
2. ✅ Ported grain DSP processing loop
3. ✅ Integrated GrainEnvelope and 3-stage Biquad filtering
4. ✅ Implemented playback with interpolation
5. ✅ Implemented constant-power panning
6. ✅ Added voice count compensation

**Deliverable**: ✅ Working grain voice compiles (884KB .mxo)

**Commit**: "Phase 3: Port grain synthesis engine"

---

### Phase 4: Integrate with min-devkit ✅ COMPLETED
**Goal**: Create custom voice pool and connect to Max external wrapper

**Completed Tasks**:
1. ✅ Created custom voice pool (`ec2_voice_pool.h/cpp`)
   - Free-list allocation for 2048 grain voices
   - O(1) allocation and deallocation
   - Automatic cleanup of finished grains
2. ✅ Created main engine coordinator (`ec2_engine.h/cpp`)
   - Coordinates scheduler, voice pool, and parameters
   - Manages audio buffers and scan position
   - Main process() method for grain generation
3. ✅ Integrated engine into `ec2_tilde.cpp` min-devkit wrapper
   - All EC2 parameters exposed as min-devkit attributes
   - Connected dspsetup to engine initialization
   - Implemented audio callback with float/double conversion
   - Added clear message for stopping grains
4. ✅ Handled sample rate changes via dspsetup message
5. ✅ Added `read` message stub (full implementation in Phase 5)

**Deliverable**: ✅ Basic functioning external compiles (991KB .mxo)

**Technical Notes**:
- Min-devkit uses double precision, engine uses float
- Temporary buffers allocated per callback for type conversion
- Stereo output working, multichannel ready for Phase 5

**Commit**: "Phase 4: Integrate engine with min-devkit wrapper"

---

### Phase 5: Multichannel Architecture ✅ COMPLETED
**Goal**: Implement sophisticated multichannel grain distribution based on Roads's "Microsound"

**Completed Tasks**:
1. ✅ Implemented comprehensive spatial allocation system
   - Created `ec2_spatial_allocator.h/cpp`
   - 7 allocation modes: fixed, roundrobin, random, weighted, loadbalance, pitchmap, trajectory
   - Grain metadata system (emission time, pitch, spectral features)
   - State management for each mode
2. ✅ Extended grain/voice pool for multichannel output
   - Added `processMultichannel()` method to Grain class
   - Multichannel panning gains per grain
   - VoicePool routes to N channels
3. ✅ Integrated allocator into engine
   - Spatial allocator called per grain emission
   - Parameters mapped from SynthParameters.spatial
   - Grain emission time tracking
4. ✅ Added 11 control parameters to ec2_tilde wrapper
   - Mode selection, per-mode parameters
   - All modes controllable via Max attributes
5. ✅ Created comprehensive help documentation
   - EC2_HELP_REFERENCE.md as maxhelp skeleton
   - Detailed mode explanations with theory
   - Usage examples and configurations

**Deliverable**: ✅ Multichannel grain synthesis (1.0MB .mxo)

**Technical Implementation**:
- Constant-power panning between adjacent channels
- PanningVector with 16-channel gain arrays
- Trajectory evaluation with multiple waveforms
- Pitchmap with logarithmic frequency scaling
- Load-balance with tie-breaking strategies
- Spatial correlation for random mode

**Commit**: "Phase 5: Implement multichannel spatial allocation system"

---

### Phase 6: Buffer Management & Audio Loading ✅ COMPLETED
**Goal**: Implement buffer~ / polybuffer~ reference API for audio file management

**Completed Tasks**:
1. ✅ Implemented inline buffer loading (avoided duplicate symbol errors)
2. ✅ Used Max SDK `buffer_ref_*` API to read audio buffers
3. ✅ Connected to engine's `setAudioBuffer()` method
4. ✅ Implemented `read` message for single buffer~ loading
5. ✅ Implemented `polybuffer` message for multi-buffer loading
6. ✅ Added `@buffer` attribute for buffer~ name
7. ✅ Added `@soundfile` attribute (0-15) for buffer selection

**Deliverable**: ✅ Full buffer~ / polybuffer~ integration (1.2MB .mxo)

**Technical Notes**:
- Buffer management implemented inline in `ec2_tilde.cpp` to avoid duplicate symbols
- Uses `buffer_ref_new`, `buffer_locksamples`, `buffer_unlocksamples` API
- Copies buffer data into EC2 AudioBuffer format (interleaved float)
- Supports both single buffer~ and polybuffer~ workflows

**Commit**: "Phase 6: Implement buffer~ reference and audio loading"

---

### Phase 6b: Multichannel Cable Support ✅ COMPLETED
**Goal**: Add built-in multichannel cable output mode via @mc attribute

**Completed Tasks**:
1. ✅ Implemented `@mc` attribute (0=separated outputs, 1=multichannel cable)
2. ✅ Implemented `@outputs` attribute (1-16 channels, default 2)
3. ✅ Updated constructor to parse num_outputs argument
4. ✅ Fixed `mc_get_output_channel_count()` to return `@outputs` value
5. ✅ Documented multichannel configuration in EC2_HELP_REFERENCE.md
6. ✅ Updated help reference with detailed examples

**Deliverable**: ✅ Native multichannel cable support (1.2MB .mxo)

**Technical Implementation**:
- `@outputs` controls NUMBER of output channels (1-16)
- `@mc` controls DELIVERY mode:
  - @mc 0: Separated outputs (each channel needs its own Max cord)
  - @mc 1: Multichannel cable (single blue/black cord carries all channels)
- Both attributes are independent
- No need for `mc.ec2~` wrapper - functionality is built-in via `mc_operator<>`

**Commit**: "Phase 6b: Add multichannel cable output support via @mc attribute"

---

### Phase 7: Parameter Completion ✅ COMPLETED
**Goal**: Add remaining EC2 parameters

**Completed Tasks**:
1. ✅ Added envelope shape parameter (`@envelope`, 0.0-1.0)
   - 0.0: Exponential decay
   - 0.5: Tukey window (default)
   - 1.0: Reverse exponential
2. ✅ Added filter frequency control (`@filterfreq`, 20-22000 Hz)
3. ✅ Added filter resonance control (`@resonance`, 0.0-1.0)
4. ✅ Added pan parameter for stereo mode (`@pan`, -1.0-1.0)
5. ✅ Added scan speed parameter (`@scanspeed`, -32.0-32.0)
6. ✅ Wired all parameters to engine via updateEngineParameters()
7. ✅ Documented all parameters in EC2_HELP_REFERENCE.md
8. ✅ Added 3 new example configurations showcasing new parameters

**Deferred Tasks** (Future phases):
- Weighted mode UI (requires list/array message handling) - Phase 9
- Cluster/mask for channel subset selection - Phase 9

**Deliverable**: ✅ Complete core parameter set (1.2MB .mxo)

**Technical Notes**:
- Envelope morphs between three envelope types via single parameter
- Filter uses 3-stage biquad cascade (already implemented in ec2_grain)
- Pan only affects stereo output (@outputs 2)
- Scan speed interacts with scanstart/scanrange for evolving textures
- All parameters validated within safe ranges

**Commit**: "Phase 7: Add remaining synthesis parameters (envelope, filter, pan, scanspeed)"

---

### Phase 8: OSC Control (Native Library) ⊗ SKIPPED
**Goal**: Add native OSC parameter control via embedded library

**Reason for skipping**: Not needed - Max already has excellent OSC infrastructure (native objects, odot library). Embedding OSC would be redundant and less flexible than Max patching. See Phase 10 for OSC integration approach.

**Decision**: Users can route OSC to ec2~ using Max's native OSC objects or odot library.

---

### Phase 9: LFO Modulation System ✅ COMPLETED
**Goal**: Port EC2's LFO modulation system

**Completed Tasks**:
1. ✅ Created LFO oscillator engine (`ec2_lfo.h/cpp`)
2. ✅ Implemented 6 independent LFOs
3. ✅ Added 5 waveform shapes (sine, square, rise, fall, noise)
4. ✅ Added 3 polarity modes (bipolar, unipolar+, unipolar-)
5. ✅ Implemented modulation routing via `modroute` message
6. ✅ Integrated modulation into audio engine
7. ✅ Added 24 LFO control attributes (4 per LFO)

**Deliverable**: ✅ Complete LFO modulation system (2.0MB .mxo)

**Technical Implementation**:
- 6 LFOs with adjustable frequency (0.001-100 Hz)
- Duty cycle control for square wave
- Control-rate modulation (grainrate, async, intermittency, streams, scan params)
- Per-grain modulation (playback, duration, envelope, filter, pan, amp)
- 14 modulatable parameters with depth control (0.0-1.0)
- Automatic parameter range clamping

**Commit**: "Phase 9: Implement LFO modulation system"

---

### Phase 10: OSC Integration (odot-compatible) ✅ COMPLETED
**Goal**: OSC-style parameter control and state output for integration with odot/spat5 workflows

**Completed Tasks**:
1. ✅ Added OSC outlet for parameter state output
2. ✅ Implemented OSC-style message input (`/param_name value`)
3. ✅ Added `anything` message handler for OSC paths
4. ✅ Implemented `bang` message to output full parameter state
5. ✅ Created parameter-to-OSC mapping for all 40+ parameters
6. ✅ Made compatible with o.display for real-time visualization

**Deliverable**: ✅ OSC-compatible parameter I/O (2.1MB .mxo)

**Technical Implementation**:
- Receives OSC-style messages: `/grainrate 20`, `/filterfreq 1000`, etc.
- Handles nested paths: `/ec2/grainrate` → `grainrate`
- Outputs parameter state as OSC address/value pairs
- Compatible with odot library (o.display, o.route, o.expr)
- Similar workflow to spat5 library
- No traditional Max attribute messages needed (though still supported)
- `bang` message triggers full parameter dump

**Usage**:
```
[udpreceive 7400]           // Receive OSC from network
|
[o.route /ec2]             // Route /ec2 messages
|
[ec2~ @outputs 8]          // OSC input via anything message
|
[o.display]                // Visualize parameter state
```

**Commit**: "Phase 10: Add OSC integration (odot-compatible I/O)"

---

### Phase 12: Signal-Rate Inputs ✅ COMPLETED
**Goal**: Add signal-rate control for key parameters to enable CV-style modulation

**Completed Tasks**:
1. ✅ Added 3 signal inlets: scan position, grain rate, playback rate
2. ✅ Implemented signal-rate processing in engine
3. ✅ Signal inputs override attributes when connected
4. ✅ Backward compatible - falls back to attributes + LFO modulation when no signal

**Design Decisions**:
- **Scan position**: Per-sample processing (most important for scrubbing/scanning)
- **Grain rate**: Control-rate averaging (grain scheduling is control-rate)
- **Playback rate**: Per-grain (each grain gets current signal value when triggered)

**Signal processing approach**:
- Scan signal: Updates grain start position per-sample (0.0-1.0 normalized)
- Rate signal: Averaged over buffer for control-rate grain scheduling (0.1-500 Hz)
- Playback signal: Sampled per-grain for transposition (-32 to 32 semitones)

**Usage example**:
```
[phasor~ 0.5]        [phasor~ 20]         [sig~ 1.5]
|                    |                     |
[*~ 1.]             [+~ 10]              [*~ 0.5]
|                    |                     |
|                    |                     |
[ec2~ mybuffer @outputs 2]
```

**Commit**: "Phase 12: Add signal-rate inputs (scan, grainrate, playback)"

---

### Phase 13: Waveform Display ✅ COMPLETED
**Goal**: Add waveform visualization and buffer editor access

**Completed Tasks**:
1. ✅ Added `waveform` message for buffer info reporting
2. ✅ Added `openbuffer` message to open Max buffer editor
3. ✅ Added `dblclick` message handler (delegates to openbuffer)

**Implementation notes**:
- Full graphical waveform display in object would require jbox UI object (beyond min-devkit scope)
- Instead: provides `waveform` message for info and `openbuffer`/`dblclick` to open Max's built-in buffer editor
- Users can view/edit waveforms using familiar Max buffer~ editor interface

**Messages**:
- `waveform` - Reports buffer info (frames, channels, duration, peak amplitude)
- `openbuffer` - Opens Max buffer editor for current buffer
- `dblclick` - Double-click object to open buffer editor (like waveform~)

**Usage example**:
```
[ec2~ mybuffer]
|
[waveform(        // Print buffer info to console
[openbuffer(      // Open buffer editor window
// Or just double-click the ec2~ object
```

**Commit**: "Phase 13: Add waveform display (info + buffer editor access)"

---

### Phase 11: Documentation & Help Files
**Goal**: Complete user documentation and Max help patch

**Tasks**:
1. Complete EC2_HELP_REFERENCE.md with all Phase 9-13 features
2. Document LFO modulation system
3. Document OSC integration and workflows
4. Document signal-rate inputs (Phase 12)
5. Document waveform display features (Phase 13)
6. Create interactive .maxhelp file
7. Add example patches demonstrating key features
8. Document integration with odot and spat5

**Deliverable**: Complete documentation suite

**Commit**: "Phase 11: Complete documentation and help files"

---

## Project Timeline

### Completed Phases (Phases 1-13)
- ✅ **Phase 1**: Extract utility classes (complete)
- ✅ **Phase 2**: Port scheduler, envelope, filter (complete)
- ✅ **Phase 3**: Port grain synthesis engine (complete)
- ✅ **Phase 4**: Integrate with min-devkit (complete)
- ✅ **Phase 5**: Multichannel spatial allocation (complete)
- ✅ **Phase 6**: Buffer management & audio loading (complete)
- ✅ **Phase 6b**: Multichannel cable support (complete)
- ✅ **Phase 7**: Parameter completion (complete)
- ⊗ **Phase 8**: OSC control (native library) - SKIPPED (redundant with Max OSC)
- ✅ **Phase 9**: LFO modulation system (complete)
- ✅ **Phase 10**: OSC integration (odot-compatible) (complete)
- ✅ **Phase 12**: Signal-rate inputs (complete)
- ✅ **Phase 13**: Waveform display (complete)

### Current Status
**Full-featured granular synthesizer: COMPLETE**
- ✅ All essential synthesis parameters
- ✅ Multichannel spatial allocation (7 modes)
- ✅ Buffer~ / polybuffer~ integration
- ✅ LFO modulation system (6 LFOs, 14 modulatable params)
- ✅ OSC integration (odot/spat5 compatible)
- ✅ Signal-rate inputs (scan, grainrate, playback)
- ✅ Waveform display and buffer editor access
- ✅ 40+ controllable parameters
- ✅ 2048-voice grain pool
- ✅ Up to 16 output channels
- **Status**: Feature-complete, ready for documentation

### Remaining Work (Phase 11)
- 📖 **Phase 11**: Documentation & help files
  - Priority: **High** - Essential for users
  - Document LFO system, OSC integration
  - Create .maxhelp file
  - Example patches and workflows

## Dependencies Decision Matrix

| Dependency | Keep? | Strategy |
|------------|-------|----------|
| **Gamma DSP** | Yes | Bundle Gamma headers (header-only for filters) |
| **libsndfile** | Maybe | Option 1: Bundle it; Option 2: Use Max buffer~ API |
| **allolib** | No | Replace all allolib code |
| **ImGui** | No | Strip completely |
| **NFD (file dialog)** | No | Use Max's `read` message |
| **Gamma Filters** | Yes | Extract or bundle |

## Multichannel Grain Allocation Strategies

### Strategy 1: Round-Robin
Each new grain assigned to next channel in sequence

### Strategy 2: Spatial Distribution
Grains distributed based on pan parameter mapped to channel index

### Strategy 3: Frequency-Based
Higher frequency grains → higher channel numbers

### Strategy 4: Random Distribution
Random channel assignment per grain

### Strategy 5: User-Defined
OSC message can specify target channel for each grain stream

## File Structure After Porting

```
source/ec2_tilde/
├── ec2_tilde.cpp              # Min-devkit wrapper
├── ec2_engine.h               # Main grain engine controller
├── ec2_engine.cpp
├── ec2_grain.h                # Individual grain voice
├── ec2_grain.cpp
├── ec2_scheduler.h            # Grain scheduler (ported voiceScheduler)
├── ec2_scheduler.cpp
├── ec2_voice_pool.h           # Custom voice allocation
├── ec2_voice_pool.cpp
├── ec2_parameters.h           # Parameter management
├── ec2_parameters.cpp
├── ec2_utility.h              # Utility classes (buffer, envelopes, etc.)
├── ec2_utility.cpp
├── ec2_constants.h            # Constants
├── ec2_osc.h                  # OSC handling (Phase 6)
├── ec2_osc.cpp
└── CMakeLists.txt
```

## Next Immediate Steps

1. **Create `docs/` directory** ✅
2. **Phase 1: Extract utility classes** → This is what we should do FIRST
3. Get it compiling standalone
4. Commit

## Decisions Made

1. **Audio File Loading**: ✅ **Use Max buffer~ / polybuffer~ API**
   - `polybuffer~` is perfect for EC2's multi-file architecture
   - Max-idiomatic: integrates with buffer~ ecosystem
   - No memory duplication, users can use waveform~ editor
   - Implementation: `ec2~ mypolybuffer` references polybuffer~ by name

2. **Gamma DSP**: ✅ **Bundle Gamma headers** (mostly header-only)
   - Extract just the Biquad filter code we need

3. **LFO System**: ✅ **Phase 7** (optional), focus on core first

---

**Ready to proceed with Phase 1?** We'll start by extracting the utility classes and making them compile standalone.
