# ec2~

ec2~ is a multichannel granular synthesis external for Max, based on the concepts from Curtis Roads's *Microsound* and the original EmissionControl2 project. It runs a pool of up to 2048 simultaneous grain voices with flexible spatial routing across up to 16 output channels, six independent LFOs, per-parameter stochastic deviation, and full OSC control.

**Version**: 1.0.5-alpha — macOS only (Universal Binary: Apple Silicon + Intel), Max 8.0+

---

## Installation

### Precompiled binary

Download `ec2~-1.0.5-alpha-macos.zip` from the [Releases](https://github.com/anatrini/max-emission-control/releases/latest) page, unzip it, and copy `ec2~.mxo` to your Max library folder:

```bash
cp -r ec2~.mxo ~/Documents/Max\ 9/Library/
```

If macOS blocks the file on first load, remove the quarantine attribute:

```bash
xattr -cr ~/Documents/Max\ 9/Library/ec2~.mxo
```

### Build from source

You need Xcode Command Line Tools, CMake 3.19+, and the Max SDK installed via Cycling '74's Package Manager (standard location: `~/Documents/Max 9/Packages/max-sdk`).

```bash
git clone https://github.com/anatrini/max-emission-control.git
cd max-emission-control

git submodule update --init --recursive

# Symlink the SDK into the project root
ln -s ~/Documents/Max\ 9/Packages/max-sdk max-sdk

mkdir build && cd build
cmake .. && cmake --build . --config Release

cp -r ../externals/ec2~.mxo ~/Documents/Max\ 9/Library/
```

---

## Getting started

There is no dedicated help patch yet. For a complete parameter reference, open `docs/EC2_HELP_REFERENCE.md`.

The `patchers/` folder contains two files:

- **`ec2_testpatch.maxpat`** — a ready-to-use patch for testing the external. It requires the [odot](https://github.com/CNMAT/CNMAT-odot) library for Max to be installed, since ec2~ uses OSC bundles for parameter communication.
- **`ec2_GUI.maxpat`** — the graphical control interface that opens when you double-click the ec2~ object. This file must be in Max's search path, otherwise the GUI will not open. Add the `patchers/` folder to your Max file preferences.

---

## Parameters

All parameters are sent as OSC messages to the left inlet: `/parametername value`.

### Synthesis

| Parameter | Range | Default | Description |
|-----------|-------|---------|-------------|
| `/grainrate` | 0.1–500 Hz | 20 | Grain emission rate |
| `/duration` | 0.046–10000 ms | 100 | Grain length |
| `/amp` | −180–48 dBFS | −6 | Output amplitude |
| `/playback` | −32–32 | 1 | Playback rate / transposition |
| `/envelope` | 0–1 | 0.5 | Envelope shape (0=Tukey, 1=Expodec) |
| `/streams` | 1–20 | 1 | Number of simultaneous grain streams |
| `/async` | 0–1 | 0 | Timing jitter |
| `/intermittency` | 0–1 | 0 | Grain dropout probability |

### Scanning

| Parameter | Range | Default | Description |
|-----------|-------|---------|-------------|
| `/scanstart` | 0–1 | 0 | Read position in the buffer |
| `/scanrange` | −1–1 | 0.5 | Scan window size (negative = reverse) |
| `/scanspeed` | −32–32 | 1 | Automatic scan speed |

### Filter

| Parameter | Range | Default | Description |
|-----------|-------|---------|-------------|
| `/filterfreq` | 20–24000 Hz | 1000 | Bandpass center frequency |
| `/resonance` | 0–1 | 0 | Resonance / cascade mix (0 = bypassed) |

### Spatial

| Parameter | Range | Default | Description |
|-----------|-------|---------|-------------|
| `/pan` | −1–1 | 0 | Stereo pan position |
| `@outputs` | 1–16 | 2 | Number of output channels (set at instantiation) |
| `@allocmode` | 0–7 | 1 | Spatial allocation mode (see below) |

**Allocation modes:**

| Value | Name | Behaviour |
|-------|------|-----------|
| 0 | Fixed | All grains to a single channel (`/fixedchan`) |
| 1 | Round-robin | Grains cycle through channels in order |
| 2 | Random | Uniform random channel selection |
| 3 | Weighted random | Random with per-channel probability weights |
| 4 | Load-balanced | Grains routed to the least-busy channel |
| 5 | Pitch-map | Low pitch → first channel, high pitch → last channel |
| 6 | Trajectory | Grains follow an automated spatial path over time |
| 7 | Distance | Spectral centroid mapped to virtual listener distance |

### Stochastic deviation

Any parameter can have per-grain random variation by appending `_dev`:

```
/grainrate_dev 5       → each grain's rate varies ± 5 Hz
/duration_dev 20       → each grain's duration varies ± 20 ms
/playback_dev 0.1      → etc.
```

### LFOs

Six independent LFOs can modulate any parameter:

```
/lfo1rate 0.5          → LFO 1 frequency in Hz
/lfo1shape 0           → 0=Sine, 1=Square, 2=Rise, 3=Fall, 4=Noise
/lfo1polarity 0        → 0=bipolar, 1=unipolar+, 2=unipolar−
/lfo1_to_grainrate 0.3 → route LFO 1 to grainrate at depth 0.3
```

---

## Multichannel output

Default mode gives one outlet per channel:

```
[ec2~ @outputs 4]
|    |    |    |
ch1  ch2  ch3  ch4
```

With `@mc 1`, all channels are packed into a single multichannel cable:

```
[ec2~ @outputs 8 @mc 1]
|
[mc.unpack~ 8]
```

---

## Credits

ec2~ is a Max port of [EmissionControl2](https://github.com/EmissionControl2/EmissionControl2), originally developed by Greg Surges, Rodney DuPlessis, and Karl Yerkes, based on Curtis Roads's granular synthesis theory.

Max port, spatial audio engine, multichannel allocation, and OSC integration by Alessandro Anatrini.

---

## License

GPL-3.0 — derivative work of EmissionControl2

Copyright © 2026 Alessandro Anatrini
