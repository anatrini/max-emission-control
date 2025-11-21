# ec2~ Future Development TODO

This document outlines potential future enhancements and improvements for ec2~.

---

## Priority 1: Essential (Phase 11)

### Documentation & Help Files
- [ ] Create interactive `ec2~.maxhelp` file following MAX_HELP_FILE_GUIDE.md
- [ ] Create example patches demonstrating:
  - [ ] Dense spatial clouds
  - [ ] Rhythmic granulation with LFO modulation
  - [ ] Spectral freezing
  - [ ] Signal-driven scanning
  - [ ] OSC/odot workflow integration
  - [ ] spat5 integration for spatial audio
- [ ] Create tutorial video or written guide
- [ ] Document common troubleshooting scenarios
- [ ] Create reference card (quick parameter guide)

**Estimated effort**: 2-3 weeks
**Priority**: HIGH - Essential for user adoption

---

## Priority 2: Features (Requested by Users)

### Simultaneous Multi-Buffer Granulation
**Description**: Enable simultaneous granulation from multiple buffers at once (currently switches between buffers)

**Use case**: Layer multiple sound sources in one granular cloud

**Implementation approach**:
- Add `@polyphonic 0/1` attribute
- When enabled, each grain stream can target a different buffer
- Routing: stream ID → buffer index mapping
- Message: `bufferroute <stream_id> <buffer_id>`

**Files to modify**:
- `ec2_engine.cpp`: Grain triggering logic to select buffer per stream
- `ec2_tilde.cpp`: Add polyphonic attribute and routing messages

**Estimated effort**: 1 week
**Priority**: MEDIUM

---

### Advanced Scanning System
**Description**: Full implementation of scanner with continuous motion

**Current state**: Basic scan position (static or signal-driven)

**Enhancement**:
- Implement continuous scanning with `@scanspeed`
- Add scan direction control (forward/backward/pendulum)
- Add scan acceleration
- Use the `Line<double> mScanner` already in code (ec2_engine.h:189)

**Files to modify**:
- `ec2_engine.cpp`: Implement scanner update in process loop (currently TODO at line 119)

**Estimated effort**: 1-2 days
**Priority**: LOW-MEDIUM

---

### Stream Routing
**Description**: Explicit routing of grain streams to output channels

**Current state**: Stream parameter exists but routing not implemented (TODO at ec2_engine.cpp:134)

**Enhancement**:
- Message: `streamroute <stream_id> <channel_id>`
- Allow independent spatial allocation per stream
- Per-stream parameter control

**Use cases**:
- Route different streams to different speaker pairs
- Independent spatial motion per stream
- Complex multi-layer spatial textures

**Files to modify**:
- `ec2_grain.h/cpp`: Add stream ID to grain metadata
- `ec2_spatial_allocator.cpp`: Respect stream routing
- `ec2_tilde.cpp`: Add routing message handler

**Estimated effort**: 3-4 days
**Priority**: LOW-MEDIUM

---

### Probability Masks
**Description**: Pattern-based grain triggering

**Enhancement**:
- Define probability patterns: e.g., `[1.0, 0.5, 0.8, 0.2, 1.0, 0.0, ...]`
- Grain trigger probability cycles through pattern
- Message: `probpattern <list of probabilities>`

**Use cases**:
- Rhythmic grain patterns
- Euclidean rhythm-style distributions
- Controlled density variation

**Files to modify**:
- `ec2_scheduler.h/cpp`: Add pattern buffer and cycle through it

**Estimated effort**: 2-3 days
**Priority**: LOW

---

## Priority 3: Optimizations

### Voice Stealing Algorithm
**Description**: Improve voice allocation when pool is full

**Current state**: Simply returns nullptr when no voices available (ec2_engine.cpp:170)

**Enhancement**:
- Implement oldest-first voice stealing
- Fade out stolen voices to avoid clicks
- Priority-based stealing (keep louder grains, steal quieter ones)

**Files to modify**:
- `ec2_voice_pool.cpp`: Implement voice stealing in `getFreeVoice()`
- `ec2_grain.cpp`: Add fade-out on premature stop

**Estimated effort**: 1-2 days
**Priority**: MEDIUM

---

### SSE/SIMD Optimization
**Description**: Vectorize critical DSP loops

**Targets**:
- Grain envelope generation
- Buffer interpolation
- Multichannel gain application

**Files to modify**:
- `ec2_grain.cpp`: Process loop vectorization
- `ec2_envelope.cpp`: SIMD envelope calculation

**Estimated effort**: 1 week
**Priority**: LOW (only if profiling shows bottlenecks)

---

### Parameter Smoothing
**Description**: Add smoothing to prevent zipper noise on parameter changes

**Current state**: Attribute changes are applied immediately

**Enhancement**:
- Add configurable smoothing time (default 10-50ms)
- Use `Line` class for parameter interpolation
- Apply to sensitive parameters: amplitude, filter freq, playback rate

**Files to modify**:
- `ec2_engine.cpp`: Add Line objects for smoothed parameters
- `ec2_tilde.cpp`: Add `@smoothing` attribute

**Estimated effort**: 2-3 days
**Priority**: LOW-MEDIUM

---

## Priority 4: Advanced Features

### Per-Grain Parameter Randomization
**Description**: Add randomization ranges for grain parameters

**Enhancement**:
- Attributes like `@playbackvar <amount>` for playback rate variance
- Each grain gets random value within range
- Apply to: playback, duration, amplitude, pan

**Use cases**:
- More organic, natural textures
- Avoid mechanical repetition
- Spectral spreading

**Files to modify**:
- `ec2_tilde.cpp`: Add variance attributes
- `ec2_engine.cpp`: Apply random offsets when configuring grains

**Estimated effort**: 2-3 days
**Priority**: LOW

---

### Freeze Mode
**Description**: Freeze current grain cloud (continue playing current grains, stop triggering new ones)

**Enhancement**:
- Message: `freeze 0/1` or `freeze <duration_ms>`
- Useful for transitional moments
- Can crossfade between frozen and active states

**Files to modify**:
- `ec2_scheduler.cpp`: Add freeze flag to bypass triggering
- `ec2_tilde.cpp`: Add freeze message handler

**Estimated effort**: 1 day
**Priority**: LOW

---

### Grain Trigger Density Visualization
**Description**: Output visual feedback on grain triggering

**Enhancement**:
- Additional outlet outputting grain trigger events
- Format: bang per grain or count per audio buffer
- Useful for visual feedback in Max patches

**Files to modify**:
- `ec2_tilde.cpp`: Add outlet, send bangs on grain trigger
- `ec2_engine.cpp`: Report trigger events back to wrapper

**Estimated effort**: 1 day
**Priority**: LOW

---

### Preset System
**Description**: Native preset management

**Current state**: Users must use `pattr` system

**Enhancement**:
- Built-in preset slots (e.g., 8 presets)
- Messages: `store <slot>`, `recall <slot>`, `interpolate <slot1> <slot2> <mix>`
- Morphing between presets

**Files to modify**:
- `ec2_tilde.cpp`: Add preset storage, recall, and interpolation

**Estimated effort**: 3-4 days
**Priority**: LOW

---

## Priority 5: Code Quality & Maintenance

### Unit Tests
**Description**: Add automated testing

**Tests needed**:
- Grain triggering correctness
- Spatial allocation algorithms
- LFO waveform generation
- Signal input processing
- Buffer boundary checks

**Framework**: Google Test or Catch2

**Estimated effort**: 1-2 weeks
**Priority**: MEDIUM (for long-term maintenance)

---

### Continuous Integration
**Description**: Automated builds on commit

**Setup**:
- GitHub Actions or similar
- Build on macOS, Windows (if supported)
- Run tests automatically
- Generate binary releases

**Estimated effort**: 2-3 days
**Priority**: LOW-MEDIUM

---

### Performance Profiling Suite
**Description**: Benchmark and profile performance

**Metrics**:
- CPU usage vs. grain count
- Voice allocation overhead
- Signal processing efficiency
- Memory usage

**Tools**: Instruments (macOS), VTune (Windows/Linux)

**Estimated effort**: 1 week
**Priority**: LOW (do after optimization work)

---

### Code Documentation (Doxygen)
**Description**: Generate API documentation from code

**Enhancement**:
- Add Doxygen comments to all public methods
- Generate HTML documentation
- Class diagrams

**Estimated effort**: 3-4 days
**Priority**: LOW

---

## Priority 6: Platform Support

### Windows Build Support
**Description**: Ensure ec2~ builds and runs on Windows

**Current state**: Developed on macOS

**Tasks**:
- Test CMake build on Windows
- Fix any platform-specific issues
- Test with Max for Windows
- Document Windows build process

**Estimated effort**: 2-3 days
**Priority**: MEDIUM (if Windows users request it)

---

### Linux/JUCE Port
**Description**: Port to JUCE for standalone or other DAWs

**Scope**: Large project, separate from Max version

**Estimated effort**: 4-6 weeks
**Priority**: VERY LOW (only if demand warrants)

---

## Priority 7: Research & Experimental

### GPU-Accelerated Grain Rendering
**Description**: Offload grain synthesis to GPU

**Approach**:
- Use Metal (macOS) or CUDA/OpenCL
- Render many grains in parallel
- Transfer audio back to CPU for output

**Challenges**:
- Audio latency
- CPU-GPU transfer overhead
- Complexity

**Estimated effort**: 4-8 weeks (research project)
**Priority**: VERY LOW (experimental)

---

### Machine Learning Parameter Mapping
**Description**: Learn parameter relationships from user interactions

**Approach**:
- Record parameter changes over time
- Use ML to predict parameter settings from high-level controls
- "Smart" preset morphing

**Estimated effort**: 6-12 weeks (research project)
**Priority**: VERY LOW (experimental)

---

### Physical Modeling Integration
**Description**: Use physical models as grain sources

**Approach**:
- Generate grains from modal synthesis models
- Per-grain physical parameter variation
- Hybrid granular/physical modeling

**Estimated effort**: 8-12 weeks (research project)
**Priority**: VERY LOW (experimental)

---

## Bug Fixes & Known Issues

### Known Issues (None Currently)
- No known bugs as of Phase 13 completion

### Potential Issues to Monitor
- [ ] Memory leaks during long sessions (test with Instruments)
- [ ] Voice pool exhaustion with very high grain rates (>200 Hz)
- [ ] Buffer switching artifacts (test polybuffer~ workflow)
- [ ] Thread safety in buffer loading (verify Max's buffer~ API thread safety)

---

## Community Requests

Track user-requested features here:

### From Users
- *None yet - external just completed*

### From Beta Testers
- *Awaiting beta testing feedback*

---

## Version Roadmap

### v1.0 (Current - Phase 13 Complete)
- ✅ Core granular synthesis engine
- ✅ 7 spatial allocation modes
- ✅ LFO modulation system (6 LFOs)
- ✅ OSC integration (odot compatible)
- ✅ Signal-rate inputs
- ✅ Waveform display
- ✅ Up to 16 output channels
- ✅ 2048-voice grain pool

### v1.1 (Documentation Release)
- [ ] Complete help file (Phase 11)
- [ ] Example patches
- [ ] Tutorial documentation
- [ ] Website/repository polish

### v1.2 (Feature Enhancement)
- [ ] Simultaneous multi-buffer granulation
- [ ] Advanced scanning system
- [ ] Stream routing
- [ ] Voice stealing algorithm

### v1.5 (Optimization & Polish)
- [ ] Parameter smoothing
- [ ] Performance optimizations
- [ ] Unit tests
- [ ] Windows support

### v2.0 (Major Features)
- [ ] Probability masks
- [ ] Per-grain randomization
- [ ] Preset system
- [ ] Advanced visualization

---

## Contributing

If others want to contribute:

1. Check this TODO list for open items
2. Create issue on GitHub to discuss implementation
3. Fork repository
4. Implement feature with tests
5. Submit pull request
6. Update documentation

---

## Notes

- Prioritize user-facing features over internal optimizations
- Maintain backward compatibility with v1.0 patches
- Document all breaking changes clearly
- Keep implementation simple and maintainable
- Performance optimizations should be data-driven (profile first!)

---

**Last Updated**: 2025-11-21 (Phase 13 completion)
**Next Review**: After Phase 11 (help file creation)
