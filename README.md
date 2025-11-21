# ec2~ - Granular Synthesis for Max/MSP

**High-performance multichannel granular synthesis external for Max/MSP**

ec2~ is a port of [EmissionControl2](https://github.com/EmissionControl2/EmissionControl2) to Max/MSP, implementing Curtis Roads's granular synthesis principles with advanced spatial allocation, LFO modulation, and signal-rate control.

---

## Features

- **2048-voice grain pool** for dense textures
- **16 output channels** with flexible multichannel routing
- **7 spatial allocation modes** (Fixed, Round-robin, Random, Weighted, Load-balance, Pitch-map, Trajectory)
- **6 independent LFOs** with modulation routing to 14 parameters
- **Signal-rate inputs** for CV-style control (scan position, grain rate, playback rate)
- **OSC integration** compatible with odot and spat5
- **Native Max integration** with buffer~ and polybuffer~

---

## Installation

### Option 1: Use Precompiled Binary (Recommended)

**For Apple Silicon (M1/M2/M3) Macs:**

The precompiled binary is included in the `externals/` folder of this repository.

1. **From repository**:
   ```bash
   cp -r externals/ec2~.mxo ~/Documents/Max\ 9/Library/
   ```

2. **Or download** from the [Releases](https://github.com/yourusername/max-emission-control/releases) page

**Note**: macOS may block the external on first run (unsigned binary). To allow:
```bash
xattr -cr ~/Documents/Max\ 9/Library/ec2~.mxo
```

### Option 2: Build from Source

See **Building** section below.

---

## Quick Start

```
[loadbang]
|
[read mysound]
|
[ec2~ @grainrate 30 @duration 100 @outputs 2]
|            |
[dac~ 1 2]
```

Double-click the `ec2~` object to view the loaded buffer waveform.

For comprehensive documentation, see the `ec2~.maxhelp` file (coming soon).

---

## Building

### Prerequisites

**macOS only** (Windows support planned)

1. **Max/MSP 8.0 or later**
   - Download from [cycling74.com](https://cycling74.com)

2. **Xcode Command Line Tools**
   ```bash
   xcode-select --install
   ```

3. **CMake 3.19 or later**
   ```bash
   # Using Homebrew
   brew install cmake

   # Or download from cmake.org
   ```

4. **Min-DevKit** (included as submodule)
   - The build process uses Cycling '74's min-devkit framework

### Build Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/max-emission-control.git
   cd max-emission-control
   ```

2. **Initialize submodules**
   ```bash
   git submodule update --init --recursive
   ```

3. **Create build directory**
   ```bash
   mkdir build
   cd build
   ```

4. **Configure with CMake**
   ```bash
   cmake ..
   ```

   CMake will automatically locate your Max installation.

5. **Build the external**
   ```bash
   cmake --build . --config Release
   ```

   **Note for M1/M2/M3 Macs**: The build creates a universal binary. Extract arm64 only:
   ```bash
   cd /path/to/max-emission-control
   cp -r ~/Documents/dev/externals/ec2~.mxo externals/
   lipo externals/ec2~.mxo/Contents/MacOS/ec2~ -thin arm64 -output externals/ec2~.mxo/Contents/MacOS/ec2~
   xattr -cr externals/ec2~.mxo
   ```

6. **Locate the built external**

   The compiled `ec2~.mxo` will be in:
   ```
   externals/ec2~.mxo
   ```

### Installation After Building

Copy `ec2~.mxo` to your Max externals folder:
```bash
cp -r externals/ec2~.mxo ~/Documents/Max\ 9/Library/
```

---

## Verification

Test the external in Max:

1. Create a new patcher
2. Type `n` and create an `ec2~` object
3. The object should appear without errors
4. Load a buffer and start granulating:

```
[read mysound(
|
[ec2~]
|   |
[dac~ 1 2]
```

---

## Documentation

- **`docs/EC2_HELP_REFERENCE.md`** - Complete parameter reference
- **`docs/PORTING_STRATEGY.md`** - Development history and phases
- **`docs/IMPLEMENTATION_SUMMARY.md`** - Technical overview
- **`ec2~.maxhelp`** - Interactive help file (coming soon)

---

## Project Structure

```
max-emission-control/
├── externals/              # Precompiled binaries
│   └── ec2~.mxo            # M1/M2/M3 binary (arm64)
├── source/
│   └── ec2_tilde/          # External source code
│       ├── ec2_tilde.cpp   # Min-devkit wrapper
│       ├── ec2_engine.*    # Synthesis engine
│       ├── ec2_grain.*     # Grain voice
│       └── ...             # Other components
├── docs/                   # Documentation
├── build/                  # Build artifacts (gitignored)
├── third_party/
│   └── EmissionControl2/   # Original EC2 (submodule)
└── CMakeLists.txt          # Build configuration
```

---

## Troubleshooting

### "ec2~: No such object"
- External not in Max's search path
- Copy `ec2~.mxo` to `~/Documents/Max 8/Library/`

### "Damaged or incomplete" (macOS Gatekeeper)
```bash
xattr -cr /path/to/ec2~.mxo
```

### Build fails: "Min-DevKit not found"
```bash
git submodule update --init --recursive
```

### Build fails: "Max SDK not found"
- Ensure Max is installed in `/Applications/Max.app`
- Or set `C74_MAX_API_DIR` environment variable

### Audio dropouts with high grain counts
- Increase Max's I/O vector size (Options → Audio Status)
- Reduce grain rate or duration
- Lower number of output channels

---

## System Requirements

### Minimum
- macOS 10.13 (High Sierra) or later
- Max/MSP 8.0 or later
- 4 GB RAM
- Dual-core processor

### Recommended
- macOS 11 (Big Sur) or later
- Max/MSP 8.5 or later
- 8 GB RAM
- Apple Silicon (M1/M2/M3) or Intel quad-core

### Performance
- Typical CPU usage: 5-50% depending on grain count (100-1000 grains)
- Memory: ~4 MB base + loaded buffers

---

## Development Status

**Current Version**: 1.0-beta

### Completed
- ✅ Core granular synthesis engine
- ✅ Spatial allocation system
- ✅ Buffer management
- ✅ Multichannel cable support
- ✅ Complete parameter system
- ✅ LFO modulation
- ✅ OSC integration
- ✅ Signal-rate inputs
- ✅ Waveform display

### In Progress
- 📋 Interactive help file and examples

### Planned
See `docs/FUTURE_TODO.md` for roadmap

---

## Contributing

Contributions are welcome! Please:

1. Check `docs/FUTURE_TODO.md` for planned features
2. Open an issue to discuss major changes
3. Follow existing code style
4. Include tests where applicable
5. Update documentation

---

## Credits

### Original EmissionControl2
- **Curtis Roads** - Concept and design
- **Greg Surges** - Implementation
- **Rodney DuPlessis** - Development
- **Karl Yerkes** - Spatial audio

### Max/MSP Port (ec2~)
- **Alessandro Anatrini** - Max porting and grain multichannel allocation logic 

### Theoretical Foundation
- Curtis Roads - *Microsound* (MIT Press, 2001)

### Tools
- Cycling '74 Min-DevKit
- Gamma DSP Library (filters)
- CMake build system

---

## License

**GPL-3.0** - See LICENSE file for details

This project is a derivative work of EmissionControl2, licensed under GPL-3.0.

---

## References

- **Original EmissionControl2**: https://github.com/EmissionControl2/EmissionControl2
- **Curtis Roads - Microsound**: https://mitpress.mit.edu/books/microsound
- **Max/MSP**: https://cycling74.com
- **Min-DevKit**: https://github.com/Cycling74/min-devkit

---

## Support

- **Issues**: [GitHub Issues](https://github.com/yourusername/max-emission-control/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/max-emission-control/discussions)
- **Documentation**: See `docs/` folder

---

## Acknowledgments

Special thanks to:
- Cycling '74 for Max/MSP and Min-DevKit
- Curtis Roads for pioneering granular synthesis research
- The EmissionControl2 development team

---

**Status**: Production-ready
**Platform**: macOS (Apple Silicon + Intel)
**Max Version**: 9.0+
**Last Updated**: 2025-11-21
