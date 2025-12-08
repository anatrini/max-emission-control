# ec2~ TODO & Future Features

## Priority 1: Critical for Beta Release

### Testing & Stability
- [ ] Comprehensive testing with long-running patches (8+ hours)
- [ ] Test buffer~ change notifications in various scenarios
- [ ] Verify all 52 parameters respond correctly to messages
- [ ] Test all 7 spatial allocation modes with different channel counts
- [ ] Stress test with maximum grain density (500 Hz, 20 streams)
- [ ] Memory leak testing with buffer~ switching
- [ ] Test with very large buffers (>60 seconds)
- [ ] Validate OSC FullPacket parsing with edge cases

### Documentation
- [ ] Create comprehensive Max help file (ec2~.maxhelp)
- [ ] Add interactive examples for each spatial allocation mode
- [ ] Document LFO modulation routing
- [ ] Create tutorial patches for common use cases
- [ ] Add performance benchmarks and optimization tips

### Bug Fixes
- [ ] Fix unused 'envVal' warning in grain processing
- [ ] Verify filter stability at high resonance values
- [ ] Test MC mode with >8 channels
- [ ] Validate all deviation parameters work correctly

---

## Priority 2: Enhanced Functionality

### Signal-Rate Inputs (Planned)
- [ ] Implement proper signal connection detection using count array
- [ ] Add signal-rate modulation for:
  - Scan position (inlet 0 - already wired but disabled)
  - Grain rate (inlet 1 - already wired but disabled)
  - Playback rate (inlet 2 - already wired but disabled)
- [ ] Test latency and accuracy of signal-rate control
- [ ] Document signal-rate vs. parameter-rate control differences

### Advanced Features
- [ ] Polybuffer~ support for multi-buffer granulation
- [ ] Grain windowing functions beyond Hann/Exponential
- [ ] Spectral filtering (bandpass, highpass, notch)
- [ ] Grain delay/feedback network
- [ ] MIDI note control for pitch mapping
- [ ] Preset management system

### Spatial Audio
- [ ] Add more trajectory shapes (spiral, random walk, Lissajous)
- [ ] Implement distance-based amplitude scaling
- [ ] Add Doppler effect for moving grains
- [ ] Support for higher-order ambisonics (HOA)
- [ ] Integration with spat5 for spatial rendering

---

## Priority 3: Optimization & Polish

### Performance
- [ ] Profile CPU usage across different Max vector sizes
- [ ] Optimize grain scheduling algorithm
- [ ] Implement SIMD vectorization for grain mixing
- [ ] Add multi-threading for >8 channels
- [ ] Reduce memory allocations in audio callback
- [ ] Optimize filter cascades

### User Experience
- [ ] Add visual feedback for active grain count
- [ ] Create waveform display with grain position markers
- [ ] Add parameter randomization functions
- [ ] Implement parameter smoothing for click-free changes
- [ ] Add "panic" button to stop all grains instantly
- [ ] Preset interpolation/morphing

### Platform Support
- [ ] Windows build support
- [ ] Test on Intel Macs
- [ ] Optimize for different CPU architectures
- [ ] Test with Max 8.0-8.6 versions
- [ ] Verify compatibility with Max for Live

---

## Priority 4: Advanced Features (Research)

### Grain Sources
- [ ] Live audio input granulation (real-time buffer recording)
- [ ] Multi-buffer crossfading
- [ ] Granular resynthesis from analysis data
- [ ] Concatenative synthesis (corpus-based)

### Synthesis Extensions
- [ ] Formant-preserving pitch shifting
- [ ] Grain-level effects (distortion, modulation)
- [ ] Granular FM synthesis
- [ ] Pulsar synthesis mode
- [ ] Microsound sequencing

### AI/ML Integration
- [ ] Parameter mapping via machine learning
- [ ] Intelligent spatial allocation based on spectral content
- [ ] Gesture-based control mapping
- [ ] Automatic grain cloud generation from descriptors

---

## Quality of Life Improvements

### Developer Tools
- [ ] Add comprehensive unit tests
- [ ] Create automated integration tests
- [ ] Set up continuous integration (CI)
- [ ] Add code coverage reporting
- [ ] Implement automated benchmarking

### Documentation
- [ ] Video tutorials
- [ ] Interactive parameter explorer
- [ ] Comparison guide: ec2~ vs. other granulators
- [ ] Best practices guide
- [ ] Troubleshooting flowchart

### Community
- [ ] Create example patch library
- [ ] Set up discussion forum
- [ ] Establish contribution guidelines
- [ ] Create developer documentation for extending ec2~

---

## Known Limitations (Not Planned)

These features from the original EC2 are intentionally excluded as they can be achieved more effectively using Max objects:

- ❌ Built-in morphing (use Max interpolation objects)
- ❌ Graphical UI controls (use Max UI objects)
- ❌ Built-in recording (use buffer~ recording)
- ❌ File I/O (use Max file management)
- ❌ Preset storage (use pattr system)

---

## Completed Features ✓

- ✅ Core granular synthesis engine
- ✅ 2048-voice grain pool
- ✅ All 52 parameters from original EC2
- ✅ 6 LFO system with modulation routing
- ✅ 14 deviation parameters (stochastic variation)
- ✅ 7 spatial allocation modes
- ✅ Multichannel output (2-16 channels)
- ✅ MC mode (multichannel cable)
- ✅ Buffer~ integration with change notification
- ✅ OSC FullPacket support
- ✅ Double-click to open buffer editor
- ✅ Universal binary (Apple Silicon + Intel)
- ✅ Pure Max SDK implementation (no dependencies)

---

## Notes

### Implementation Priority
Focus areas for immediate development:
1. Comprehensive testing and bug fixes
2. Documentation and help file
3. Signal-rate input implementation
4. Performance optimization

### Testing Priorities
Critical test scenarios:
1. Long-running stability (8+ hours continuous operation)
2. Buffer switching without crashes
3. Parameter changes during high grain density
4. All spatial modes with different channel configurations
5. OSC message flood handling
6. Memory leak detection

### Performance Targets
- < 10% CPU at 100 grains/sec (M1 Mac, 512 samples vector size)
- < 20% CPU at 500 grains/sec
- No audio dropouts with 1000 active voices
- < 1ms added latency for parameter changes

---

**Last Updated**: December 2025
**Current Version**: 1.0.0-alpha
