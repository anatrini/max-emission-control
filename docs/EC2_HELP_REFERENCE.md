# ec2~ Reference

Multichannel granular synthesis external for Max/MSP. Port of EmissionControl2 with up to 16 output channels and 7 spatial allocation modes.

## Overview

ec2~ generates grain clouds from a buffer~, distributing grains across multiple output channels according to configurable allocation strategies. Each grain is an independent audio fragment with controllable duration, pitch, amplitude, filtering, and spatial position. Randomization via deviation parameters creates stochastic textures (cf. Roads, *Microsound*).

```
ec2~ @buffer mybuffer @outputs 8 @allocmode 2 @mc 1
```

Parameters accept OSC-style messages (`/param value`) or FullPacket bundles.

## Inlets

| Inlet | Type | Description |
|-------|------|-------------|
| 0 | messages | OSC messages, FullPacket bundles, attributes |
| 1 | signal | Scan position (0-1), overrides `/scanstart` |
| 2 | signal | Grain rate (Hz), overrides `/grainrate` |
| 3 | signal | Playback rate, overrides `/playback` |

## Outlets

**Standard mode (@mc 0):**
- Outlets 0 to N-1: Audio signals (one per channel)
- Outlet N (rightmost): OSC FullPacket with grain visualization data

**Multichannel mode (@mc 1):**
- Outlet 0: MC audio (all channels in one cable)
- Outlet 1: OSC FullPacket with grain visualization data

**OSC output format (rightmost outlet):**
```
/grain_count <int>   - Number of active grains
/grain_start <float> - Scan region start (0-1, normalized)
/grain_end <float>   - Scan region end (0-1, normalized)
```
Use with `waveform~` for visual feedback of the active granulation region.

## Double-Click

Opens a native parameter window showing all parameters with real-time editing.

---

## Attributes

Structural attributes. Can be set:
- At creation: `ec2~ @outputs 8 @allocmode 2`
- Via message: `allocmode 2` (without `/` prefix)
- Via attrui or inspector

Note: `@outputs` and `@mc` require object recreation to take effect.

| Attr | Type | Range | Default | Description |
|------|------|-------|---------|-------------|
| @buffer | symbol | - | "" | Source buffer~ name |
| @outputs | int | 1-16 | 2 | Number of output channels |
| @mc | int | 0-1 | 0 | Multichannel cable mode |
| @allocmode | int | 0-6 | 1 | Spatial allocation mode (see below) |
| @soundfile | int | 0-15 | 0 | Buffer index for polybuffer~ |

---

## Spatial Allocation Modes

The allocation mode determines how grains are distributed across output channels. Each mode implements a different spatial strategy.

### Mode 0: Fixed

All grains emit from a single channel. Use for mono output or when external spatialization handles routing.

| Parameter | Type | Range | Description |
|-----------|------|-------|-------------|
| /fixedchan | int | 1-16 | Target output channel |

### Mode 1: Round-Robin

Grains cycle sequentially through channels. Creates predictable spatial movement useful for rhythmic patterns or systematic distribution.

| Parameter | Type | Range | Description |
|-----------|------|-------|-------------|
| /rrstep | int | 1-16 | Step size between successive grains |

Example: With 8 outputs and `/rrstep 3`, grains follow: 1→4→7→2→5→8→3→6→1...

### Mode 2: Random

Grains assigned to uniformly random channels. Creates diffuse, decorrelated spatial textures.

| Parameter | Type | Range | Description |
|-----------|------|-------|-------------|
| /randspread | float | 0-1 | Panning amount between adjacent channels (0=hard assignment, 1=full panning) |
| /spatialcorr | float | 0-1 | Correlation between successive grain positions (0=independent, 1=smooth movement) |

`/spatialcorr` controls how much each grain's position is influenced by the previous grain. Higher values create coherent spatial trajectories; lower values create scattered, pointillistic textures.

### Mode 3: Weighted

Grains assigned randomly with per-channel probability weights. Creates biased distributions useful for asymmetric spatial focus.

| Parameter | Type | Range | Description |
|-----------|------|-------|-------------|
| /randspread_weighted | float | 0-1 | Panning amount between adjacent channels |
| /spatialcorr_weighted | float | 0-1 | Correlation between successive grain positions |
| /weights | list | floats | Per-channel probability weights (auto-normalized) |

Example: `/weights 0.5 0.3 0.1 0.1` distributes 50% of grains to channel 1, 30% to channel 2, etc.

### Mode 4: Load-Balance

**Automatic mode with no user parameters.** Assigns each grain to the channel with the fewest currently active grains. Ensures even distribution of polyphony across the output array.

This mode is useful when you want consistent spatial density regardless of grain scheduling. The allocator tracks active grain counts internally and automatically balances the load.

Behavior:
- New grains go to the least-loaded channel
- Ties are resolved randomly
- No parameters required or exposed

### Mode 5: Pitch-Map

Maps grain pitch to spatial position. Low pitches route to low-numbered channels, high pitches to high-numbered channels (logarithmic scaling). Creates spectral-spatial correlation.

| Parameter | Type | Range | Description |
|-----------|------|-------|-------------|
| /pitchmin | float | 20-20000 Hz | Pitch mapped to first channel |
| /pitchmax | float | 20-20000 Hz | Pitch mapped to last channel |

### Mode 6: Trajectory

Grains follow a time-based spatial trajectory across the channel array. Creates automated spatial movement patterns.

| Parameter | Type | Range | Description |
|-----------|------|-------|-------------|
| /trajshape | int | 0-5 | Trajectory waveform (see below) |
| /trajrate | float | 0.001-100 Hz | Movement speed |
| /trajdepth | float | 0-1 | Movement amplitude (proportion of array) |
| /spiral_factor | float | 0-1 | Spiral tightness (shape 4 only) |
| /pendulum_decay | float | 0-1 | Damping factor (shape 5 only) |

Trajectory shapes:
- 0: Sine - Smooth oscillation
- 1: Saw - Linear sweep with reset
- 2: Triangle - Linear back-and-forth
- 3: Random walk - Constrained random movement
- 4: Spiral - Requires `/spiral_factor`
- 5: Pendulum - Damped oscillation, requires `/pendulum_decay`

---

## Synthesis Parameters

### Grain Scheduling

| Parameter | Type | Range | Default | Description |
|-----------|------|-------|---------|-------------|
| /grainrate | float | 0.1-500 Hz | 20 | Grain emission rate |
| /async | float | 0-1 | 0 | Timing jitter (0=synchronous, 1=random) |
| /intermittency | float | 0-1 | 0 | Probability of grain dropout |
| /streams | float | 1-20 | 1 | Number of parallel grain streams |

### Grain Characteristics

| Parameter | Type | Range | Default | Description |
|-----------|------|-------|---------|-------------|
| /playback | float | -32 to 32 | 1 | Playback rate (negative=reverse) |
| /duration | float | 0.046-10000 ms | 100 | Grain duration |
| /envelope | float | 0-1 | 0.5 | Envelope shape (0=Hann, 1=Expodec) |
| /amp | float | -180 to 48 dB | -6 | Output amplitude |

### Filter

| Parameter | Type | Range | Default | Description |
|-----------|------|-------|---------|-------------|
| /filterfreq | float | 20-24000 Hz | 1000 | Lowpass filter cutoff |
| /resonance | float | 0-1 | 0 | Filter resonance |

### Spatial/Scan

| Parameter | Type | Range | Default | Description |
|-----------|------|-------|---------|-------------|
| /pan | float | -1 to 1 | 0 | Stereo pan position |
| /scanstart | float | 0-1 | 0 | Buffer scan position (normalized) |
| /scanrange | float | -1 to 1 | 0.5 | Scan window size (negative=reverse) |
| /scanspeed | float | -32 to 32 | 1 | Automatic scan speed |

### Sound File Selection

| Parameter | Type | Range | Default | Description |
|-----------|------|-------|---------|-------------|
| /soundfile | int | 0-15 | 0 | Buffer index for polybuffer~ |

---

## Deviation Parameters

Per-grain random deviation (± from base value). Creates stochastic variation characteristic of granular clouds.

| Parameter | Range | Affects |
|-----------|-------|---------|
| /grainrate_dev | 0-250 | Grain rate |
| /async_dev | 0-0.5 | Async timing |
| /intermittency_dev | 0-0.5 | Dropout probability |
| /streams_dev | 0-10 | Stream count |
| /playback_dev | 0-16 | Playback rate |
| /duration_dev | 0-5000 | Grain duration |
| /envelope_dev | 0-0.5 | Envelope shape |
| /pan_dev | 0-1 | Pan position |
| /amp_dev | 0-24 | Amplitude |
| /filterfreq_dev | 0-12000 | Filter frequency |
| /resonance_dev | 0-0.5 | Resonance |
| /scanstart_dev | 0-0.5 | Scan position |
| /scanrange_dev | 0-0.5 | Scan range |
| /scanspeed_dev | 0-16 | Scan speed |

---

## LFO System

Six independent LFOs for parameter modulation.

### LFO Configuration

| Parameter | Type | Range | Description |
|-----------|------|-------|-------------|
| /lfo\<N\>shape | int | 0-4 | Waveform: 0=sine, 1=square, 2=rise, 3=fall, 4=noise |
| /lfo\<N\>rate | float | 0.001-100 Hz | Oscillation rate |
| /lfo\<N\>polarity | int | 0-2 | 0=bipolar (±1), 1=unipolar+ (0-1), 2=unipolar- (-1-0) |
| /lfo\<N\>duty | float | 0-1 | Duty cycle (square wave only) |

Where \<N\> = 1-6

### LFO Routing

Connect LFOs to parameters with:
```
/lfo<N>_to_<param> <depth>
```

- `depth` 0.0-1.0 controls modulation amount
- `depth` = 0 disconnects the LFO
- One LFO per parameter (last assignment wins)

**Modulatable targets:** grainrate, async, intermittency, streams, playback, duration, envelope, amplitude, filterfreq, resonance, pan, scanstart, scanrange, scanspeed, soundfile, fixedchan, rrstep, randspread, randspread_weighted, spatialcorr, spatialcorr_weighted, pitchmin, pitchmax, trajshape, trajrate, trajdepth

**Not modulatable:** deviation parameters (*_dev), LFO parameters

---

## Utility Messages

| Message | Description |
|---------|-------------|
| clear | Stop all active grains immediately |
| showbuffer | Post buffer information to Max console |

---

## FullPacket Input

Accepts OSC bundles for batch parameter updates:
```
FullPacket <size> <pointer>
```

---

## Examples

```
; Basic granulation
/grainrate 30
/duration 150
/amp -6
/scanstart 0.2
/scanrange 0.5

; LFO modulation
/lfo1shape 0
/lfo1rate 0.5
/lfo1_to_filterfreq 0.4

; Random spatial allocation (mode 2)
/randspread 0.6
/spatialcorr 0.3

; Weighted allocation (mode 3)
/weights 0.5 0.3 0.1 0.1
/randspread_weighted 0.4
```
