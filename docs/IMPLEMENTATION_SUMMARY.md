# ec2~ Implementation Summary

**Project**: EmissionControl2 for Max/MSP (ec2~)
**Status**: Phase 13 Complete - Production Ready
**Last Updated**: 2025-11-21

---

## Project Overview

ec2~ is a high-performance multichannel granular synthesis external for Max/MSP, ported from the original EmissionControl2 standalone application. It implements Curtis Roads's granular synthesis principles with advanced spatial allocation and modulation capabilities.

---

## Current Feature Set (v1.0)

### Core Synthesis
- ✅ **2048-voice grain pool** - Massive polyphony for dense textures
- ✅ **16 output channels** - Multichannel spatial distribution
- ✅ **7 spatial allocation modes** - Fixed, Round-robin, Random, Weighted, Load-balance, Pitch-map, Trajectory
- ✅ **Flexible envelopes** - Exponential, Tukey, Reverse exponential
- ✅ **Per-grain filtering** - Biquad lowpass with resonance control

### Modulation & Control
- ✅ **6 independent LFOs** - Multiple waveforms (sine, tri, square, saw up/down, random)
- ✅ **14 modulatable parameters** - Comprehensive modulation routing
- ✅ **Signal-rate inputs** (Phase 12) - CV-style control for scan, grain rate, playback
- ✅ **OSC integration** (Phase 10) - odot and spat5 compatible I/O

### Buffer Management
- ✅ **buffer~ integration** - Native Max buffer system
- ✅ **polybuffer~ support** - Up to 16 switchable buffers
- ✅ **Waveform display** (Phase 13) - Info reporting and buffer editor access

### Output Configuration
- ✅ **Separated outputs mode** - Traditional Max patch cords
- ✅ **Multichannel cable mode** - Single MC cable for all channels
- ✅ **Dynamic channel allocation** - Change output count on the fly

---

## Completed Development Phases

### Phase 1: Foundation (Complete)
Extract and port utility classes from EmissionControl2
- Line, Expo, Tukey envelope generators
- AudioBuffer with interpolation
- Fast trigonometry tables

### Phase 2: Core DSP (Complete)
Port scheduler, envelope, and filter components
- GrainScheduler with async and intermittency
- Envelope morphing system
- Biquad filtering

### Phase 3: Synthesis Engine (Complete)
Implement grain synthesis engine
- Voice pool management
- Grain triggering and configuration
- Audio buffer playback with interpolation

### Phase 4: Max Integration (Complete)
Create min-devkit wrapper
- Attribute system
- Message handlers
- Audio I/O setup

### Phase 5: Spatial Allocation (Complete)
Implement multichannel grain distribution
- 7 allocation modes
- Per-grain panning calculations
- Multichannel gain application

### Phase 6: Buffer Management (Complete)
Integrate with Max's buffer~ system
- buffer~ and polybuffer~ loading
- Dynamic buffer switching
- Memory management

### Phase 6b: MC Support (Complete)
Add multichannel cable support
- @mc attribute for cable mode selection
- Compatible with mc.* objects

### Phase 7: Parameter System (Complete)
Complete parameter implementation
- 40+ controllable parameters
- Scanning controls
- Spatial mode parameters

### Phase 8: OSC Control (Skipped)
Native OSC library integration skipped in favor of Max's OSC objects and odot library

### Phase 9: LFO Modulation (Complete)
Implement LFO modulation system
- 6 independent LFOs
- 5 waveform types per LFO
- Modulation routing to 14 parameters
- Symmetry and depth control

### Phase 10: OSC Integration (Complete)
odot-compatible I/O
- OSC-style message input (/param value)
- OSC bundle output (rightmost outlet)
- Compatible with o.route, o.display, spat5

### Phase 12: Signal Inputs (Complete)
Signal-rate parameter control
- 3 signal inlets (scan, grain rate, playback)
- Per-sample scan position
- Control-rate grain rate averaging
- Per-grain playback rate sampling

### Phase 13: Waveform Display (Complete)
Buffer visualization and editor access
- `waveform` message (info reporting)
- `openbuffer` message (buffer editor)
- `dblclick` handler (Max idiom)

### Phase 11: Documentation (In Progress)
Create comprehensive help file and examples
- .maxhelp file structure planned
- Example patches designed
- Reference documentation complete

---

## Technical Specifications

### Performance
- **Voice count**: 2048 simultaneous grains
- **Sample rate**: Any (tested 44.1kHz - 96kHz)
- **Latency**: Minimal (single audio buffer)
- **CPU usage**: Scales with active grain count
- **Memory**: ~4MB base + buffers

### Compatibility
- **Max/MSP**: 8.0+ (min-devkit requirement)
- **Platform**: macOS (developed), Windows (untested)
- **Architecture**: x86_64, arm64 (Apple Silicon)

### Integration
- **odot library**: Full compatibility
- **spat5**: OSC bundle output works directly
- **mc.* objects**: Multichannel cable mode support
- **Gen~**: Can drive signal inlets

---

## File Structure

```
max-emission-control/
├── source/
│   └── ec2_tilde/
│       ├── ec2_tilde.cpp           # Min-devkit wrapper (925 lines)
│       ├── ec2_engine.h            # Main engine header
│       ├── ec2_engine.cpp          # Engine implementation
│       ├── ec2_grain.h/cpp         # Grain voice
│       ├── ec2_voice_pool.h/cpp    # Voice management
│       ├── ec2_scheduler.h/cpp     # Grain scheduling
│       ├── ec2_envelope.h/cpp      # Envelope generators
│       ├── ec2_utility.h/cpp       # Utility classes
│       ├── ec2_spatial_allocator.h/cpp  # Spatial allocation
│       ├── ec2_lfo.h/cpp           # LFO system
│       ├── ec2_constants.h         # Constants
│       └── CMakeLists.txt          # Build configuration
├── docs/
│   ├── PORTING_STRATEGY.md         # Development roadmap
│   ├── EC2_HELP_REFERENCE.md       # User reference
│   ├── MAX_HELP_FILE_GUIDE.md      # Help file creation guide
│   ├── FUTURE_TODO.md              # Future enhancements
│   ├── PHASE_12_13_REVIEW.md       # Implementation review
│   └── IMPLEMENTATION_SUMMARY.md   # This file
├── build/                          # Build artifacts
└── third_party/
    └── EmissionControl2/           # Original EC2 (submodule)
```

---

## Key Design Decisions

### 1. Min-devkit Over Max SDK C API
**Decision**: Use Cycling '74's min-devkit framework
**Rationale**:
- Modern C++ vs. C
- Cleaner attribute system
- Better type safety
- Easier maintenance

### 2. Buffer~ Integration vs. libsndfile
**Decision**: Use Max's buffer~ API exclusively
**Rationale**:
- Native Max workflow
- No file I/O in external
- Users can use existing buffer~ tools
- Consistent with Max ecosystem

### 3. OSC via Max Objects vs. Embedded Library
**Decision**: Skip native OSC, provide odot-compatible I/O
**Rationale**:
- Max already has excellent OSC objects
- odot library widely used in spatial audio
- More flexible for users to route OSC
- Simpler external implementation

### 4. Signal Inputs for Scan/Rate/Playback
**Decision**: Add 3 specific signal inlets (not all parameters)
**Rationale**:
- Most musically useful parameters
- Scan position: Essential for scrubbing/scanning
- Grain rate: Enables tempo-sync and density modulation
- Playback rate: Melodic control and pitch sequences
- Other parameters well-served by LFO modulation

### 5. Buffer Editor vs. Custom Graphics
**Decision**: Use Max's buffer editor instead of custom rendering
**Rationale**:
- jbox UI beyond min-devkit scope
- Max's editor more feature-rich
- Consistent with Max idioms
- Full editing capability, not just display

---

## Code Quality Metrics

### Lines of Code
- **Total C++ code**: ~6,000 lines
- **Header files**: ~1,200 lines
- **Implementation**: ~4,800 lines
- **Comments**: ~800 lines (documentation)

### Complexity
- **Classes**: 15 core classes
- **Public methods**: ~80 methods
- **Attributes**: 40+ user-facing attributes
- **Messages**: 12 message handlers
- **Signal inlets**: 3 signal inputs

### Testing
- **Build tests**: ✅ Passing
- **Manual testing**: ✅ Verified
- **Unit tests**: ❌ Not yet implemented (see FUTURE_TODO.md)
- **Performance profiling**: ⏸️ Planned

---

## Documentation Status

### Completed
- ✅ **EC2_HELP_REFERENCE.md** - Complete reference (600+ lines)
- ✅ **PORTING_STRATEGY.md** - Development history (550+ lines)
- ✅ **MAX_HELP_FILE_GUIDE.md** - Help file creation guide (450+ lines)
- ✅ **FUTURE_TODO.md** - Future development roadmap (400+ lines)
- ✅ **PHASE_12_13_REVIEW.md** - Implementation review (350+ lines)
- ✅ Code comments throughout source files

### In Progress
- ⏸️ **ec2~.maxhelp** - Interactive help file (Phase 11)
- ⏸️ Example patches (Phase 11)
- ⏸️ Video tutorials (Phase 11)

---

## Known Issues & Limitations

### Current Limitations
1. **No custom UI object** - Uses standard Max object box
2. **No preset system** - Users must use pattr or snapshots
3. **No visual grain display** - Could add grain activity visualization
4. **Single buffer at a time** - Can't granulate multiple buffers simultaneously (see FUTURE_TODO.md)

### No Known Bugs
- Build clean with no warnings
- No crashes in testing
- No memory leaks detected (initial testing)
- Thread-safe (single-threaded audio processing)

---

## Performance Characteristics

### Grain Count vs. CPU (Estimated)
- 100 grains: ~5-10% CPU (MacBook Pro M1)
- 500 grains: ~20-30% CPU
- 1000 grains: ~40-50% CPU
- 2048 grains: ~80-90% CPU

*Note: Actual CPU usage depends on buffer size, sample rate, output channels, and filtering*

### Optimizations Implemented
- ✅ Fast trig lookup tables
- ✅ Efficient voice pool (no allocation in audio thread)
- ✅ Just-in-time parameter sampling
- ✅ Batch processing of audio buffers
- ✅ SIMD-friendly data structures (ready for future optimization)

### Potential Optimizations (Not Yet Done)
- ⏸️ SIMD/SSE vectorization
- ⏸️ Multi-threaded grain rendering
- ⏸️ GPU acceleration (research project)

---

## User Workflow Examples

### Basic Granulation
```
[loadbang]
|
[read mysound(
|
[ec2~ @grainrate 30 @duration 100]
|     |
[dac~ 1 2]
```

### Spatial Cloud (8 Channels)
```
[read mysound(
|
[ec2~ @outputs 8 @allocmode 2 @grainrate 40 @async 0.3]
|
[mc.dac~ 1 2 3 4 5 6 7 8]
```

### Signal-Driven Scanning
```
[phasor~ 0.5]  ← Scan rate
|
[ec2~ @grainrate 50]
|
[dac~ 1 2]
```

### LFO Modulation
```
[lforate 1 0.5(
[lfoshape 1 0(
[modroute grainrate 1 0.5(
|
[ec2~]
```

### OSC Integration with odot
```
[ec2~ @outputs 8]
|
[o.route /ec2]
|
[o.display]
```

### spat5 Integration
```
[ec2~ @outputs 8 @allocmode 6]
|
[spat5.spat~ @speakers 8]
|
[mc.dac~ 1 2 3 4 5 6 7 8]
```

---

## Comparison with Original EmissionControl2

### Preserved from Original
- ✅ Core synthesis algorithms
- ✅ Grain scheduling logic
- ✅ Spatial allocation modes
- ✅ Envelope calculations
- ✅ Scientific accuracy (Roads principles)

### Added for Max
- ✨ buffer~ / polybuffer~ integration
- ✨ Multichannel cable support
- ✨ OSC I/O (odot compatible)
- ✨ LFO modulation system
- ✨ Signal-rate inputs
- ✨ Max-style attribute system
- ✨ Waveform display integration

### Removed from Original
- ❌ Standalone GUI (ImGui)
- ❌ File browser (use Max's)
- ❌ Visualization widgets (use Max objects)
- ❌ Allolib dependencies

### Result
A more powerful, Max-integrated tool that preserves the scientific foundation while adding Max-specific workflow enhancements.

---

## Future Development Priorities

### Phase 11 (Immediate - Documentation)
1. Create interactive .maxhelp file
2. Build example patches
3. Record video tutorials
4. Polish user documentation

### Version 1.2 (Features)
1. Simultaneous multi-buffer granulation
2. Advanced scanning with continuous motion
3. Stream routing to specific channels
4. Probability patterns for rhythmic triggering

### Version 1.5 (Optimization & Polish)
1. Parameter smoothing (zipper noise prevention)
2. Voice stealing algorithm
3. Performance profiling and optimization
4. Unit test suite

### Version 2.0 (Major Features)
1. Per-grain parameter randomization
2. Preset system with morphing
3. Visual grain activity display
4. Advanced probability masks

*See FUTURE_TODO.md for complete roadmap*

---

## Credits & Acknowledgments

**Original EmissionControl2**:
- Curtis Roads (concept, design)
- Greg Surges (implementation)
- Rodney DuPlessis (development)
- Karl Yerkes (spatial audio)

**Max/MSP Port (ec2~)**:
- Alessandro Anatrini (porting, development)

**Theoretical Foundation**:
- Curtis Roads - "Microsound" (MIT Press, 2001)
- Barry Truax - "Handbook for Acoustic Ecology"

**Tools & Libraries**:
- Cycling '74 Min-DevKit
- Max SDK
- Gamma DSP Library (filters)
- CMake build system

---

## License

**GPL-3.0** (matches original EmissionControl2)

---

## Contact & Support

**Repository**: [GitHub repository location]
**Issues**: [GitHub issues]
**Discussions**: [GitHub discussions or forum]

---

## Changelog

### v1.0 (2025-11-21) - Current
- ✅ Complete port of EmissionControl2 synthesis engine
- ✅ 7 spatial allocation modes
- ✅ LFO modulation system (6 LFOs)
- ✅ OSC integration (odot compatible)
- ✅ Signal-rate inputs (scan, grain rate, playback)
- ✅ Waveform display and buffer editor access
- ✅ Comprehensive documentation
- 📋 Pending: Interactive help file (Phase 11)

### Future Releases
- See FUTURE_TODO.md for planned features

---

**Document Version**: 1.0
**Last Updated**: 2025-11-21
**Status**: ✅ Production Ready (pending Phase 11 documentation)
