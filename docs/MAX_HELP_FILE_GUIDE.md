# Max Help File Structure Guide for ec2~

This document outlines the recommended structure for creating the ec2~.maxhelp file following Max/MSP best practices.

## Help File Naming Convention
- **Filename**: `ec2~.maxhelp` (must match external name exactly)
- **Location**: `help/` directory in the package (or same directory as external for development)

## Standard Max Help File Structure

Max help files follow a consistent visual and organizational structure that users expect. Here's the recommended layout for ec2~:

---

## Section 1: Header (Top Banner)
**Visual**: Colored banner with object name and tagline
**Content**:
```
┌─────────────────────────────────────────────────────────┐
│ ec2~                                                    │
│ Multichannel Granular Synthesis                        │
│                                                         │
│ High-density granular synthesis with spatial           │
│ allocation, LFO modulation, and signal-rate inputs     │
└─────────────────────────────────────────────────────────┘
```

**Implementation**:
- Use `panel` object with colored background
- Use `comment` objects for text
- Standard colors: Light blue/gray background, black text

---

## Section 2: Basic Description
**Purpose**: One-sentence description of what the object does

**Content**:
```
ec2~ is a granular synthesis engine that distributes up to 2048
simultaneous grain voices across 16 output channels using seven
spatial allocation modes.
```

**Implementation**:
- `comment` object with clear, concise text
- 12-14pt font

---

## Section 3: Quick Start / Basic Patch
**Purpose**: Minimal working example users can try immediately

**Content**:
```
┌──────────────────────────────────────┐
│ [loadbang]                           │
│ |                                    │
│ [read mysound]                       │
│ |                                    │
│ [ec2~ @outputs 2]                    │
│ |            |                       │
│ [dac~ 1 2]                          │
│                                      │
│ Double-click ec2~ to view waveform  │
└──────────────────────────────────────┘
```

**Implementation**:
- Actual working Max patch
- Include audio source (buffer~ with sample)
- Add `loadmess` to set initial parameters
- Keep it minimal (< 10 objects)

---

## Section 4: Inlets and Outlets
**Purpose**: Document all inlets and outlets with data types

**Layout**:
```
INLETS:
  Inlet 1 (signal): Scan position (0.0-1.0, overrides @scanstart)
  Inlet 2 (signal): Grain rate in Hz (overrides @grainrate)
  Inlet 3 (signal): Playback rate (overrides @playback)
  Inlet 0 (message): Messages and attributes

OUTLETS:
  Outlets 1-N (signal): Audio outputs (N = @outputs setting)
  Rightmost outlet: OSC bundle output (parameter state)
```

**Implementation**:
- Use `comment` objects
- Consider using `inlet~` and `outlet~` visual indicators
- Monospace font for clarity

---

## Section 5: Arguments
**Purpose**: Document object box arguments

**Content**:
```
ARGUMENTS:
  None (all configuration via attributes)
```

**Alternative format** if you want to support argument:
```
ARGUMENTS:
  1. num_outputs (int, optional): Number of output channels (1-16, default: 2)
     Example: [ec2~ 8] creates an 8-channel output
```

---

## Section 6: Attributes (Organized by Category)

### 6.1 Output Configuration
```
@outputs (int, 1-16, default: 2)
  Number of output channels

@mc (int, 0-1, default: 0)
  Output mode: 0=separated outputs, 1=multichannel cable
```

### 6.2 Grain Scheduling
```
@grainrate (float, 0.1-500.0, default: 20.0)
  Grain emission rate in Hz

@async (float, 0.0-1.0, default: 0.0)
  Timing randomization

@intermittency (float, 0.0-1.0, default: 0.0)
  Emission probability

@streams (int, 1-20, default: 1)
  Number of independent grain streams
```

### 6.3 Grain Characteristics
```
@duration (float, 1.0-1000.0, default: 100.0)
  Grain duration in milliseconds

@playback (float, -32.0-32.0, default: 1.0)
  Playback rate / transposition

@envelope (float, 0.0-1.0, default: 0.5)
  Envelope shape

@amp (float, 0.0-1.0, default: 0.5)
  Overall amplitude
```

### 6.4 Filtering
```
@filterfreq (float, 20.0-22000.0, default: 22000.0)
  Filter cutoff frequency (22000 = bypass)

@resonance (float, 0.0-1.0, default: 0.0)
  Filter resonance
```

### 6.5 Scanning
```
@scanstart (float, 0.0-1.0, default: 0.0)
  Scan start position

@scanrange (float, 0.0-1.0, default: 1.0)
  Scan range

@scanspeed (float, -32.0-32.0, default: 1.0)
  Scan speed
```

### 6.6 Spatial Allocation
```
@allocmode (int, 0-6, default: 2)
  Spatial allocation mode:
    0 = Fixed channel
    1 = Round-robin
    2 = Random uniform
    3 = Weighted random
    4 = Load-balance
    5 = Pitch-map
    6 = Trajectory

[Mode-specific attributes documented in subsections]
```

### 6.7 Buffer Management
```
@buffer (symbol, default: "")
  Buffer~ name to use as audio source

@soundfile (int, 0-15, default: 0)
  Buffer index for polybuffer~ selection
```

**Implementation**:
- Use `attrui` objects for interactive attributes
- Group related attributes together
- Use color coding for categories
- Add `comment` labels for each section

---

## Section 7: Messages
**Purpose**: Document all message handlers

**Content**:
```
MESSAGES:

clear
  Stops all active grains immediately

read <buffer_name>
  Loads specified buffer~ as audio source
  Example: [read mysound(

polybuffer <basename> <count>
  Loads multiple buffers from polybuffer~
  Example: [polybuffer sounds 8(

modroute <param> <lfo_num> [depth]
  Routes LFO to parameter
  Example: [modroute grainrate 1 0.5(

waveform
  Reports buffer info to console

openbuffer
  Opens Max buffer editor for current buffer

dblclick
  Double-click object to open buffer editor

bang
  Outputs current parameter state as OSC bundle
```

**Implementation**:
- Use `message` objects for each message type
- Add example patches showing usage
- Connect to actual ec2~ instance for testing

---

## Section 8: LFO System
**Purpose**: Dedicated section for LFO modulation

**Content**:
```
LFO MODULATION SYSTEM:

ec2~ includes 6 independent LFOs that can modulate any parameter.

LFO Configuration:
  lforate <1-6> <hz>        Set LFO frequency
  lfoshape <1-6> <0-5>      Set LFO waveform:
                             0=sine, 1=triangle, 2=square,
                             3=saw up, 4=saw down, 5=random
  lfosymmetry <1-6> <0-1>   Set waveform symmetry

Modulation Routing:
  modroute <param> <lfo> <depth>

  Example: [modroute grainrate 1 0.5(
    Routes LFO 1 to grain rate with 50% depth

Modulatable Parameters:
  - Grain scheduling: grainrate, async, intermittency, streams
  - Grain characteristics: playback, duration, envelope, amp
  - Filtering: filterfreq, resonance
  - Scanning: scanstart, scanrange, scanspeed
  - Spatial: pan
```

**Implementation**:
- Example patch showing LFO routing
- Visual representation of LFO waveforms
- Demonstrate parameter modulation with scope~

---

## Section 9: Signal-Rate Inputs
**Purpose**: Explain signal inlet functionality

**Content**:
```
SIGNAL INPUTS (CV-Style Control):

Inlet 1: Scan Position (0.0-1.0)
  Per-sample buffer position control
  Overrides @scanstart when connected

  Example:
    [phasor~ 0.5]  ← Scan through buffer at 0.5 Hz
    |
    [ec2~]

Inlet 2: Grain Rate (Hz)
  Control-rate grain emission frequency
  Overrides @grainrate when connected

  Example:
    [phasor~ 0.1]
    |
    [*~ 40]
    |
    [+~ 10]  ← Modulate between 10-50 Hz
    |
    [ec2~]

Inlet 3: Playback Rate
  Per-grain transposition control
  Overrides @playback when connected

  Example:
    [mtof]
    |
    [/ 440]  ← Convert MIDI to playback rate
    |
    [sig~]
    |
    [ec2~]

Notes:
  - Signal inputs override attributes only when connected
  - Falls back to attributes + LFO when disconnected
  - Fully backward compatible
```

**Implementation**:
- Working example patches for each inlet
- Show signal flow with actual connections
- Demonstrate with `scope~` to visualize signals

---

## Section 10: OSC Integration
**Purpose**: Document OSC input/output workflow

**Content**:
```
OSC INTEGRATION (odot/spat5 compatible):

Input: OSC-style messages
  [/grainrate 30(  ← Send to ec2~
  [/playback 1.5(

Output: OSC bundle (rightmost outlet)
  [bang(  ← Triggers parameter state output
  |
  [ec2~]
  |
  [o.display]  ← Visualize with odot

Compatible with:
  - o.route for parameter routing
  - spat5 for spatial audio
  - odot library for OSC formatting

Example workflow with spat5:
  [ec2~ @outputs 8 @allocmode 6]
  |
  [spat5.spat~ @speakers 8]
  |
  [dac~ 1 2 3 4 5 6 7 8]
```

**Implementation**:
- Include odot objects (if available)
- Show spat5 integration example
- Demonstrate parameter state output

---

## Section 11: Example Patches

### 11.1 Dense Spatial Cloud
```
Demonstrates: High grain density with spatial distribution

Parameters:
  @grainrate 40
  @duration 80
  @async 0.3
  @allocmode 2 (random)
  @outputs 8
```

### 11.2 Rhythmic Granulation
```
Demonstrates: LFO-modulated grain rate for rhythmic patterns

Setup:
  - LFO 1 modulating grain rate
  - LFO 2 modulating playback rate
  - Fixed channel allocation
```

### 11.3 Spectral Freezing
```
Demonstrates: Very short grains at high density

Parameters:
  @grainrate 200
  @duration 10
  @playback 1.0
  @filterfreq 5000
```

### 11.4 Signal-Driven Scanning
```
Demonstrates: Audio-rate scan position control

Setup:
  - Phasor~ into scan inlet
  - Creates time-stretching effect
```

**Implementation**:
- Each example as a working subpatcher
- `bpatcher` or `pcontrol` for organization
- Include audio examples with `buffer~`

---

## Section 12: Tips and Techniques

**Content**:
```
WORKFLOW TIPS:

1. Start Simple
   - Begin with default settings
   - Load a buffer with [read(
   - Gradually increase grain rate

2. Managing CPU
   - Monitor active voices (outlets report count)
   - Lower grain rate for dense textures
   - Use intermittency to thin clouds

3. Spatial Design
   - Mode 2 (random) for diffuse textures
   - Mode 6 (trajectory) for motion
   - Mode 5 (pitchmap) for spectral distribution

4. LFO Modulation
   - Start with low modulation depth (0.1-0.3)
   - Use slow LFO rates for evolving textures
   - Fast LFOs create timbral variation

5. Signal Inputs
   - Scan position: Great for scrubbing/timestretch
   - Grain rate: Tempo-sync with clock signals
   - Playback rate: Melodic sequences with MIDI

6. Buffer Editor
   - Double-click ec2~ to view/edit waveform
   - Use [waveform( message for buffer analysis
```

---

## Section 13: See Also

**Content**:
```
SEE ALSO:

Max Native Objects:
  - groove~ (buffer playback)
  - play~ (buffer playback)
  - buffer~ (audio storage)
  - polybuffer~ (multiple buffers)

Granular Objects:
  - grans~ (if available)
  - munger~ (if available)

Spatial Audio:
  - spat5.spat~ (spatial rendering)
  - mc.* (multichannel objects)

Modulation:
  - cycle~ (LFO generation)
  - phasor~ (ramp generation)

OSC:
  - o.* (odot library)
  - OSC-route
```

**Implementation**:
- Use `live.text` or `textbutton` for clickable links
- Links should open help files for listed objects

---

## Section 14: Technical Information

**Content**:
```
TECHNICAL SPECS:

Voice Architecture:
  - 2048 simultaneous grain voices
  - Efficient voice stealing (oldest first)
  - Per-grain envelope, filter, panning

Output Configuration:
  - Up to 16 output channels
  - Separated or multichannel cable mode
  - Dynamic channel allocation

Buffer Support:
  - buffer~ integration
  - polybuffer~ for multiple files (up to 16)
  - All standard audio formats via Max

Modulation:
  - 6 independent LFOs
  - 14 modulatable parameters
  - 5 waveform types per LFO

Signal Inputs:
  - 3 signal inlets for CV-style control
  - Per-sample scan position
  - Control-rate grain rate
  - Per-grain playback rate

Performance:
  - Optimized for real-time performance
  - Automatic voice count compensation
  - Sample-accurate grain timing
```

---

## Section 15: Credits and License

**Content**:
```
CREDITS:

ec2~ is a Max/MSP port of EmissionControl2
Original EmissionControl2 by Curtis Roads, Greg Surges, et al.
Max/MSP port: Alessandro Anatrini

Based on granular synthesis principles from Curtis Roads's
"Microsound" (MIT Press, 2001)

LICENSE:
GPL-3.0

REFERENCES:
Roads, C. (2001). Microsound. MIT Press.
```

---

## Visual Design Guidelines

### Color Scheme
- **Header banner**: Light blue/gray (#E8F4F8 or similar)
- **Section dividers**: Thin gray lines
- **Category backgrounds**: Very light colors for grouping
- **Text**: Black on light background for readability

### Typography
- **Headers**: 14-16pt bold
- **Body text**: 11-12pt regular
- **Code/examples**: 11pt monospace
- **Comments**: 10pt italic

### Layout
- **Margins**: At least 10 pixels around all sections
- **Spacing**: 20-30 pixels between major sections
- **Alignment**: Left-align text, center-align headers
- **Width**: ~800 pixels max for comfortable reading

### Interactive Elements
- **Working patches**: All examples should be functional
- **Live controls**: Use `attrui`, `live.dial`, etc. for real-time parameter adjustment
- **Visual feedback**: Include `meter~`, `scope~`, `multislider` where helpful

---

## Development Workflow

### 1. Create Basic Structure
Start with the skeleton using `comment` and `panel` objects

### 2. Add Working Patches
Build functional examples with real audio

### 3. Test All Examples
Verify every patch works as documented

### 4. Polish Visual Design
Apply color scheme, align elements, adjust spacing

### 5. Cross-Reference
Ensure all attribute names match the actual implementation

### 6. User Testing
Have someone unfamiliar with the object try to use it with only the help file

---

## Recommended Help File Organization

```
Vertical layout (scroll down):

┌────────────────────────────────────┐
│ 1. Header                          │  ← Always visible
├────────────────────────────────────┤
│ 2. Description                     │
├────────────────────────────────────┤
│ 3. Quick Start Patch               │  ← Try immediately
├────────────────────────────────────┤
│ 4. Inlets/Outlets                  │
├────────────────────────────────────┤
│ 5. Arguments                       │
├────────────────────────────────────┤
│ 6. Attributes (by category)        │  ← Largest section
│    - Output                        │
│    - Grain Scheduling              │
│    - Grain Characteristics         │
│    - Filtering                     │
│    - Scanning                      │
│    - Spatial Allocation            │
│    - Buffer                        │
├────────────────────────────────────┤
│ 7. Messages                        │
├────────────────────────────────────┤
│ 8. LFO System                      │
├────────────────────────────────────┤
│ 9. Signal Inputs                   │
├────────────────────────────────────┤
│ 10. OSC Integration                │
├────────────────────────────────────┤
│ 11. Example Patches                │  ← Multiple subpatchers
├────────────────────────────────────┤
│ 12. Tips & Techniques              │
├────────────────────────────────────┤
│ 13. See Also                       │
├────────────────────────────────────┤
│ 14. Technical Info                 │
├────────────────────────────────────┤
│ 15. Credits                        │
└────────────────────────────────────┘
```

---

## Testing Checklist

Before finalizing the help file:

- [ ] All example patches work correctly
- [ ] All attribute names match implementation
- [ ] All message names are correct
- [ ] Signal inlets are properly documented
- [ ] Visual design is consistent
- [ ] No spelling errors
- [ ] All links work (See Also section)
- [ ] File is saved as `ec2~.maxhelp`
- [ ] Help file appears when user types "n" on `ec2~` object
- [ ] Tested on both Mac and Windows (if applicable)

---

## Summary

A good Max help file is:
1. **Immediately useful** - Quick start example at the top
2. **Comprehensive** - Documents every feature
3. **Well-organized** - Logical flow from simple to advanced
4. **Visually clear** - Consistent design, good spacing
5. **Interactive** - Working examples, not just text
6. **Accurate** - Matches actual implementation exactly

The investment in a quality help file pays dividends in user adoption and reduces support burden.
