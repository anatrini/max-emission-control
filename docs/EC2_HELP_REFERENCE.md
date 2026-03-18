# ec2~ Reference

Multichannel granular synthesis external for Max/MSP. Port of EmissionControl2 with up to 16 output channels and 8 spatial allocation modes.

## Overview

ec2~ generates grain clouds from a `buffer~`, distributing grains across multiple output channels according to configurable allocation strategies. Each grain is an independent audio fragment with controllable duration, pitch, amplitude, filtering, and spatial position. Randomization via deviation parameters creates stochastic textures (cf. Roads, *Microsound*).

```
ec2~ @buffer mybuffer @outputs 8 @allocmode 2 @mc 1
```

Parameters accept OSC-style messages (`/param value`) or FullPacket bundles. A native parameter window is accessible by double-clicking the object.

---

## Inlets

| Inlet | Type | Description |
|-------|------|-------------|
| 0 | messages | OSC messages, FullPacket bundles, attributes |
| 1 | signal | Scan position (0–1), overrides `/scanstart` automation |
| 2 | signal | Grain rate (Hz), overrides `/grainrate` |
| 3 | signal | Playback rate, overrides `/playback` |

Signal inlets take effect only when a signal cable is connected. When disconnected, the corresponding message parameter is used.

---

## Outlets

**Standard mode (`@mc 0`):**
- Outlets 0 to N−1: Audio signals (one per channel)
- Outlet N (rightmost): OSC FullPacket with grain visualization data

**Multichannel mode (`@mc 1`):**
- Outlet 0: MC audio signal (all channels in one cable)
- Outlet 1: OSC FullPacket with grain visualization data

### OSC Visualization Output

The rightmost outlet sends an OSC FullPacket every audio vector containing:

```
/grain_count <int>                    Number of active grains
/grain_start <float>                  Scan region start (0–1)
/grain_end   <float>                  Scan region end (0–1)
/scan_position <float>                Current scanner playhead position (0–1)
/grain_positions <p1> <p2> ... <pN>   Fixed-size list of grain positions
/grain_min_pos <float>                Minimum position of active grains (0–1)
/grain_max_pos <float>                Maximum position of active grains (0–1)
```

**`/grain_positions` format:**
- Fixed-size list with exactly `@max_count` elements
- `0.0` – `1.0`: active grain at that normalized buffer position
- `-1`: empty slot (no grain active)

Example with `@max_count 4` and 2 active grains:
```
/grain_positions 0.25 0.67 -1 -1
```

**Typical `waveform~` usage:**
- `grain_start` / `grain_end` → display scan selection region
- `scan_position` → display scanner playhead
- `grain_positions` → feed `multislider` for per-grain visualization
- `grain_min_pos` / `grain_max_pos` → display actual read range

---

## Double-Click

Opens a native parameter window showing all parameters with real-time sliders and readouts.

---

## Attributes

Structural attributes. Set at creation time or via message (without `/` prefix).

> **Note:** `@outputs` and `@mc` require object recreation to take effect.

| Attribute | Type | Range | Default | Description |
|-----------|------|-------|---------|-------------|
| `@buffer` | symbol | — | `""` | Source `buffer~` name |
| `@outputs` | int | 1–16 | 2 | Number of output channels |
| `@mc` | int | 0–1 | 0 | 0 = separate outlets, 1 = MC cable |
| `@allocmode` | int | 0–7 | 1 | Spatial allocation mode (see below) |
| `@soundfile` | int | 0–15 | 0 | Buffer index for `polybuffer~` |
| `@max_count` | int | 1–2048 | 32 | Fixed size of `/grain_positions` list |

---

## Spatial Allocation Modes

Controls how grains are distributed across output channels.

### Mode 0: Fixed

All grains route to a single channel. Use for mono output or when external spatialization handles routing.

| Parameter | Type | Range | Default | Description |
|-----------|------|-------|---------|-------------|
| `/fixedchan` | int | 1–16 | 1 | Target output channel (1-indexed) |

---

### Mode 1: Round-Robin

Grains cycle sequentially through channels. Produces predictable spatial movement useful for rhythmic patterns or uniform distribution.

| Parameter | Type | Range | Default | Description |
|-----------|------|-------|---------|-------------|
| `/rrstep` | int | 1–16 | 1 | Channel step between successive grains |

Example: 8 outputs, `/rrstep 3` → channels follow: 1→4→7→2→5→8→3→6→1…

---

### Mode 2: Random

Grains assigned to uniformly random channels. Creates diffuse, decorrelated spatial textures.

| Parameter | Type | Range | Default | Description |
|-----------|------|-------|---------|-------------|
| `/randspread` | float | 0–1 | 0 | Panning between adjacent channels (0=hard, 1=full crossfade) |
| `/spatialcorr` | float | 0–1 | 0 | Correlation between successive positions (0=independent, 1=smooth drift) |

Higher `/spatialcorr` values create coherent spatial movement; lower values produce scattered, pointillistic textures.

---

### Mode 3: Weighted

Grains assigned randomly according to per-channel probability weights. Creates biased distributions for asymmetric spatial focus.

| Parameter | Type | Range | Default | Description |
|-----------|------|-------|---------|-------------|
| `/randspread_weighted` | float | 0–1 | 0 | Panning between adjacent channels |
| `/spatialcorr_weighted` | float | 0–1 | 0 | Correlation between successive positions |
| `/weights` | list | floats ≥ 0 | uniform | Per-channel weights (auto-normalized) |

Example: `/weights 0.5 0.3 0.1 0.1` → 50% of grains to channel 1, 30% to channel 2, etc.

---

### Mode 4: Load-Balance

**No parameters required.** Assigns each new grain to the channel with the fewest currently active grains. Ensures even polyphony distribution across the output array.

- Ties are resolved randomly
- Particularly useful at high grain densities with many output channels

---

### Mode 5: Pitch-Map

Maps grain pitch (derived from the `/playback` rate and filter frequency) to spatial position. Low pitches route toward lower-numbered channels, high pitches toward higher-numbered channels (logarithmic mapping). Creates spectral–spatial correlation.

| Parameter | Type | Range | Default | Description |
|-----------|------|-------|---------|-------------|
| `/pitchmin` | float | 20–20000 Hz | 20 | Pitch value mapped to first channel |
| `/pitchmax` | float | 20–20000 Hz | 20000 | Pitch value mapped to last channel |

---

### Mode 6: Trajectory

Grains follow a time-based spatial trajectory across the channel array. Creates automated spatial movement patterns synchronized to absolute emission time.

| Parameter | Type | Range | Default | Description |
|-----------|------|-------|---------|-------------|
| `/trajshape` | int | 0–5 | 0 | Trajectory waveform (see below) |
| `/trajrate` | float | 0.001–100 Hz | 0.5 | Movement speed |
| `/trajdepth` | float | 0–1 | 1 | Amplitude (proportion of channel array covered) |
| `/spiral_factor` | float | 0–1 | 0 | Spiral tightness — shape 4 only (0=circle, 1=tight spiral) |
| `/pendulum_decay` | float | 0–1 | 0.1 | Damping — shape 5 only (0=no decay, 1=heavy damping) |

Trajectory shapes:

| Value | Name | Behaviour |
|-------|------|-----------|
| 0 | Sine | Smooth sinusoidal oscillation |
| 1 | Saw | Linear sweep from start to end, then instant reset |
| 2 | Triangle | Linear back-and-forth |
| 3 | Random walk | Constrained random step movement |
| 4 | Spiral | Circular motion with expanding/contracting radius |
| 5 | Pendulum | Exponentially damped oscillation |

---

### Mode 7: Distance

Maps each grain's spectral centroid (set via `/filterfreq`) to a virtual distance from a fixed listener position. Closer grains (high spectral content) are louder; farther grains (low spectral content) are attenuated by an inverse power-law. Channel assignment cycles round-robin through the active channel list.

Reuses pitch-map parameters for the spectral–distance mapping and the distance model parameters from the engine.

| Parameter | Type | Range | Default | Description |
|-----------|------|-------|---------|-------------|
| `/pitchmin` | float | 20–20000 Hz | 20 | Spectral centroid mapped to far distance |
| `/pitchmax` | float | 20–20000 Hz | 20000 | Spectral centroid mapped to near distance |

Distance model is controlled internally via engine defaults: attenuation exponent = 2.0 (inverse square law), near clip = 1.0, far clip = 100.0.

> **Practical note:** Use `/filterfreq` to control perceived distance. Low `/filterfreq` values (< 500 Hz) place grains far away (quiet); high values (> 5000 Hz) bring them close (loud).

---

## Synthesis Parameters

### Grain Scheduling

| Parameter | Type | Range | Default | Description |
|-----------|------|-------|---------|-------------|
| `/grainrate` | float | 0.1–500 Hz | 20 | Grain emission rate |
| `/async` | float | 0–1 | 0 | Timing jitter (0=synchronous, 1=maximum random offset) |
| `/intermittency` | float | 0–1 | 0 | Probability of grain dropout (0=none, 1=all dropped) |
| `/streams` | int | 1–20 | 1 | Number of parallel synchronous grain streams (multiplies effective rate) |

> `/streams N` multiplies the effective grain rate by N. All N streams share the same scan position and parameters; each grain receives a unique stream ID (0–N−1) used by spatial allocation.

---

### Grain Characteristics

| Parameter | Type | Range | Default | Description |
|-----------|------|-------|---------|-------------|
| `/playback` | float | −32 to 32 | 1 | Playback rate (1=normal, −1=reverse, 0=freeze) |
| `/duration` | float | 0.046–10000 ms | 100 | Grain duration |
| `/envelope` | float | 0–1 | 0.5 | Envelope shape (0=Tukey/cosine-bell, 1=Expodec) |
| `/amp` | float | −180 to 48 dB | −6 | Output amplitude in dBFS |

---

### Filter

A 3-stage cascaded bandpass filter (BPF → resonant BPF → BPF). Active only when `/resonance` > 0.

| Parameter | Type | Range | Default | Description |
|-----------|------|-------|---------|-------------|
| `/filterfreq` | float | 20–24000 Hz | 1000 | Bandpass center frequency |
| `/resonance` | float | 0–1 | 0 | Filter resonance / cascade mix (0=bypass, 1=maximum) |

At resonance = 0 the filter is bypassed entirely (zero CPU cost). Filter coefficients are cached per grain: if `/filterfreq` and `/resonance` are unchanged between successive grains, coefficient recomputation is skipped.

---

### Spatial / Scan

| Parameter | Type | Range | Default | Description |
|-----------|------|-------|---------|-------------|
| `/pan` | float | −1 to 1 | 0 | Stereo pan position (legacy stereo mode only) |
| `/scanstart` | float | 0–1 | 0 | Scanner start position in buffer (normalized) |
| `/scanrange` | float | −1 to 1 | 0.5 | Scan window size (negative = reverse direction) |
| `/scanspeed` | float | −32 to 32 | 1 | Automatic scan speed (1=real-time, 2=double speed) |

The scanner moves continuously from `scanstart` across `scanrange` at `scanspeed`. When inlet 1 carries a signal, scan position is overridden sample-by-sample.

---

### Sound File Selection

| Parameter | Type | Range | Default | Description |
|-----------|------|-------|---------|-------------|
| `/soundfile` | int | 0–15 | 0 | Active buffer index for `polybuffer~` sources |

---

## Deviation Parameters

Per-grain uniform random deviation (±) applied independently to each emitted grain. Creates stochastic variation characteristic of granular clouds (Roads, *Microsound* §3).

Setting a deviation to 0 disables it with no performance cost.

| Parameter | Deviation range | Affects |
|-----------|----------------|---------|
| `/grainrate_dev` | 0–250 Hz | Grain emission rate |
| `/async_dev` | 0–0.5 | Timing jitter |
| `/intermittency_dev` | 0–0.5 | Dropout probability |
| `/streams_dev` | 0–10 | Stream count |
| `/playback_dev` | 0–16 | Playback rate |
| `/duration_dev` | 0–5000 ms | Grain duration |
| `/envelope_dev` | 0–0.5 | Envelope shape |
| `/pan_dev` | 0–1 | Pan position |
| `/amp_dev` | 0–24 dB | Amplitude |
| `/filterfreq_dev` | 0–12000 Hz | Filter center frequency |
| `/resonance_dev` | 0–0.5 | Filter resonance |
| `/scanstart_dev` | 0–0.5 | Scan start position |
| `/scanrange_dev` | 0–0.5 | Scan range |
| `/scanspeed_dev` | 0–16 | Scan speed |

---

## LFO System

Six independent LFOs for continuous parameter modulation. LFO values are computed once per audio vector (block-average of all samples in the buffer) for efficiency.

### LFO Configuration

Replace `<N>` with 1–6.

| Parameter | Type | Range | Description |
|-----------|------|-------|-------------|
| `/lfo<N>shape` | int | 0–4 | Waveform (see table below) |
| `/lfo<N>rate` | float | 0.001–100 Hz | Oscillation frequency |
| `/lfo<N>polarity` | int | 0–2 | Output polarity (see table below) |
| `/lfo<N>duty` | float | 0–1 | Duty cycle — square wave only |

**Waveform shapes:**

| Value | Shape | Output range (bipolar) |
|-------|-------|----------------------|
| 0 | Sine | −1 to 1 |
| 1 | Square | −1 or +1 |
| 2 | Rise (ascending saw) | −1 to 1 |
| 3 | Fall (descending saw) | −1 to 1 |
| 4 | Noise (sample-and-hold) | −1 to 1 |

**Polarity:**

| Value | Mode | Output range |
|-------|------|-------------|
| 0 | Bipolar | −1 to 1 |
| 1 | Unipolar positive | 0 to 1 |
| 2 | Unipolar negative | −1 to 0 |

---

### LFO Routing

Connect an LFO to any modulatable parameter with:

```
/lfo<N>_to_<param> <depth>
```

- `<depth>` 0.0–1.0: modulation amount (0 = disconnects the LFO from that target)
- One LFO source per parameter destination (last assignment wins)
- Multiple destinations per LFO are allowed

**Modulatable parameters:**

`grainrate`, `async`, `intermittency`, `streams`, `playback`, `duration`, `envelope`, `amplitude`, `filterfreq`, `resonance`, `pan`, `scanstart`, `scanrange`, `scanspeed`, `soundfile`, `fixedchan`, `rrstep`, `randspread`, `randspread_weighted`, `spatialcorr`, `spatialcorr_weighted`, `pitchmin`, `pitchmax`, `trajshape`, `trajrate`, `trajdepth`

**Not modulatable:** deviation parameters (`*_dev`), LFO configuration parameters

---

## Utility Messages

| Message | Description |
|---------|-------------|
| `clear` | Stop all active grains immediately |
| `showbuffer` | Print buffer name, frames, channels, and duration to Max console |

---

## FullPacket Input

Accepts OSC bundles for batch parameter updates in a single message:

```
FullPacket <size> <pointer>
```

All `/param value` messages listed in this reference can be sent via FullPacket. Useful for snapshot recall or parameter sets received from `udpreceive`.

---

## Examples

```
; Basic granulation from buffer "mysample"
/grainrate 30
/duration 150
/amp -6
/scanstart 0.2
/scanrange 0.5
/scanspeed 0.5

; LFO modulating filter frequency
/lfo1shape 0
/lfo1rate 0.25
/lfo1polarity 1
/lfo1_to_filterfreq 0.6

; Stochastic cloud — high deviation, many streams
/streams 8
/duration 80
/duration_dev 60
/playback_dev 0.3
/amp_dev 12

; 8-channel round-robin (mode 1, step 2)
allocmode 1
/rrstep 2

; Random diffuse field (mode 2) with spatial memory
allocmode 2
/randspread 0.5
/spatialcorr 0.4

; Weighted focus on first 3 channels (mode 3)
allocmode 3
/weights 0.5 0.3 0.2 0 0 0 0 0

; Sine trajectory sweep across 8 channels (mode 6)
allocmode 6
/trajshape 0
/trajrate 0.1
/trajdepth 1.0

; Distance attenuation based on filter frequency (mode 7)
allocmode 7
/filterfreq 8000
/filterfreq_dev 4000
```

---

## Technical Notes

- **Voice pool**: 2048 simultaneous grain voices pre-allocated at startup
- **Grain processing**: grain-major per-buffer loop; each grain processes the entire audio vector before the next, enabling SIMD-friendly access patterns
- **Filter caching**: Biquad coefficients are recomputed only when `/filterfreq` or `/resonance` changes between grains; delay lines are always reset per grain
- **Thread safety**: buffer~ swaps use a non-blocking spinlock so the audio thread never stalls; `params_dirty` flag ensures parameter copies from the message thread are applied atomically at the start of each audio vector
- **LFO accuracy**: LFOs are advanced sample-by-sample and their block average is used as the control-rate value, avoiding the single-sample approximation of earlier versions
- **Denormal protection**: FTZ/DAZ flags are set in the DSP setup callback on x86_64 builds to prevent filter denormals from degrading CPU performance
- **RNG**: stochastic deviation uses MT19937 (Mersenne Twister) seeded from hardware entropy at startup
