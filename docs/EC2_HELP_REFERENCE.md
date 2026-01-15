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

## Parameters vs Attributes

ec2~ follows Max best practices by using **attributes** for structural configuration and **parameters** for performance control.

### Attributes (@ prefix) - 5 total
Used for configuration that affects object structure. Set in 3 ways:
- **At creation**: `[ec2~ @outputs 8 @mc 1 @allocmode 2]`
- **With attrui** (Max inspector)
- **As simple messages**: `[message outputs 16(`

**Available attributes:**
- `@outputs` (int, 1-16, default: 2) - Number of output channels
- `@mc` (int, 0-1, default: 0) - Multichannel cable mode
- `@buffer` (symbol) - Source buffer name
- `@allocmode` (int, 0-6, default: 1) - Spatial allocation mode
- `@soundfile` (int, 0-15, default: 0) - Buffer index for polybuffer

### Parameters (OSC-style / prefix) - 97 total
Used for real-time performance control. Sent in 2 ways:
- **OSC-style messages**: `[message /grainrate 40(`, `[message /amplitude 0.5(`
- **FullPacket bundles** (odot): bidirectional OSC via rightmost outlet

**Format**: `/parameter_name <value>` (note the leading slash)

**Grain Scheduling (4):**
- `/grainrate` - Grain emission rate (Hz)
- `/async` - Asynchronicity
- `/intermittency` - Grain sparsity
- `/streams` - Number of grain streams

**Grain Characteristics (4):**
- `/duration` - Grain duration (ms)
- `/playback` - Playback rate/pitch
- `/amplitude` (or `/amp`) - Amplitude
- `/envelope` - Envelope shape

**Filtering (2):**
- `/filterfreq` - Filter cutoff frequency
- `/resonance` - Filter resonance

**Spatial (1):**
- `/pan` - Stereo panning

**Scanning (3):**
- `/scanstart` - Scan start position
- `/scanrange` - Scan range
- `/scanspeed` - Scan speed

**Spatial Allocation Parameters (12 messages):**
- `fixedchan` - Fixed channel number (1-16)
- `rrstep` - Round-robin step size
- `randspread` - Random spread amount
- `spatialcorr` - Spatial correlation
- `weights` - Per-channel probability weights (Weighted mode)
- `pitchmin` - Pitch-to-space minimum frequency
- `pitchmax` - Pitch-to-space maximum frequency
- `trajshape` - Trajectory shape (0-5)
- `trajrate` - Trajectory rate
- `trajdepth` - Trajectory depth
- `spiral_factor` - Spiral tightness (Trajectory mode)
- `pendulum_decay` - Pendulum damping (Trajectory mode)

**LFO Control (24 messages):**
- `lfo1shape` through `lfo6shape` - LFO waveforms (0-4)
- `lfo1rate` through `lfo6rate` - LFO frequencies (0.001-100 Hz)
- `lfo1polarity` through `lfo6polarity` - LFO polarities (0-2)
- `lfo1duty` through `lfo6duty` - LFO duty cycles (0.0-1.0)

**LFO Modulation Routing (special command messages):**
- `/lfo<N>_to_<parameter> <depth>` - Connect/update LFO to parameter (depth > 0.0) or disconnect (depth = 0.0)
- Each LFO can modulate up to 8 destinations simultaneously
- One parameter can only be controlled by one LFO (last message wins)
- Modulatable: 14 synthesis + 14 deviation + 9 spatial + 24 LFO params (61 total)

**Send as messages:**
```
[grainrate 50(                     // Single message
[grainrate 50, duration 200(       // Multiple messages
```

### Automatic OSC Output

ec2~ automatically sends **grain visualization data** through the rightmost outlet at regular intervals. This provides real-time insight into the granular synthesis engine state, following Curtis Roads' best practices for grain cloud visualization.

**Output format (OSC FullPacket bundle):**
```
/buffer_length_ms <float>      // Total buffer duration in milliseconds
/scan_window_start <float>     // Scan window start position (0.0-1.0)
/scan_window_end <float>       // Scan window end position (0.0-1.0)
/active_grains <int>           // Number of currently active grains
/grain_stats_rate <float>      // Current grain emission rate (Hz)
/grain_stats_duration <float>  // Average grain duration (ms)
```

**Example usage:**
```
[ec2~]
|
[o.display]  // Shows grain visualization data in real-time
```

**Note:** Parameter values are no longer output via OSC. Use the parameter window (double-click ec2~) for live parameter monitoring and editing.

### OSC Bundle Input

ec2~ accepts OSC bundles in FullPacket format (compatible with odot):

```
[o.compose /grainrate 100 /filterfreq 5000(
|
[o.pack]
|
[ec2~]  // Applies parameters from OSC bundle
```

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

### duration (float, 0.046-10000.0 ms, default: 100.0)
Grain duration in milliseconds.
- Ultra-short (0.046-1 ms): Extreme spectral/glitch effects
- Short (1-20 ms): Granular, spectral effects
- Medium (20-200 ms): Classic granular textures
- Long (200-1000 ms): Overlapping layers, ambient clouds
- Very long (1000-10000 ms): Sustained textures, drone clouds

### playback (float, -32.0-32.0, default: 1.0)
Playback rate / transposition.
- 1.0: Original pitch
- 2.0: One octave up
- 0.5: One octave down
- Negative values: Reverse playback

### amp (float, -180.0 to 48.0 dB, default: -6.0)
Overall amplitude in decibels (dBFS).
- -6 dB: Default level
- 0 dB: Unity gain
- -12 dB: Half amplitude
- -∞ to -60 dB: Very quiet
- Above 0 dB: Amplification (use with caution)

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

### filterfreq (float, 20.0-24000.0 Hz, default: 1000.0)
Filter center frequency in Hertz.
- **20-24000 Hz**: Bandpass filter applied to each grain
- The filter is a 3-stage biquad cascade with custom resonance curve
- Use with `resonance` parameter to control filter character

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

### scanrange (float, -1.0 to 1.0, default: 0.5)
Range of buffer to scan from start position.
- **Positive values (0 to 1)**: Scan forward through buffer
- **Negative values (-1 to 0)**: Scan backward through buffer
- Combined with `scanspeed`, enables complex scanning patterns including reverse motion

---

## Statistical/Probabilistic Deviation Parameters

Based on **Curtis Roads' theory of stochastic grain clouds** (Microsound, MIT Press, 2001), these parameters add random variation to grain parameters, creating organic and evolving textures. Each deviation parameter applies uniform random variation (±) to its corresponding base parameter for every grain.

**Philosophy**: Instead of all grains having identical parameters, each grain gets slightly randomized values. This creates natural variation, chorusing effects, and prevents "machine gun" artifacts.

**Example**:
```
grainrate 50           # Base grain rate: 50 Hz
grainrate_dev 10       # Each grain: 40-60 Hz (50 ± 10)
```

### grainrate_dev (float, 0-250 Hz, default: 0.0)
Random deviation for grain emission rate.
- **0**: All grains emitted at exact `grainrate` (static)
- **> 0**: Each grain's timing varies randomly
- **Use**: Creates irregular, breathing rhythms instead of mechanical timing
- **Curtis Roads**: "Temporal stochasticity prevents periodic artifacts"

**Example**:
```
grainrate 30           # Mean: 30 Hz
grainrate_dev 10       # Actual: 20-40 Hz per grain
```

### async_dev (float, 0.0-0.5, default: 0.0)
Random deviation for asynchronicity.
- Adds variation to grain stream independence
- Creates fluctuating degrees of temporal disorder
- **Use**: Morphing between synchronized and scattered grain clouds

### intermittency_dev (float, 0.0-0.5, default: 0.0)
Random deviation for intermittency (grain dropout probability).
- Varies the sparseness of grain emission
- Creates dynamic textural density changes
- **Use**: Evolving grain cloud density without parameter automation

### streams_dev (float, 0-10, default: 0.0)
Random deviation for number of grain streams.
- Integer deviation applied to stream count
- Creates variable polyphonic density
- **Use**: Fluctuating textural complexity

### playback_dev (float, 0-16, default: 0.0)
Random deviation for playback rate (pitch/speed).
- **Curtis Roads**: "Frequency dispersion enriches spectral content"
- Creates microtonal variation and spectral spreading
- **Use**: Natural ensemble/chorus effect, detune clusters

**Example**:
```
playback 1.0           # Base: original pitch
playback_dev 0.05      # Actual: 0.95-1.05 (±5 cents approx)
```

For richer detuning:
```
playback 1.0
playback_dev 0.2       # Actual: 0.8-1.2 (wider pitch spread)
```

### duration_dev (float, 0-5000 ms, default: 0.0)
Random deviation for grain duration.
- **Curtis Roads**: "Grain length variation prevents timbral homogeneity"
- Creates dynamic envelope complexity
- **Use**: More organic attack/release characteristics
- **Range**: Can vary up to ±5000ms to match full duration range

**Example**:
```
duration 100           # Base: 100ms grains
duration_dev 30        # Actual: 70-130ms per grain
```

### envelope_dev (float, 0.0-0.5, default: 0.0)
Random deviation for envelope shape.
- Varies between Hanning-like (0.0) and rectangular (1.0)
- Creates grain-to-grain spectral variation
- **Use**: Prevents uniform spectral characteristics

### pan_dev (float, 0.0-1.0, default: 0.0)
Random deviation for stereo panning position.
- Adds spatial width to grain clouds
- Creates stereo movement and spaciousness
- **Use**: Stereo spreading without fixed spatial positions

**Example**:
```
pan 0.0                # Base: center
pan_dev 0.3            # Actual: -0.3 to +0.3 (spread around center)
```

### amp_dev (float, 0.0-24.0 dB, default: 0.0)
Random deviation for amplitude in decibels.
- Creates dynamic level variation per grain
- Prevents uniform loudness perception
- **Use**: More natural amplitude envelope, shimmer effects

**Example**:
```
amp -6                 # Base: -6 dB
amp_dev 3              # Actual: -9 to -3 dB per grain
```

### filterfreq_dev (float, 0-12000 Hz, default: 0.0)
Random deviation for filter cutoff frequency.
- **Curtis Roads**: "Spectral randomization enriches timbre"
- Creates per-grain filter variation
- **Use**: Spectral movement and complexity

**Example**:
```
filterfreq 1000        # Base: 1000 Hz
filterfreq_dev 500     # Actual: 500-1500 Hz per grain
```

### resonance_dev (float, 0.0-0.5, default: 0.0)
Random deviation for filter resonance.
- Varies filter emphasis per grain
- Creates timbral complexity
- **Use**: Dynamic spectral character

### scanstart_dev (float, 0.0-0.5, default: 0.0)
Random deviation for scan start position.
- **Curtis Roads**: "Source position randomization creates timbral variation"
- Each grain reads from slightly different buffer location
- **Use**: Prevents repetitive timbral artifacts, creates textural movement

**Example**:
```
scanstart 0.5          # Base: middle of buffer
scanstart_dev 0.1      # Actual: 40-60% through buffer per grain
```

### scanrange_dev (float, 0.0-0.5, default: 0.0)
Random deviation for scan range.
- Varies the buffer window size per grain
- Creates dynamic source selection
- **Use**: Varying material density and diversity

### scanspeed_dev (float, 0-16, default: 0.0)
Random deviation for scan speed.
- Varies playback position movement rate
- Creates non-uniform scanning behavior
- **Use**: Organic buffer traversal patterns

---

## Statistical Parameters: Usage Guidelines

### Recommended Starting Values

**Subtle organic variation** (maintains recognizable base parameters):
```
duration_dev 10           # ±10% variation
playback_dev 0.05         # ±5% pitch variation
amp_dev 0.1               # ±10% amplitude variation
scanstart_dev 0.05        # ±5% position variation
```

**Moderate stochastic texture** (Curtis Roads' "grain cloud"):
```
grainrate_dev 15          # ±30% timing variation
duration_dev 30           # ±30% length variation
playback_dev 0.2          # ±20% pitch variation
filterfreq_dev 500        # ±500 Hz spectral variation
scanstart_dev 0.15        # ±15% position variation
```

**Extreme randomization** (chaotic, maximally varied):
```
grainrate_dev 50          # 100% timing variation
duration_dev 150          # 150% length variation
playback_dev 1.0          # ±100% pitch variation
amp_dev 0.3               # ±30% amplitude variation
scanstart_dev 0.3         # ±30% position variation
```

### OSC Control with odot

```
[o.compose
  /grainrate 50
  /grainrate_dev 10
  /duration 100
  /duration_dev 20
  /playback 1.0
  /playback_dev 0.1
]
|
[o.pack]
|
[ec2~]
```

### Theory Reference

These parameters implement Curtis Roads' concept of **stochastic synthesis**:

> "Rather than conceiving of grains as discrete note events, they are best
> understood as particles in a sonic cloud...Introducing randomness at the
> microscopic level generates organic timbral variation while maintaining
> macroscopic coherence." - Roads, *Microsound* (2001)

**Key principle**: Control the **statistical distribution** of grain populations, not individual grains.

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

#### fixedchan (message, int, 1-16, default: 1)
Target output channel number (user-facing 1-16, internally converted to 0-based indexing). Real-time message for dynamic control.

**Example:**
```
[message allocmode 0(
[message fixedchan 4(  // All grains to channel 4
```

---

## Mode 1: Round-robin

Cycles through channels in sequence, creating ordered spatial trajectories.

**Use cases:**
- Circular spatial movement
- Sequential speaker activation
- Rhythmic spatial patterns

### Parameters

#### rrstep (message, int, 1-16, default: 1)
Channel increment per grain. Real-time message for dynamic control.
- 1: Sequential (0→1→2→3→...)
- 2: Every other channel (0→2→4→6→...)
- N: Jump by N channels (wraps around)

**Examples:**
```
// Sequential rotation through all channels
[message allocmode 1(
[message rrstep 1(

// Jump by 3 channels
[message allocmode 1(
[message rrstep 3(
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

#### randspread (message, float, 0.0-1.0, default: 0.0)
Controls panning between adjacent channels. Real-time message for dynamic control.
- 0.0: Hard assignment to single channel
- > 0.0: Panning between adjacent channels
- 1.0: Full constant-power panning

#### spatialcorr (message, float, 0.0-1.0, default: 0.0)
Spatial correlation between successive grains. Real-time message for dynamic control.
- 0.0: Independent channel selection per grain
- 1.0: Strong tendency to remain near previous channel (spatial "stickiness")

**Examples:**
```
// Pure random, hard assignment
[message allocmode 2(
[message randspread 0.0(
[message spatialcorr 0.0(

// Random with smooth panning
[message allocmode 2(
[message randspread 0.7(
[message spatialcorr 0.3(  // Slight spatial correlation
```

**Theory:** Directly implements Roads's "random dispersion of grains among N channels". Most effective for relatively long grains and moderate densities.

---

## Mode 3: Weighted

Weighted random distribution with per-channel probability weights. Extends Mode 2 (Random) by adding per-channel weights while preserving randspread and spatialcorr behavior.

**Use cases:**
- Directional spatial focus (emphasize front over rear speakers)
- "Hot spots" in multichannel array (concentrate energy in specific zones)
- Asymmetric spatial fields (create weighted spatial probability maps)
- Simulate acoustic environments with preferred reflection zones

### Parameters

**Note:** Mode 3 shares `randspread` and `spatialcorr` parameters with Mode 2, and adds the `weights` parameter for per-channel probability control.

#### weights (message, list of floats, default: uniform)
**Message format:** `/weights <value1> <value2> ... <valueN>`

Array of per-channel probability weights. Each value corresponds to one channel (0-indexed).
- Values can be any positive number (internally clamped to >= 0.0)
- Automatically normalized so sum = 1.0 (you don't need to normalize manually)
- Number of values determines number of weighted channels

**Examples:**
```
// 4-channel setup: emphasize channels 0 and 1
[message /weights 0.5 0.3 0.1 0.1(     // Result: 50%, 30%, 10%, 10%

// Same result with unnormalized values (auto-normalized):
[message /weights 5 3 1 1(             // Result: 50%, 30%, 10%, 10%

// 8-channel setup: create "hot spot" on channels 3-4
[message /weights 0.1 0.1 0.1 1.0 1.0 0.1 0.1 0.1(

// Reset to uniform distribution (clear weights):
[message /weights(                     // Empty = uniform across all channels

// Combine with randspread and spatialcorr (shared with Mode 2):
[message allocmode 3(
[message /weights 0.5 0.3 0.1 0.1(     // Weight channels
[message /randspread 0.5(              // Add panning between adjacent channels
[message /spatialcorr 0.2(             // Add spatial correlation
```

**Note:** `randspread` and `spatialcorr` parameters (documented in Mode 2) apply equally to Mode 3, controlling panning and spatial correlation with weighted probabilities.

**Theory:** Allows concentration of grain probability on specific channels. Each channel has a weight determining its selection probability. This implements Roads's concept of "weighted spatial probability distributions" for creating focused or directional spatial textures.

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

#### pitchmin (message, float, 20.0-20000.0 Hz, default: 20.0)
Minimum pitch of mapping range (maps to leftmost channels). Real-time message for dynamic control.

#### pitchmax (message, float, 20.0-20000.0 Hz, default: 20000.0)
Maximum pitch of mapping range (maps to rightmost channels). Real-time message for dynamic control.

**Examples:**
```
// Low pitches left, high pitches right
[message allocmode 5(
[message pitchmin 100.0(
[message pitchmax 4000.0(
[message playback 1.0(  // Use playback rate to modulate pitch

// Narrow range for subtle spatial-spectral effects
[message allocmode 5(
[message pitchmin 440.0(
[message pitchmax 880.0(
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

#### trajshape (message, int, 0-5, default: 0)
Trajectory shape. Real-time message for dynamic control.
- **0**: Sine - Sinusoidal back-and-forth motion
- **1**: Saw - Linear sweep (sawtooth)
- **2**: Triangle - Linear back-and-forth
- **3**: Random walk - Constrained random movement
- **4**: Spiral - Circular motion with expanding/contracting radius (use with `spiral_factor`)
- **5**: Pendulum - Damped pendulum oscillation (use with `pendulum_decay`)

#### trajrate (message, float, 0.001-100.0 Hz, default: 0.5)
Speed of trajectory movement in Hertz. Real-time message for dynamic control.

#### trajdepth (message, float, 0.0-1.0, default: 1.0)
Proportion of channel array covered by trajectory. Real-time message for dynamic control.
- 1.0: Full array (all channels)
- 0.5: Center half of channels
- 0.25: Center quarter

#### spiral_factor (message, float, 0.0-1.0, default: 0.0)
Controls spiral tightness for trajshape=4 (Spiral). Real-time message for dynamic control.
- 0.0: Pure circular motion
- 1.0: Tight spiral motion

#### pendulum_decay (message, float, 0.0-1.0, default: 0.1)
Controls damping factor for trajshape=5 (Pendulum). Real-time message for dynamic control.
- 0.0: No damping (continuous oscillation)
- 1.0: Heavy damping (rapid decay)

**Examples:**
```
// Slow sine wave across all channels
[message allocmode 6(
[message trajshape 0(
[message trajrate 0.2(
[message trajdepth 1.0(

// Fast sweep across center channels only
[message allocmode 6(
[message trajshape 1(
[message trajrate 2.0(
[message trajdepth 0.5(

// Slow random walk
[message allocmode 6(
[message trajshape 3(
[message trajrate 0.1(
[message trajdepth 1.0(

// Spiral motion with medium tightness
[message allocmode 6(
[message trajshape 4(
[message trajrate 0.3(
[message spiral_factor 0.5(
[message trajdepth 1.0(

// Damped pendulum oscillation
[message allocmode 6(
[message trajshape 5(
[message trajrate 0.5(
[message pendulum_decay 0.3(
[message trajdepth 1.0(
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

**Note**: For LFO modulation routing, see the **LFO Modulation System** section which uses the `/lfo<N>_to_<parameter> <depth>` message format.
- Filtering: `filterfreq`, `resonance`
- Panning: `pan` (stereo mode only)
- Scanning: `scanstart`, `scanrange`, `scanspeed`

See the **LFO Modulation System** section for detailed examples and usage patterns.

### bang
Outputs the current parameter state as an OSC bundle through the rightmost outlet. Useful for debugging or sending state to other objects.

```
[bang(
|
[ec2~]
|
[print]   // Print OSC bundle to console
```

**Note**: Full OSC bundle output is currently limited - see OSC outlet documentation.

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

The OSC outlet automatically outputs grain visualization data at regular intervals (no bang required). This includes buffer info, scan window position, active grain count, and grain statistics. Use this for real-time visualization or routing grain state to other Max objects.


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

### showbuffer (Phase 13)
Opens Max's built-in buffer editor for the currently loaded buffer, allowing waveform viewing and editing.

```
[showbuffer(   // Open buffer editor window
```

This provides direct access to Max's waveform display and editing tools for the current buffer.

### dblclick (Phase 13)
Double-clicking the ec2~ object opens the **native parameter window**, which displays all 73 parameters in a live-editable table. This provides a quick way to view and adjust all synthesis parameters without typing messages.

The parameter window features:
- **Category**: Parameter grouping (Grain, Spatial, Modulation, etc.)
- **Parameter Name**: Full parameter name
- **Value**: Current value (editable - double-click to edit)
- **Range**: Valid min/max range for the parameter
- **Description**: Brief explanation of the parameter's function

**Note**: To access the buffer editor, use the `showbuffer` message instead.

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

## LFO Modulation System (Phase 9)

ec2~ includes 6 independent Low-Frequency Oscillators (LFOs) with a flexible routing matrix that allows modulation of **all 61 parameters** including synthesis parameters, deviation parameters, spatial allocation parameters, and even other LFO parameters. This enables complex, evolving textures and meta-modulation without external control signals.

### LFO Parameters (30 total)

Each LFO (LFO1 through LFO6) has 5 control parameters:

#### 1. Shape (lfo1shape - lfo6shape)
**Type:** message, int, 0-4, default: 0

**Values:**
- **0**: Sine wave - Smooth, periodic modulation
- **1**: Square wave - Abrupt switching between two values
- **2**: Rise (ascending sawtooth) - Linear upward ramp
- **3**: Fall (descending sawtooth) - Linear downward ramp
- **4**: Noise - Random sample-and-hold values

**Message format:** `/lfo1shape <value>`, `/lfo2shape <value>`, etc.

**Examples:**
```
[message /lfo1shape 0(      // Sine wave
[message /lfo2shape 4(      // Noise
```

#### 2. Rate (lfo1rate - lfo6rate)
**Type:** message, float, 0.001-100.0 Hz, default: 1.0

**Description:** Controls the frequency/speed of the LFO oscillation

**Message format:** `/lfo1rate <value>`, `/lfo2rate <value>`, etc.

**Examples:**
```
[message /lfo1rate 2.5(     // 2.5 Hz
[message /lfo2rate 0.1(     // 0.1 Hz (10 second cycle)
```

#### 3. Polarity (lfo1polarity - lfo6polarity)
**Type:** message, int, 0-2, default: 0

**Values:**
- **0**: Bipolar - Output range: -1.0 to +1.0
- **1**: Unipolar+ - Output range: 0.0 to +1.0
- **2**: Unipolar- - Output range: -1.0 to 0.0

**Message format:** `/lfo1polarity <value>`, `/lfo2polarity <value>`, etc.

**Examples:**
```
[message /lfo1polarity 0(   // Bipolar
[message /lfo2polarity 1(   // Unipolar+
```

#### 4. Duty Cycle (lfo1duty - lfo6duty)
**Type:** message, float, 0.0-1.0, default: 0.5

**Description:** For square wave shape only, controls the high/low time ratio
- 0.5 = 50% duty cycle (equal high/low times)
- 0.25 = 25% high, 75% low
- 0.75 = 75% high, 25% low

**Message format:** `/lfo1duty <value>`, `/lfo2duty <value>`, etc.

**Examples:**
```
[message /lfo1duty 0.5(     // 50% duty cycle
[message /lfo2duty 0.25(    // 25% duty cycle
```

**Note:** All LFO parameters can be sent via OSC-style messages or FullPacket bundles.

### Modulation Routing (Command Messages)

ec2~ uses a simplified single-message system to route LFO modulation to parameters. These are **special command messages**, NOT standard OSC parameters.

#### Routing Command Format

**Connect/Update or Disconnect an LFO:**
```
/lfo<N>_to_<parameter> <depth>
```
- `N` = LFO number (1-6)
- `parameter` = any of 61 modulatable parameters (see list below)
- `depth` = modulation depth (0.0-1.0)
  - **depth > 0.0**: Connect LFO to parameter (or update depth if already connected)
  - **depth = 0.0**: Disconnect LFO from parameter

**Examples:**
```
[message /lfo1_to_grainrate 1.0(      // Connect with full depth (100%)
[message /lfo1_to_filterfreq 0.7(     // Connect with 70% depth
[message /lfo2_to_amplitude 0.5(      // Connect with 50% depth
[message /lfo1_to_grainrate 0.0(      // Disconnect LFO1 from grainrate
[message /lfo1_to_filterfreq 0.3(     // Update existing connection to 30% depth
```

**Note:** The depth value directly controls the modulation intensity - there is no global depth parameter.

#### Routing Constraints

- Each LFO can modulate up to **8 destinations** simultaneously
- Each parameter can only be modulated by **ONE LFO** at a time ("last message wins")
  - If you map LFO2 to a parameter already controlled by LFO1, LFO1's connection is automatically removed
- LFOs cannot modulate their own parameters (e.g., `/lfo1_to_lfo1rate` is invalid)
- Cross-modulation IS allowed (e.g., `/lfo1_to_lfo2rate 0.5` is valid)

#### Modulatable Parameters (61 total)

**Synthesis Parameters (14)**:
- `grainrate`, `async`, `intermittency`, `streams`
- `playback`, `duration`, `envelope`, `amplitude`
- `filterfreq`, `resonance`
- `pan`, `scanstart`, `scanrange`, `scanspeed`

**Deviation Parameters (14)**:
- `grainrate_dev`, `async_dev`, `intermittency_dev`, `streams_dev`
- `playback_dev`, `duration_dev`, `envelope_dev`, `amp_dev`
- `filterfreq_dev`, `resonance_dev`
- `pan_dev`, `scanstart_dev`, `scanrange_dev`, `scanspeed_dev`

**Spatial Allocation Parameters (9)**:
- `fixedchan`, `rrstep`, `randspread`, `spatialcorr`
- `pitchmin`, `pitchmax`
- `trajshape`, `trajrate`, `trajdepth`

**LFO Parameters (24)** - Meta-modulation:
- `lfo1shape` through `lfo6shape` (cannot modulate self)
- `lfo1rate` through `lfo6rate` (cannot modulate self)
- `lfo1polarity` through `lfo6polarity` (cannot modulate self)
- `lfo1duty` through `lfo6duty` (cannot modulate self)

#### Routing Examples

**Basic Mapping**:
```
// Connect LFO1 to grainrate with full depth
[message /lfo1_to_grainrate 1.0(

// Connect LFO2 to filterfreq with 70% depth
[message /lfo2_to_filterfreq 0.7(

// Disconnect LFO1 from grainrate
[message /lfo1_to_grainrate 0.0(

// Update existing connection to new depth
[message /lfo2_to_filterfreq 0.5(
```

**Multiple LFO Connections**:
```
// Connect multiple parameters to LFO1
[message /lfo1_to_grainrate 1.0(
[message /lfo1_to_filterfreq 0.8(
[message /lfo1_to_pan 0.5(

// Each parameter has its own independent depth
// To reduce all modulation, adjust each depth individually
[message /lfo1_to_grainrate 0.5(
[message /lfo1_to_filterfreq 0.4(
[message /lfo1_to_pan 0.25(
```

**Multiple LFOs on Different Parameters**:
```
[message /lfo1shape 0(           // LFO1: Sine wave
[message /lfo1rate 0.5(          // LFO1: 0.5 Hz
[message /lfo1_to_grainrate 0.6(

[message /lfo2shape 4(           // LFO2: Random/noise
[message /lfo2rate 5(            // LFO2: 5 Hz
[message /lfo2_to_filterfreq 0.7(
```

**Modulating Deviation Parameters**:
```
// Slowly evolve texture density
[message /lfo3shape 0(           // Sine
[message /lfo3rate 0.1(          // Very slow (10s cycle)
[message /lfo3_to_grainrate_dev 0.8(
// Result: Grain rate deviation smoothly varies from tight to loose
```

**Meta-Modulation (LFO → LFO)**:
```
// LFO1 modulates LFO2's rate
[message /lfo1shape 0(           // Sine
[message /lfo1rate 0.2(          // 5s cycle
[message /lfo1_to_lfo2rate 0.5(

// LFO2 (with varying rate) modulates filter
[message /lfo2shape 0(
[message /lfo2rate 2.0(          // Base rate: 2 Hz
[message /lfo2_to_filterfreq 0.7(
// Result: Filter sweep rate changes periodically
```

**Complex Routing (Up to 8 destinations per LFO)**:
```
// LFO1 controls overall "energy" of multiple params
[message /lfo1_to_grainrate 0.5(
[message /lfo1_to_amplitude 0.6(
[message /lfo1_to_filterfreq 0.4(
[message /lfo1_to_streams 0.3(
[message /lfo1_to_scanspeed 0.5(
[message /lfo1_to_duration_dev 0.7(
[message /lfo1_to_pan_dev 0.8(
[message /lfo1_to_trajrate 0.4(
// Now LFO1 at max capacity (8 destinations)
```

#### Error Handling

**Max destinations reached**:
```
ec2~: ERROR: LFO1 has reached maximum destinations (8/8).
Current connections: grainrate, amplitude, filterfreq, streams, scanspeed, duration_dev, pan_dev, trajrate
To add a new destination, first disconnect one of these parameters.
```

**Parameter already mapped** (last message wins):
```
// This is now automatic - no error is generated
[message /lfo1_to_grainrate 0.5(    // LFO1 controls grainrate
[message /lfo2_to_grainrate 0.7(    // LFO2 takes over (LFO1 connection removed automatically)
```

**Self-modulation attempt**:
```
[message /lfo1_to_lfo1rate 1.0(
ec2~: ERROR: LFO1 cannot modulate its own parameters (attempted: lfo1rate)
```

**Restrictions**:
- Each parameter can only be modulated by ONE LFO at a time (last message wins)
- Each LFO can modulate up to 8 parameters simultaneously
- LFOs cannot modulate their own parameters (no LFO1→lfo1rate)
- Cross-modulation is allowed (LFO1→lfo2rate is valid)

### Musical Applications

**Slowly Evolving Texture Complexity**:
```
// Use slow LFO to modulate deviation parameters
[message /lfo1shape 0(                // Sine
[message /lfo1rate 0.05(              // 20s cycle
[message /lfo1_to_grainrate_dev 0.9(
[message /lfo1_to_duration_dev 0.8(
[message /lfo1_to_pan_dev 0.7(
// Texture smoothly morphs from regular to chaotic and back
```

**Rhythmic Pulsation with Variable Speed**:
```
// LFO1 varies the speed of LFO2's pulsation
[message /lfo1shape 2(                // Rise (sawtooth)
[message /lfo1rate 0.1(               // Very slow acceleration
[message /lfo1_to_lfo2rate 0.8(

// LFO2 creates rhythmic amplitude pulses
[message /lfo2shape 1(                // Square
[message /lfo2rate 2.0(               // Base: 2 Hz
[message /lfo2duty 0.2(               // Short pulses
[message /lfo2_to_amplitude 0.6(
// Result: Pulse rate accelerates over time
```

**Complex Spatial Movement**:
```
// Multiple LFOs control different spatial aspects
[message /lfo1_to_trajrate 0.5(      // Trajectory speed varies
[message /lfo2_to_trajdepth 0.7(     // Movement depth varies
[message /lfo3_to_randspread 0.6(    // Spatial spread varies
[message /lfo4_to_pan_dev 0.8(       // Stereo deviation varies
// Creates rich, unpredictable spatial behavior
```

### LFO Implementation Details

The LFO implementation is aligned with the original EmissionControl2 `ecModulator` behavior.

- **Always Running**: All 6 LFOs run continuously in the background at control rate
- **Modulation Formula**: `modulated = baseValue + (lfoValue × depth × (max - min))`
  - Example: grainrate with base=50, depth=0.5, range=[0.1, 500] → oscillates ±125 Hz around 50 Hz
- **Depth = 0**: No modulation applied - parameter remains at base value (guaranteed)
- **Rate ≈ 0**: Output becomes nearly constant (phase advances very slowly)
- **Phase Independence**: LFO phases are independent (no phase-locking)
- **Continuous Operation**: LFOs are not reset when changing parameters
- **CPU Usage**: Minimal overhead (~0.1% per active LFO on modern systems)

#### Waveform Behavior (Matches Original EC2)

| Shape | Bipolar (polarity=0) | Unipolar+ (polarity=1) | Unipolar- (polarity=2) |
|-------|---------------------|------------------------|------------------------|
| Sine (0) | [-1, +1] cosine wave | [0, +1] | [-1, 0] |
| Square (1) | [-1, +1] with duty cycle | [0, +1] or 0 | [-1, 0] or 0 |
| Rise (2) | [0, +1] ramp up* | [0, +1] | [0, -1] |
| Fall (3) | [+1, 0] ramp down* | [+1, 0] | [-1, 0] |
| Noise (4) | [-1, +1] sample-hold | [0, +1] sample-hold | [-1, 0] sample-hold |

*Note: Rise and Fall waveforms produce **unipolar** output [0,1] even in "bipolar" mode. This matches the original EC2 behavior where `upU()` and `downU()` from the Gamma library produce [0,1] ranges. This means:
- Rise + Bipolar: modulation goes from 0 to +depth×range (only positive offset)
- Fall + Bipolar: modulation goes from +depth×range to 0 (only positive offset, decreasing)

---

## OSC Parameter Control (Phase 10)

ec2~ supports OSC-style messages for parameter control, enabling integration with OSC-based workflows (odot, spat5, etc.).

### OSC Message Format

Send messages to inlet 0 in the format: `/parameter_name value`

**Examples**:
```
[message /grainrate 50(       // Set grain rate to 50 Hz
[message /filterfreq 1200(    // Set filter to 1200 Hz
[message /allocmode 2(        // Set allocation mode to random
[message /lfo1rate 0.5(       // Set LFO1 rate to 0.5 Hz
```

### Supported OSC Parameters

All attribute names can be used as OSC messages by adding a `/` prefix and using lowercase:

**Grain Scheduling**:
- `/grainrate`, `/async`, `/intermittency`, `/streams`

**Grain Characteristics**:
- `/playback`, `/duration`, `/envelope`, `/amp`

**Filtering**:
- `/filterfreq`, `/resonance`

**Panning**:
- `/pan`

**Scanning**:
- `/scanstart`, `/scanrange`, `/scanspeed`

**Buffer**:
- `/soundfile`

**Multichannel**:
- `/mc`, `/outputs`

**Spatial Allocation (mode)**:
- `/allocmode` - Spatial allocation mode (0-6)

**Spatial Allocation Parameters (real-time messages)**:
- `/fixedchan` - Fixed channel number 1-16 (mode 0)
- `/rrstep` - Round-robin step (mode 1)
- `/randspread` - Random spread amount (mode 2,3)
- `/spatialcorr` - Spatial correlation (mode 3)
- `/pitchmin`, `/pitchmax` - Pitch-to-space mapping range (mode 5)
- `/trajshape`, `/trajrate`, `/trajdepth` - Trajectory parameters (mode 6)

**LFO Parameters**:
- `/lfo1rate`, `/lfo2rate`, `/lfo3rate`, `/lfo4rate`, `/lfo5rate`, `/lfo6rate`
- (All other LFO attributes also supported)

### OSC Integration Example

```
// Using odot
[o.route /ec2]
|
[o.pack /grainrate /filterfreq]
|
[message /grainrate 30 /filterfreq 800(
|
[ec2~]
```

**Note**: ec2~ accepts OSC messages directly - you don't need o.route for simple parameter setting. OSC format is simply a convenient naming convention.

---

## Dynamic Outlet Management

ec2~ supports **dynamic outlet recreation** - the number and type of outlets can be changed at runtime by modifying the `@outputs` or `@mc` attributes. This is a unique feature enabled by the Max SDK implementation.

### How It Works

When you change `@outputs` or `@mc`:
1. All existing outlets are deleted
2. New outlets are created with the updated configuration
3. Max automatically updates the visual representation in your patcher
4. **Important**: Any connected patch cords will be disconnected and need to be reconnected

### Dynamic Changes Examples

**Example 1: Change channel count**
```
// Start with stereo
[ec2~ @outputs 2 @mc 0]

// Later: expand to 8 channels (message box)
[message outputs 8(
|
[ec2~]

// Result: Object now has 8 separate signal outlets + 1 OSC outlet
```

**Example 2: Switch between separated and MC cable**
```
// Start with 4 separated outputs
[ec2~ @outputs 4 @mc 0]

// Switch to multichannel cable
[message mc 1(
|
[ec2~]

// Result: Now has 1 MC outlet (carrying 4 channels) + 1 OSC outlet
```

**Example 3: Complete reconfiguration**
```
// Start with 2 separated outputs
[ec2~ @outputs 2 @mc 0]

// Reconfigure to 16-channel MC cable
[message outputs 16, mc 1(
|
[ec2~]

// Result: 1 MC outlet with 16 channels + 1 OSC outlet
```

### Best Practices for Dynamic Outlets

1. **Initial Setup**: Set `@outputs` and `@mc` at object creation when possible to avoid reconnecting cables
2. **Reconnect Cables**: After changing outlet configuration, reconnect any audio cables
3. **Live Performance**: Avoid changing outlet configuration during performance (causes audio glitches)
4. **Preset Management**: When using presets, ensure `@outputs` and `@mc` are saved/recalled consistently

---

## Future Enhancements (Not Yet Implemented)

- Cluster/mask for channel subset selection
- Weight arrays for weighted mode (requires list/array message handling)
- Distance-based 3D spatialization
- Per-stream spatial allocation
- Buffer~ change notifications (automatic reload on buffer~ modification)

---

## Credits

**Author:** Alessandro Anatrini
**License:** GPL-3.0
**Based on:** EmissionControl2 by the AlloSphere Research Group
**Theoretical Foundation:** Curtis Roads, "Microsound" (MIT Press, 2001)

**Repository:** https://github.com/anatrini/max-emission-control
