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

### envelope (float, 0.0-1.0, default: 0.5)
Grain envelope shape - morphs between three envelope types:
- **0.0**: Exponential decay (sharp attack, exponential decay)
- **0.0-0.5**: Interpolates between exponential decay and Tukey window
- **0.5**: Tukey window (smooth raised-cosine envelope, most neutral)
- **0.5-1.0**: Interpolates between Tukey window and reverse exponential
- **1.0**: Reverse exponential (exponential growth, sharp release)

The envelope shape significantly affects grain character:
- Lower values (0.0-0.4): More percussive, sharp attack
- Middle values (0.4-0.6): Smooth, natural
- Higher values (0.6-1.0): Swelling, crescendo grains

## Filtering Parameters

### filterfreq (float, 20.0-22000.0 Hz, default: 22000.0)
Filter cutoff frequency in Hertz.
- **22000 Hz**: No filtering (bypassed)
- **< 22000 Hz**: Lowpass filter applied to each grain
- The filter is a 3-stage biquad cascade for steep rolloff

Use filtering to:
- Shape spectral content of grains
- Create darker, muffled textures
- Emphasize low frequencies in dense clouds

### resonance (float, 0.0-1.0, default: 0.0)
Filter resonance / Q factor.
- **0.0**: No resonance (standard lowpass)
- **> 0.0**: Emphasizes frequencies near cutoff
- **High values (> 0.7)**: Creates resonant peak, adds "ringing" character

Resonance interacts strongly with `filterfreq` and `duration`:
- Long grains with resonance: sustained harmonic emphasis
- Short grains with resonance: spectral "ping" effects

## Stereo Panning

### pan (float, -1.0-1.0, default: 0.0)
Stereo pan position (legacy stereo mode only).
- **-1.0**: Hard left
- **0.0**: Center
- **1.0**: Hard right

**Important:** This parameter only affects stereo output (@outputs 2). For multichannel configurations, grain spatialization is controlled by the spatial allocator (see Multichannel Spatial Allocation section).

Uses constant-power panning law for smooth spatial transitions.

## Scanning Parameters

### scanspeed (float, -32.0-32.0, default: 1.0)
Scan speed multiplier - controls how fast the playback position moves through the buffer.
- **1.0**: Normal scanning speed
- **> 1.0**: Faster scanning (move through buffer more quickly)
- **< 1.0**: Slower scanning (linger in buffer regions)
- **0.0**: Static position (no movement)
- **Negative values**: Reverse scanning direction

Interacts with `scanstart` and `scanrange` to create evolving textures.

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

## Signal Inputs (Phase 12)

ec2~ supports signal-rate control for three key parameters via additional signal inlets. Signal inputs override the corresponding attributes when connected, enabling CV-style modulation and dynamic control.

### Inlet 1: Scan Position (signal)
Signal-rate control of grain start position in the buffer (0.0-1.0, normalized).
- **Processing**: Per-sample update
- **Range**: 0.0-1.0 (0.0 = buffer start, 1.0 = buffer end)
- **Overrides**: `@scanstart` attribute
- **Use cases**: Audio-rate scrubbing, scanning, dynamic position control

### Inlet 2: Grain Rate (signal)
Signal-rate control of grain emission frequency (Hz).
- **Processing**: Control-rate (averaged over audio buffer)
- **Range**: 0.1-500.0 Hz
- **Overrides**: `@grainrate` attribute
- **Use cases**: Dynamic grain density, tempo-synced emission

### Inlet 3: Playback Rate (signal)
Signal-rate control of grain transposition/playback speed.
- **Processing**: Per-grain (sampled when grain is triggered)
- **Range**: -32.0 to 32.0 (1.0 = original pitch)
- **Overrides**: `@playback` attribute
- **Use cases**: Dynamic pitch modulation, melodic sequences

### Signal Input Examples

**Example 1: Scan position modulation**
```
[phasor~ 0.5]        // Scan through buffer at 0.5 Hz
|
[ec2~ mybuffer]
```

**Example 2: Dynamic grain rate**
```
[phasor~ 0.1]        // LFO at 0.1 Hz
|
[*~ 40]             // Scale to 0-40 Hz
|
[+~ 10]             // Offset to 10-50 Hz
|
[inlet~ 2]
[ec2~ mybuffer]
```

**Example 3: Pitch sequence**
```
[makenote]
|
[mtof]
|
[/ 440]             // Normalize to playback rate
|
[sig~]
|
[inlet~ 3]
[ec2~ mybuffer]
```

**Important notes**:
- Signal inputs override attributes ONLY when connected
- When no signal is connected, falls back to attribute values + LFO modulation
- Backward compatible with existing patches (no signal = attribute-based control)
- All signal inputs are optional

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

### /set <buffer_name> [buffer_name2 ...]
OSC-style message to load one or more buffers by name. This is equivalent to the `read` message but uses OSC format for integration with OSC-based control systems.

**Format**: `/set buffer_name` or `/set buffer1 buffer2 buffer3 ...`

```
[message /set mybuffer(        // Load single buffer via OSC
[message /set buf1 buf2 buf3(  // Load multiple buffers via OSC
|
[ec2~]
```

**Multiple buffer support**: When multiple buffer names are provided, they are loaded as a polybuffer-style collection indexed from 0. You can switch between them using the `@soundfile` attribute.

**Examples**:
```
// Load single buffer
[message /set mysample(
|
[ec2~]

// Load three buffers and select the second one
[message /set sound1 sound2 sound3(
|
[ec2~ @soundfile 1]  // Use sound2 (index 1)
```

**OSC Compatibility**: This message follows OSC naming conventions (message starts with `/`) and is compatible with odot, spat5, and other OSC-based Max workflows.

### Inlet Configuration
ec2~ has **4 inlets total**:

- **Inlet 0** (leftmost): **Messages and OSC commands** - Accepts all messages including `/set`, `/grainrate`, `read`, `polybuffer`, `clear`, etc. All OSC messages (messages starting with `/`) must be sent to this inlet.
- **Inlet 1**: **Signal input** - Scan position (0.0-1.0), overrides `@scanstart` when connected
- **Inlet 2**: **Signal input** - Grain rate (Hz), overrides `@grainrate` when connected  
- **Inlet 3**: **Signal input** - Playback rate, overrides `@playback` when connected

```
Messages/OSC    Scan~   Rate~   Playback~
     |            |       |        |
     [ec2~ mybuffer @outputs 4]
```

### Outlet Configuration
ec2~ outlets depend on the `@mc` attribute:

**When @mc=0 (separated outputs, default)**:
- **Outlets 0 to (@outputs-1)**: Individual signal outputs for each channel
- **Last outlet**: OSC bundle debug output

Example with `@outputs 4`:
```
     [ec2~ @outputs 4 @mc 0]
      |    |    |    |     |
     ch0  ch1  ch2  ch3  OSC
```

**When @mc=1 (multichannel cable)**:
- **Outlet 0**: Multichannel signal output (blue/black MC cable) carrying all `@outputs` channels
- **Outlet 1**: OSC bundle debug output

Example with `@outputs 8 @mc 1`:
```
     [ec2~ @outputs 8 @mc 1]
      |              |
   MC (8ch)        OSC
```

The OSC outlet outputs parameter state when the object receives a `bang` message. Use this for debugging or for routing parameter state to other Max objects.


### waveform (Phase 13)
Reports buffer information to the Max console: frames, channels, sample rate, duration, and peak amplitude.

```
[waveform(   // Print buffer info to console
```

Output example:
```
ec2~: buffer info:
  frames: 44100
  channels: 1
  sample rate: 44100 Hz
  duration: 1 seconds
  peak amplitude: 0.8 (-1.94 dB)
```

### openbuffer (Phase 13)
Opens Max's built-in buffer editor for the currently loaded buffer, allowing waveform viewing and editing.

```
[openbuffer(   // Open buffer editor window
```

This provides direct access to Max's waveform display and editing tools for the current buffer.

### dblclick (Phase 13)
Double-clicking the ec2~ object opens the buffer editor (same as `openbuffer` message). This provides a quick way to view the waveform without typing a message.

**Note**: Double-click behavior is similar to waveform~ and other Max buffer-based objects.

---

## Typical Patch Configurations

### Configuration 1: Dense Spatial Cloud
```
grainrate 40.0
duration 150.0
envelope 0.5
async 0.3
allocmode 2      // Random
randspread 0.5
spatialcorr 0.2
filterfreq 22000.0  // No filtering
```
Creates a dense, diffuse cloud with soft spatial randomization.

### Configuration 2: Circular Motion
```
grainrate 20.0
duration 200.0
envelope 0.5
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
envelope 0.4
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
envelope 0.3     // Sharp attacks
intermittency 0.3
allocmode 1      // Round-robin
rrstep 2
```
Sparse, rhythmic jumps through even-numbered channels.

### Configuration 5: Filtered Ambient Cloud
```
grainrate 35.0
duration 300.0
envelope 0.6     // Swelling envelopes
filterfreq 800.0
resonance 0.4
allocmode 2      // Random
randspread 0.7
```
Dark, resonant grains with swelling envelopes creating ambient textures.

### Configuration 6: Percussive Scanning
```
grainrate 12.0
duration 50.0
envelope 0.2     // Sharp attack
scanspeed 2.0    // Fast scanning
scanrange 0.3
filterfreq 4000.0
allocmode 1      // Round-robin
```
Percussive grains scanning rapidly through buffer section.

### Configuration 7: Stereo Shimmer (2 channels)
```
outputs 2
grainrate 60.0
duration 80.0
envelope 0.7     // Reverse exponential
playback 2.0     // Octave up
pan 0.0          // Center
filterfreq 12000.0
resonance 0.3
async 0.5
```
High-pitched shimmering texture with slight filtering.

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

- LFO modulation system
- Cluster/mask for channel subset selection
- Weight arrays for weighted mode (requires list/array message handling)
- Distance-based 3D spatialization
- OSC parameter control
- Per-stream spatial allocation
- Buffer~ change notifications (automatic reload on buffer~ modification)

---

## Credits

**Author:** Alessandro Anatrini
**License:** GPL-3.0
**Based on:** EmissionControl2 by the AlloSphere Research Group
**Theoretical Foundation:** Curtis Roads, "Microsound" (MIT Press, 2001)

**Repository:** https://github.com/anatrini/max-emission-control
