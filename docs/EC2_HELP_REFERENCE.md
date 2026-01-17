# ec2~ Reference

Multichannel granular synthesis for Max/MSP. Up to 16 channels, 7 spatial allocation modes.

## Overview

```
ec2~ @buffer mybuffer @outputs 8 @mc 1
```

Messages to inlet 0. OSC bundles via FullPacket.

## Quick Start

```
grainrate 30
duration 150
amp -6
scanstart 0.2
scanrange 0.5
```

## Attributes

| Attr | Type | Range | Default |
|------|------|-------|---------|
| @buffer | symbol | - | "" |
| @outputs | int | 1-16 | 2 |
| @mc | int | 0-1 | 0 |
| @allocmode | int | 0-6 | 1 |
| @soundfile | int | 0-15 | 0 |

## LFO (6 independent)

**Config** (`<N>` = 1-6):

| Message | Type | Range |
|---------|------|-------|
| /lfo\<N\>shape | int | 0-4 (sine/square/rise/fall/noise) |
| /lfo\<N\>rate | float | 0.001-100 Hz |
| /lfo\<N\>polarity | int | 0-2 (bipolar/uni+/uni-) |
| /lfo\<N\>duty | float | 0-1 |

**Routing:** `/lfo<N>_to_<param> <depth>`
- depth 0-1, depth=0 disconnects
- Targets: grainrate, async, intermittency, streams, playback, duration, envelope, amplitude, filterfreq, resonance, pan, scanstart, scanrange, scanspeed, soundfile
- One LFO per param (last wins)

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

**Mode 0:** `fixedchan` (int 1-16)

**Mode 1:** `rrstep` (int 1-16)

**Mode 2:** `randspread` (float 0-1), `spatialcorr` (float 0-1)

**Mode 3:** `randspread_weighted` (float 0-1), `spatialcorr` (float 0-1), `weights` (list)

**Mode 5:** `pitchmin`, `pitchmax` (float 20-20000)

**Mode 6:** `trajshape` (int 0-5), `trajrate` (float 0.001-100), `trajdepth` (float 0-1), `spiral_factor` (float 0-1), `pendulum_decay` (float 0-1)

## Parameters

### Grain

| Msg | Type | Range | Def |
|-----|------|-------|-----|
| grainrate | float | 0.1-500 | 20 |
| async | float | 0-1 | 0 |
| intermittency | float | 0-1 | 0 |
| streams | float | 1-20 | 1 |
| playback | float | -32/32 | 1 |
| duration | float | 0.046-10000 | 100 |
| envelope | float | 0-1 | 0.5 |
| amp | float | -180/48 | -6 |

### Filter/Spatial/Scan

| Msg | Type | Range | Def |
|-----|------|-------|-----|
| filterfreq | float | 20-24000 | 1000 |
| resonance | float | 0-1 | 0 |
| pan | float | -1/1 | 0 |
| scanstart | float | 0-1 | 0 |
| scanrange | float | -1/1 | 0.5 |
| scanspeed | float | -32/32 | 1 |

### Sound File Selection (polybuffer~)

| Msg | Type | Range | Def |
|-----|------|-------|-----|
| soundfile | int | 0-15 | 0 |

Select which buffer to use when loading multiple files via polybuffer~. Value is rounded to nearest integer. LFO modulatable.

```
soundfile 0
soundfile 3
/lfo1_to_soundfile 0.5
```

### Deviation (random ± per grain)

| Msg | Range |
|-----|-------|
| grainrate_dev | 0-250 |
| async_dev | 0-0.5 |
| intermittency_dev | 0-0.5 |
| streams_dev | 0-10 |
| playback_dev | 0-16 |
| duration_dev | 0-5000 |
| envelope_dev | 0-0.5 |
| pan_dev | 0-1 |
| amp_dev | 0-24 |
| filterfreq_dev | 0-12000 |
| resonance_dev | 0-0.5 |
| scanstart_dev | 0-0.5 |
| scanrange_dev | 0-0.5 |
| scanspeed_dev | 0-16 |

## I/O

**Inlets:** 0=messages, 1=scan~ (0-1), 2=rate~ (Hz), 3=playback~

**Outlets (@mc 0):** 0-(N-1)=audio, N=OSC

**Outlets (@mc 1):** 0=MC audio, 1=OSC

**Utility:** `clear`, `showbuffer`, `waveform`, `FullPacket`
