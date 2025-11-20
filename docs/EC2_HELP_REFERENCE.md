# ec2~ Reference Documentation
**EmissionControl2 Granular Synthesis External for Max/MSP**

## Overview

`ec2~` is a multichannel granular synthesis external for Max/MSP, capable of distributing grains across up to 16 output channels using sophisticated spatial allocation strategies based on Curtis Roads's "Microsound" principles.

## Basic Usage

```
[ec2~ 16]  // Create ec2~ with 16 output channels
```

Arguments:
- **num_outputs** (int, optional): Number of output channels (1-16, default: 2)

## Multichannel Output Configuration

ec2~ supports flexible multichannel output routing with two independent controls:

### @outputs (int, 1-16, default: 2)
Sets the number of output channels. This controls HOW MANY outputs the external produces.

```
@outputs 2   // Stereo (default)
@outputs 8   // 8 channels
@outputs 16  // Maximum: 16 channels
```

### @mc (int, 0-1, default: 0)
Controls the output delivery mode. This determines HOW the outputs are presented in Max.

- **@mc 0** (default): **Separated outputs** - Each output channel requires its own Max cord/connection. This is the traditional Max behavior where you need to connect each output individually.

- **@mc 1**: **Multichannel cable** - All outputs are bundled into a single blue/black multichannel cord. This is Max's MC (multichannel) cable system that carries multiple audio channels through a single connection.

**Examples:**
```
// 8 separated outputs (requires 8 individual cords)
@outputs 8
@mc 0

// 8 channels via single multichannel cable (1 blue/black cord)
@outputs 8
@mc 1

// Stereo via multichannel cable
@outputs 2
@mc 1
```

**Important:** These two attributes are independent:
- `@outputs` controls the NUMBER of channels
- `@mc` controls the DELIVERY method (separated vs. bundled)

You can have any number of outputs (1-16) delivered either as separated outputs (@mc 0) or as a multichannel cable (@mc 1).

## Grain Scheduling Parameters

### grainrate (float, 0.1-500.0 Hz, default: 20.0)
Grain emission rate in Hertz. Controls how frequently new grains are triggered.
- Low values (< 10 Hz): Discrete, articulated grains
- Medium values (10-50 Hz): Dense textures
- High values (> 50 Hz): Continuous, fused sounds

### async (float, 0.0-1.0, default: 0.0)
Asynchronicity - randomization of grain timing.
- 0.0: Perfectly regular grain emission
- 1.0: Maximum randomization (stochastic clouds)

### intermittency (float, 0.0-1.0, default: 0.0)
Probability of grain emission.
- 0.0: Every scheduled grain is emitted
- 0.5: 50% probability per grain
- 1.0: Near-silence (very sparse emission)

### streams (int, 1-20, default: 1)
Number of independent grain streams (polyphonic grain layers).

## Grain Characteristics

### duration (float, 1.0-1000.0 ms, default: 100.0)
Grain duration in milliseconds.
- Short (1-20 ms): Granular, spectral effects
- Medium (20-200 ms): Classic granular textures
- Long (200-1000 ms): Overlapping layers, ambient clouds

### playback (float, -32.0-32.0, default: 1.0)
Playback rate / transposition.
- 1.0: Original pitch
- 2.0: One octave up
- 0.5: One octave down
- Negative values: Reverse playback

### amp (float, 0.0-1.0, default: 0.5)
Overall amplitude.
Note: Automatic voice count compensation is applied to prevent volume increase with overlapping grains.

## Scanning Parameters

### scanstart (float, 0.0-1.0, default: 0.0)
Starting position in the source buffer.
- 0.0: Beginning of buffer
- 1.0: End of buffer

### scanrange (float, 0.0-1.0, default: 1.0)
Range of buffer to scan from start position.

---

## Multichannel Spatial Allocation

The spatial allocator determines which output channels each grain is routed to and with what panning gains. Seven allocation modes are available, each implementing different spatial distribution strategies.

### allocmode (int, 0-6, default: 1)
Selects the spatial allocation mode:
- **0**: Fixed - All grains to same channel(s)
- **1**: Round-robin - Cyclic sequence through channels
- **2**: Random - Uniform random distribution
- **3**: Weighted - Random with per-channel probability weights
- **4**: Load-balance - Equalize active grain count across channels
- **5**: Pitchmap - Pitch/frequency maps to spatial position
- **6**: Trajectory - Time-based spatial movement

---

## Mode 0: Fixed

Routes all grains to a single fixed channel or channel pair.

**Use cases:**
- Creating mono layers within multichannel systems
- Debugging and testing
- Isolating grain streams to specific speakers

### Parameters

#### fixedchan (int, 0-15, default: 0)
Target output channel index.

**Example:**
```
allocmode 0
fixedchan 4  // All grains to channel 4
```

---

## Mode 1: Round-robin

Cycles through channels in sequence, creating ordered spatial trajectories.

**Use cases:**
- Circular spatial movement
- Sequential speaker activation
- Rhythmic spatial patterns

### Parameters

#### rrstep (int, 1-16, default: 1)
Channel increment per grain.
- 1: Sequential (0→1→2→3→...)
- 2: Every other channel (0→2→4→6→...)
- N: Jump by N channels (wraps around)

**Examples:**
```
// Sequential rotation through all channels
allocmode 1
rrstep 1

// Jump by 3 channels
allocmode 1
rrstep 3
```

**Theory:** Implements discrete version of pan envelopes moving across channels. With step=1, creates smooth circular motion. With coprime steps, creates less obvious patterns that still cover all channels.

---

## Mode 2: Random (Uniform)

Randomly assigns grains to channels with uniform probability.

**Use cases:**
- Diffuse spatial clouds
- Stochastic spatialization
- Vivid, unpredictable spatial fields

### Parameters

#### randspread (float, 0.0-1.0, default: 0.0)
Controls panning between adjacent channels.
- 0.0: Hard assignment to single channel
- > 0.0: Panning between adjacent channels
- 1.0: Full constant-power panning

#### spatialcorr (float, 0.0-1.0, default: 0.0)
Spatial correlation between successive grains.
- 0.0: Independent channel selection per grain
- 1.0: Strong tendency to remain near previous channel (spatial "stickiness")

**Examples:**
```
// Pure random, hard assignment
allocmode 2
randspread 0.0
spatialcorr 0.0

// Random with smooth panning
allocmode 2
randspread 0.7
spatialcorr 0.3  // Slight spatial correlation
```

**Theory:** Directly implements Roads's "random dispersion of grains among N channels". Most effective for relatively long grains and moderate densities.

---

## Mode 3: Weighted

Random distribution with per-channel probability weights (not yet implemented in UI - requires list/array message).

**Use cases:**
- Directional spatial focus
- "Hot spots" in multichannel array
- Asymmetric spatial fields

**Theory:** Allows concentration of grain probability on specific channels (e.g., emphasize front channels over rear, create spatial "focus points").

---

## Mode 4: Load-balance

Keeps the number of active grains roughly equal across channels.

**Use cases:**
- Uniform energy distribution
- Preventing channel overload
- Balanced multichannel density

**Theory:** Maintains active grain count balance by allocating new grains to channels with fewest active grains. Prevents situations where one channel becomes overly dense while others remain sparse.

---

## Mode 5: Pitchmap

Maps grain pitch/frequency to spatial position across the channel array.

**Use cases:**
- Spectral spatialization
- Frequency-based spatial segregation
- Creating spatial-spectral relationships

### Parameters

#### pitchmin (float, 20.0-20000.0 Hz, default: 20.0)
Minimum pitch of mapping range (maps to leftmost channels).

#### pitchmax (float, 20.0-20000.0 Hz, default: 20000.0)
Maximum pitch of mapping range (maps to rightmost channels).

**Examples:**
```
// Low pitches left, high pitches right
allocmode 5
pitchmin 100.0
pitchmax 4000.0
playback 1.0  // Use playback rate to modulate pitch

// Narrow range for subtle spatial-spectral effects
allocmode 5
pitchmin 440.0
pitchmax 880.0
```

**Theory:** Implements spatial-spectral mapping where spectral characteristics correspond to spatial position. Low frequencies map to lower channel indices, high frequencies to higher indices. Uses logarithmic mapping by default for perceptual scaling.

---

## Mode 6: Trajectory

Grains follow a time-based spatial trajectory across the channel array.

**Use cases:**
- Continuous spatial movement
- Panning envelopes
- Circular/sweeping motions

### Parameters

#### trajshape (int, 0-3, default: 0)
Trajectory shape:
- **0**: Sine - Sinusoidal back-and-forth motion
- **1**: Saw - Linear sweep (sawtooth)
- **2**: Triangle - Linear back-and-forth
- **3**: Random walk - Constrained random movement

#### trajrate (float, 0.001-100.0 Hz, default: 0.5)
Speed of trajectory movement in Hertz.

#### trajdepth (float, 0.0-1.0, default: 1.0)
Proportion of channel array covered by trajectory.
- 1.0: Full array (all channels)
- 0.5: Center half of channels
- 0.25: Center quarter

**Examples:**
```
// Slow sine wave across all channels
allocmode 6
trajshape 0
trajrate 0.2
trajdepth 1.0

// Fast sweep across center channels only
allocmode 6
trajshape 1
trajrate 2.0
trajdepth 0.5

// Slow random walk
allocmode 6
trajshape 3
trajrate 0.1
trajdepth 1.0
```

**Theory:** Discrete implementation of pan envelopes that continuously move across N channels. Grain emission time determines position on trajectory. Roads explicitly discusses such envelopes as key strategy for spatial microsound.

---

## Buffer Management

### @buffer (symbol, default: "")
Sets the buffer~ name to use as the audio source.

```
@buffer mybuffer   // Use buffer~ named "mybuffer"
```

### @soundfile (int, 0-15, default: 0)
Selects which buffer to use when working with polybuffer~.

```
@soundfile 0   // Use first buffer in polybuffer~
@soundfile 3   // Use fourth buffer in polybuffer~
```

## Messages

### clear
Stops all currently active grains immediately.

```
[clear(
```

### read <buffer_name>
Loads the specified buffer~ as the audio source.

```
[read mybuffer(   // Load buffer~ named "mybuffer"
```

### polybuffer <basename> <count>
Loads multiple buffers from a polybuffer~ collection.

```
[polybuffer mysounds 8(   // Load mysounds.0 through mysounds.7
```

The polybuffer message loads buffers named `<basename>.0`, `<basename>.1`, etc. Use the `@soundfile` attribute to select which buffer to play.

---

## Typical Patch Configurations

### Configuration 1: Dense Spatial Cloud
```
grainrate 40.0
duration 150.0
async 0.3
allocmode 2      // Random
randspread 0.5
spatialcorr 0.2
```
Creates a dense, diffuse cloud with soft spatial randomization.

### Configuration 2: Circular Motion
```
grainrate 20.0
duration 200.0
allocmode 6      // Trajectory
trajshape 0      // Sine
trajrate 0.5
trajdepth 1.0
```
Smooth sinusoidal movement across all channels.

### Configuration 3: Spectral Segregation
```
grainrate 30.0
duration 100.0
allocmode 5      // Pitchmap
pitchmin 200.0
pitchmax 2000.0
playback 1.5     // Transpose up
```
High-frequency grains to right channels, low to left.

### Configuration 4: Rhythmic Spatial Pattern
```
grainrate 8.0
duration 80.0
intermittency 0.3
allocmode 1      // Round-robin
rrstep 2
```
Sparse, rhythmic jumps through even-numbered channels.

---

## Technical Notes

### Voice Count Compensation
ec2~ automatically applies gain compensation based on active grain count using the 1/e law. This prevents volume increases when grains overlap densely.

### Multichannel Output
ec2~ has built-in multichannel support via the `@outputs` and `@mc` attributes. You do NOT need to use `mc.ec2~` wrapper.

**Separated outputs (traditional Max):**
```
[ec2~ @outputs 8 @mc 0]   // 8 separated outputs, connect each individually
```

**Multichannel cable (single cord carries all channels):**
```
[ec2~ @outputs 8 @mc 1]   // 8 channels via single blue/black MC cable
```

See "Multichannel Output Configuration" section above for detailed explanation.

### Panning Laws
- Stereo panning: Constant-power trigonometric law
- Multichannel: Constant-power panning between adjacent channels

### Grain Pool
ec2~ pre-allocates 2048 grain voices using an efficient free-list allocator. If all voices are active, new grain triggers are skipped (no crashes, graceful degradation).

---

## Spatial Allocation Theory Summary

The spatial allocation system is based on Curtis Roads's taxonomy in "Microsound":

**Two Main Families:**

1. **Deterministic spatial envelopes** - Grains pan across N channels following predictable patterns:
   - Fixed mode
   - Round-robin mode
   - Trajectory mode
   - Pitchmap mode

2. **Stochastic dispersion** - Grains randomly distributed among N channels:
   - Random mode (uniform)
   - Weighted mode
   - Load-balance mode (with random tie-breaking)

All modes support:
- Per-grain metadata (emission time, pitch, spectral features)
- Internal state management (last channel, active counts, trajectory phase)
- Configurable channel subsets (via cluster/mask - not yet in UI)

---

## Future Enhancements (Not Yet Implemented)

- Envelope shape control
- Filter frequency and resonance parameters
- LFO modulation system
- Cluster/mask for channel subset selection
- Weight arrays for weighted mode
- Distance-based 3D spatialization
- OSC parameter control
- Per-stream spatial allocation

---

## Credits

**Author:** Alessandro Anatrini
**License:** GPL-3.0
**Based on:** EmissionControl2 by the AlloSphere Research Group
**Theoretical Foundation:** Curtis Roads, "Microsound" (MIT Press, 2001)

**Repository:** https://github.com/anatrini/max-emission-control
