# ec2~ Reference

Multichannel granular synthesis for Max/MSP. Up to 16 channels, 7 spatial allocation modes.

## Overview

```
ec2~ @buffer mybuffer @outputs 8 @mc 1
```

All parameters controllable via OSC-style messages (`/param value`) or FullPacket bundles.

## Inlets

| Inlet | Type | Description |
|-------|------|-------------|
| 0 | messages | OSC messages (`/param value`), FullPacket bundles, attributes |
| 1 | signal | Scan position (0-1), overrides `/scanstart` |
| 2 | signal | Grain rate (Hz), overrides `/grainrate` |
| 3 | signal | Playback rate, overrides `/playback` |

## Outlets

**Standard mode (@mc 0):**

| Outlet | Content |
|--------|---------|
| 0 to N-1 | Audio signals (one per channel) |
| N (rightmost) | OSC FullPacket: grain visualization data |

**Multichannel mode (@mc 1):**

| Outlet | Content |
|--------|---------|
| 0 | MC audio (all channels in one cable) |
| 1 (rightmost) | OSC FullPacket: grain visualization data |

**OSC output format (rightmost outlet):**

```
/grain_count <int>     - Number of active grains
/grain_start <float>   - Scan region start (0-1, normalized)
/grain_end <float>     - Scan region end (0-1, normalized)
```

Use normalized values with `waveform~` for selection display.

## Double-Click

Double-click on the object opens the parameter window showing all parameters with real-time editing.

## Attributes

| Attr | Type | Range | Default | Description |
|------|------|-------|---------|-------------|
| @buffer | symbol | - | "" | Source buffer name |
| @outputs | int | 1-16 | 2 | Number of output channels |
| @mc | int | 0-1 | 0 | Multichannel cable mode |
| @allocmode | int | 0-6 | 1 | Spatial allocation mode |
| @soundfile | int | 0-15 | 0 | Buffer index (polybuffer~) |

## Parameters (OSC Messages)

All parameters accept OSC-style messages: `/param value`

### Grain Scheduling

| Message | Type | Range | Default |
|---------|------|-------|---------|
| /grainrate | float | 0.1-500 | 20 |
| /async | float | 0-1 | 0 |
| /intermittency | float | 0-1 | 0 |
| /streams | float | 1-20 | 1 |

### Grain Characteristics

| Message | Type | Range | Default |
|---------|------|-------|---------|
| /playback | float | -32 to 32 | 1 |
| /duration | float | 0.046-10000 | 100 |
| /envelope | float | 0-1 | 0.5 |
| /amp | float | -180 to 48 | -6 |

### Filter

| Message | Type | Range | Default |
|---------|------|-------|---------|
| /filterfreq | float | 20-24000 | 1000 |
| /resonance | float | 0-1 | 0 |

### Spatial/Scan

| Message | Type | Range | Default |
|---------|------|-------|---------|
| /pan | float | -1 to 1 | 0 |
| /scanstart | float | 0-1 | 0 |
| /scanrange | float | -1 to 1 | 0.5 |
| /scanspeed | float | -32 to 32 | 1 |

### Sound File Selection

| Message | Type | Range | Default |
|---------|------|-------|---------|
| /soundfile | int | 0-15 | 0 |

Select buffer index for polybuffer~. LFO modulatable.

### Deviation (random ± per grain)

| Message | Range |
|---------|-------|
| /grainrate_dev | 0-250 |
| /async_dev | 0-0.5 |
| /intermittency_dev | 0-0.5 |
| /streams_dev | 0-10 |
| /playback_dev | 0-16 |
| /duration_dev | 0-5000 |
| /envelope_dev | 0-0.5 |
| /pan_dev | 0-1 |
| /amp_dev | 0-24 |
| /filterfreq_dev | 0-12000 |
| /resonance_dev | 0-0.5 |
| /scanstart_dev | 0-0.5 |
| /scanrange_dev | 0-0.5 |
| /scanspeed_dev | 0-16 |

## Spatial Allocation

| Mode | Name |
|------|------|
| 0 | Fixed |
| 1 | Round-robin |
| 2 | Random |
| 3 | Weighted |
| 4 | Load-balance |
| 5 | Pitch-map |
| 6 | Trajectory |

### Mode 0 (Fixed)

| Message | Type | Range |
|---------|------|-------|
| /fixedchan | int | 1-16 |

### Mode 1 (Round-robin)

| Message | Type | Range |
|---------|------|-------|
| /rrstep | int | 1-16 |

### Mode 2 (Random)

| Message | Type | Range |
|---------|------|-------|
| /randspread | float | 0-1 |
| /spatialcorr | float | 0-1 |

### Mode 3 (Weighted)

| Message | Type | Range |
|---------|------|-------|
| /randspread_weighted | float | 0-1 |
| /spatialcorr_weighted | float | 0-1 |
| /weights | list | floats (auto-normalized) |

### Mode 5 (Pitch-map)

| Message | Type | Range |
|---------|------|-------|
| /pitchmin | float | 20-20000 |
| /pitchmax | float | 20-20000 |

### Mode 6 (Trajectory)

| Message | Type | Range |
|---------|------|-------|
| /trajshape | int | 0-5 |
| /trajrate | float | 0.001-100 |
| /trajdepth | float | 0-1 |
| /spiral_factor | float | 0-1 |
| /pendulum_decay | float | 0-1 |

## LFO System (6 independent)

### Configuration

| Message | Type | Range |
|---------|------|-------|
| /lfo\<N\>shape | int | 0-4 (sine/square/rise/fall/noise) |
| /lfo\<N\>rate | float | 0.001-100 Hz |
| /lfo\<N\>polarity | int | 0-2 (bipolar/uni+/uni-) |
| /lfo\<N\>duty | float | 0-1 |

Where `<N>` = 1-6

### Routing

Format: `/lfo<N>_to_<param> <depth>`

- depth 0-1, depth=0 disconnects
- One LFO per parameter (last assignment wins)

**Modulatable targets:** grainrate, async, intermittency, streams, playback, duration, envelope, amplitude, filterfreq, resonance, pan, scanstart, scanrange, scanspeed, soundfile, randspread, randspread_weighted, spatialcorr, spatialcorr_weighted, pitchmin, pitchmax, trajshape, trajrate, trajdepth

## FullPacket Input

The external accepts OSC bundles via the `FullPacket` message:

```
FullPacket <size> <pointer>
```

All messages in the bundle are parsed and dispatched to their respective handlers.

## Utility Messages

| Message | Description |
|---------|-------------|
| clear | Stop all active grains |
| showbuffer | Post buffer information to Max console |

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
/lfo1_to_grainrate 0.3

; Spatial allocation (mode 2)
/randspread 0.5
/spatialcorr 0.3

; Spatial allocation (mode 3)
/randspread_weighted 0.5
/spatialcorr_weighted 0.3
/weights 0.5 0.3 0.1 0.1
```
