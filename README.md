# ec2~ - Granular Synthesis for Max/MSP

**⚠️ ALPHA VERSION - UNDER ACTIVE TESTING ⚠️**

High-performance multichannel granular synthesis external for Max/MSP, implementing Curtis Roads's granular synthesis principles with advanced spatial allocation, LFO modulation, and real-time parameter control.

---

## Status

**Version**: 1.0.0-alpha
**Platform**: macOS (Universal Binary: Apple Silicon + Intel)
**Max Version**: 8.0+
**License**: GPL-3.0

This is an **ALPHA RELEASE** currently undergoing comprehensive testing. While the core engine is functional, please report any issues you encounter.

---

## Features

- **2048-voice grain pool** for dense textures
- **Up to 16 output channels** with flexible multichannel routing
- **7 spatial allocation modes** (Fixed, Round-robin, Random, Weighted, Load-balance, Pitch-map, Trajectory)
- **6 independent LFOs** with modulation routing to 14 parameters
- **Statistical deviation** for all synthesis parameters (Curtis Roads: stochastic grain clouds)
- **OSC integration** compatible with odot for Max
- **Native Max integration** with buffer~ and buffer_ref monitoring
- **Multichannel cable support** (@mc mode)

---

## Installation

###For precompiled binary for Apple Silicon (M1/M2/M3) Macs or Intel will be avaliable in the releases page

### Build from Source

#### Prerequisites

1. **Max/MSP 8.0 or later**
2. **Xcode Command Line Tools**
   ```bash
   xcode-select --install
   ```
3. **CMake 3.19 or later**
   ```bash
   brew install cmake
   ```

#### Build Steps

```bash
# Clone repository
git clone https://github.com/yourusername/max-emission-control.git
cd max-emission-control

# Initialize submodules
git submodule update --init --recursive

# Build
mkdir build && cd build
cmake .. && cmake --build . --config Release

# Install to Max externals folder
cp -r ../externals/ec2~.mxo ~/Documents/Max\ 9/Library/
```

**macOS Security Note**: Remove quarantine attribute if needed:
```bash
xattr -cr ~/Documents/Max\ 9/Library/ec2~.mxo
```

---

## Quick Start

```
[buffer~ mysound]
|
[ec2~ mysound @grainrate 20 @duration 100 @amplitude 0.5 @outputs 2]
|             |
[dac~ 1 2]   [comment: Audio output]
```

Send parameter changes as messages:
- `grainrate 30` - Set grain emission rate (Hz)
- `duration 150` - Set grain duration (ms)
- `amplitude 0.7` - Set output amplitude (0-1)
- `pan -0.5` - Set stereo pan position (-1 to 1)
- `scanstart 0.2` - Set buffer scan start position (0-1)

Double-click the `ec2~` object to open the buffer~ editor.

---

## Core Parameters

### Synthesis
- **grainrate** (Hz): Grain emission rate (0.1-500, default: 20)
- **duration** (ms): Grain length (1-1000, default: 100)
- **amplitude**: Output level (0-1, default: 0.5)
- **playback**: Playback rate/transposition (-32 to 32, default: 1)
- **envelope**: Envelope shape (0-1, Hann to Exp, default: 0.5)
- **streams**: Polyphonic grain streams (1-20, default: 1)
- **async**: Stream randomization (0-1, default: 0)
- **intermittency**: Grain skipping probability (0-1, default: 0)

### Scanning
- **scanstart**: Buffer scan position (0-1, default: 0)
- **scanrange**: Scan window size (0-1, default: 1)
- **scanspeed**: Automatic scanning speed (-32 to 32, default: 0)

### Filtering
- **filterfreq** (Hz): Lowpass filter frequency (20-22000, default: 22000)
- **resonance**: Filter resonance (0-1, default: 0)

### Spatial
- **pan**: Stereo pan position (-1 to 1, default: 0)
- **outputs**: Number of output channels (2-16, default: 2)

###Allocation Modes
- **allocmode**: Spatial allocation strategy (0-6, default: 1)
  - 0: Fixed channel
  - 1: Round-robin
  - 2: Random
  - 3: Weighted random
  - 4: Load-balanced
  - 5: Pitch-mapped
  - 6: Trajectory-based

### Deviation Parameters (Stochastic Variation)
Add `_dev` suffix to any parameter for statistical deviation:
- **grainrate_dev**, **duration_dev**, **playback_dev**, **amplitude_dev**, etc.
- Range: 0-1 (0 = no variation, 1 = maximum variation)

### LFO System
6 independent LFOs with parameters:
- **lfo[1-6]shape**: Waveform (0-5: Sine, Triangle, Square, Saw Up, Saw Down, Random)
- **lfo[1-6]rate** (Hz): LFO frequency (0.001-100)
- **lfo[1-6]polarity**: Bipolar/Unipolar (0-1)
- **lfo[1-6]duty**: Pulse width for square wave (0-1)

---

## Multichannel Output

### Separated Mode (Default)
```
[ec2~ @outputs 4]
|    |    |    |
ch1  ch2  ch3  ch4
```

### MC Mode (Multichannel Cable)
```
[ec2~ @outputs 8 @mc 1]
|
[mc.unpack~ 8]
```

---

## Project Structure

```
max-emission-control/
├── externals/              # Compiled binaries
│   └── ec2~.mxo
├── source/ec2_tilde/       # Source code
│   ├── ec2_tilde.cpp       # Max SDK wrapper
│   ├── ec2_engine.*        # Granular engine
│   ├── ec2_grain.*         # Grain voice implementation
│   ├── ec2_scheduler.*     # Grain scheduling
│   ├── ec2_envelope.*      # Envelope generators
│   ├── ec2_lfo.*           # LFO oscillators
│   ├── ec2_spatial_allocator.* # Multichannel routing
│   └── ec2_voice_pool.*    # Voice management
├── build/                  # Build artifacts (git ignored)
└── README.md
```

---

## Known Issues & Testing

This is an ALPHA release. Known areas under testing:

- [ ] Long-term stability with continuous grain generation
- [ ] Buffer change notifications in various Max scenarios
- [ ] OSC message parsing edge cases
- [ ] Multichannel cable (MC) mode with >8 channels
- [ ] LFO modulation depth calibration
- [ ] Filter stability at high resonance
- [ ] Signal-rate input implementation (planned)

**Please report issues at**: [GitHub Issues](https://github.com/yourusername/max-emission-control/issues)

---

## Technical Details

### Architecture
- Pure Max SDK implementation (C++17)
- 2048-voice grain pool with dynamic allocation
- Voice count compensation using 1/e law
- Constant-power stereo panning
- Sample-accurate grain scheduling
- Hermite interpolation for pitch shifting

### Performance
- CPU: 5-50% depending on grain density (tested on M1)
- Memory: ~4 MB + buffer sizes
- Latency: Max's I/O vector size
- Max grain rate: 500 Hz (limited for stability)

---

## Credits

### Original EmissionControl2
- **Curtis Roads** - Concept and granular synthesis theory
- **Greg Surges** - Original implementation
- **Rodney DuPlessis** - Development
- **Karl Yerkes** - Spatial audio

### Max/MSP Port (ec2~)
- **Alessandro Anatrini** - Max/MSP porting, spatial audio engine, multichannel allocation system, and grain scheduling implementation

### Theoretical Foundation
- Curtis Roads - *Microsound* (MIT Press, 2001)

---

## License

**GPL-3.0** - This project is a derivative work of EmissionControl2

Copyright © 2025 Alessandro Anatrini

---

## References

- **EmissionControl2**: https://github.com/EmissionControl2/EmissionControl2
- **Curtis Roads - Microsound**: https://mitpress.mit.edu/books/microsound
- **Max/MSP**: https://cycling74.com
- **GPL-3.0 License**: https://www.gnu.org/licenses/gpl-3.0.en.html

---

**Last Updated**: December 2025
