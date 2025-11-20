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

### Phase 4: Integrate with min-devkit ⏳ NEXT
**Goal**: Create custom voice pool and connect to Max external wrapper

**Tasks**:
1. Implement parameter attributes in `ec2_tilde.cpp`
2. Create audio perform callback
3. Integrate grain pool with MSP audio buffers
4. Handle sample rate changes
5. Implement `read` message for loading audio files

**Deliverable**: Basic functioning external (stereo output)

**Commit**: "Integrate grain engine with min-devkit wrapper"

---

### Phase 5: Multichannel Architecture
**Goal**: Implement 16-channel output with grain routing

**Tasks**:
1. Extend audio output to N channels
2. Implement grain-to-channel allocation strategies:
   - **Mode 0**: Mono (all grains → all channels equally)
   - **Mode 1**: Stereo (grains → L/R pan)
   - **Mode 2**: Multichannel distribution (round-robin, spatial, etc.)
3. Add `@spatialmode` attribute
4. Test with `mc.ec2~` wrapper

**Deliverable**: Multichannel grain synthesis

**Commit**: "Add multichannel output support with grain routing"

---

### Phase 6: OSC Control
**Goal**: Add native OSC parameter control

**Tasks**:
1. Integrate OSC library (liblo or Max's native OSC)
2. Map all attributes to OSC addresses (`/ec2/grainrate`, etc.)
3. Implement OSC message parsing
4. Add `@oscport` attribute

**Deliverable**: Full OSC parameter control

**Commit**: "Add OSC parameter control support"

---

### Phase 7: LFO Modulators (Optional)
**Goal**: Port EC2's LFO modulation system

**Tasks**:
1. Port `ecModulator` class
2. Implement LFO-to-parameter routing
3. Add LFO attributes (rate, shape, polarity, width)

**Deliverable**: Parameter modulation via LFOs

**Commit**: "Add LFO modulation system"

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
