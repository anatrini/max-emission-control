# Complete Inventory of ec2_tilde.cpp.mindevkit.backup

**File**: `source/ec2_tilde/ec2_tilde.cpp.mindevkit.backup`
**Lines**: 2016 lines
**Status**: Contains ALL original functionality

---

## CRITICAL: What Was Lost in My Rewrite

The new file I created (912 lines) is **INCOMPLETE**. The backup has:

### 1. Attributes (50+ attributes)
Lines ~227-760 contain all attributes:

#### Output Configuration
- `@mc` - Multichannel mode
- `@outputs` - Number of outputs (1-16)
- `@out` - OSC output format

#### Buffer Management
- `@buffer` - Buffer name (line ~661)

#### Spatial Allocation (Lines ~495-580)
- `@allocmode` - Allocation mode (0-6)
  - 0 = Fixed
  - 1 = Round-robin
  - 2 = Random
  - 3 = Weighted
  - 4 = Load-balance
  - 5 = Pitch-map
  - 6 = Trajectory
- `@fixedchan` - Fixed channel for Fixed mode
- `@rrstep` - Round-robin step
- `@randspread` - Random spread
- `@spatialcorr` - Spatial correlation
- `@pitchmin`, `@pitchmax` - Pitch map range
- `@trajshape` - Trajectory shape
- `@trajrate` - Trajectory rate
- `@trajdepth` - Trajectory depth

#### LFO System (Lines ~580-760) - 6 LFOs × 4 params = 24 attributes
- `@lfo1shape`, `@lfo2shape`, ..., `@lfo6shape` - LFO shape (0-4)
  - 0 = Sine
  - 1 = Triangle
  - 2 = Square
  - 3 = Sawtooth
  - 4 = Random
- `@lfo1rate`, `@lfo2rate`, ..., `@lfo6rate` - LFO frequency (0.001-100 Hz)
- `@lfo1polarity`, ..., `@lfo6polarity` - Polarity (0-2)
  - 0 = Bipolar (-1 to +1)
  - 1 = Unipolar (0 to 1)
  - 2 = Inverted (-1 to 0)
- `@lfo1duty`, ..., `@lfo6duty` - Duty cycle (0.0-1.0)

### 2. Messages (50+ message handlers)
Lines ~260-808

#### Synthesis Parameters
- `grainrate`, `async`, `intermittency`, `streams`
- `playback`, `duration`, `envelope`
- `scanstart`, `scanrange`, `amplitude`
- `filterfreq`, `resonance`, `pan`, `scanspeed`

#### Deviation Parameters (14 parameters)
- `grainrate_dev`, `async_dev`, `intermittency_dev`, `streams_dev`
- `playback_dev`, `duration_dev`, `envelope_dev`, `pan_dev`
- `amp_dev`, `filterfreq_dev`, `resonance_dev`
- `scanstart_dev`, `scanrange_dev`, `scanspeed_dev`

#### LFO Messages (24 messages - 6 LFOs × 4 params)
- `lfo1shape`, `lfo1rate`, `lfo1polarity`, `lfo1duty`
- `lfo2shape`, `lfo2rate`, `lfo2polarity`, `lfo2duty`
- ... through lfo6

#### Control Messages
- `clear` - Stop all grains
- `bang` - Send OSC bundle
- `buffer` - Load buffer

### 3. Signal Inlets (Lines ~214-218)
```cpp
inlet<> scan_in{this, "(signal) Scan position (0.0-1.0, overrides @scanstart)"};
inlet<> rate_in{this, "(signal) Grain rate in Hz (overrides @grainrate)"};
inlet<> playback_in{this, "(signal) Playback rate (overrides @playback)"};
```

### 4. DSP Setup (Lines ~789-808, ~1148-1198)
```cpp
message<> dspsetup{
    this, "dspsetup",
    MIN_FUNCTION{
        setupDSP();
        c74::max::object_method(maxobj(), c74::max::gensym("dsp_add64"),
            maxobj(), perform64_static, 0, this);
        return {};
    }
};

void perform64(double **ins, long numins, double **outs, long numouts, long sampleframes) {
    // Processes signal inlets
    // Updates engine parameters
    // Calls engine->process()
    // Outputs to all channels
}
```

### 5. OSC Parsing (Lines ~1203-1519)
```cpp
void parseOSCBundle(const unsigned char* data, size_t size);  // Line 1203
void parseOSCMessage(const unsigned char* data, size_t size); // Line 1258
void handleOSCParameter(const std::string &param_name, const atom &value); // Line 1522
```

### 6. OSC Output (Lines ~1692-1936)
```cpp
void writeOSCMessage(std::vector<unsigned char>& buffer, const std::string& address, float value);
void writeOSCMessageString(std::vector<unsigned char>& buffer, const std::string& address, const std::string& value);
void sendOSCBundle(); // Sends ALL parameters as FullPacket
```

### 7. Graphics/Waveform Display (Phase 13)
Lines ~820-1140 contain complete UI implementation:
- `paint` method for waveform rendering
- `mousedrag`, `mousedown`, `mouseup` handlers
- `getcellrect` for patcher display
- Buffer waveform visualization
- Double-click to open buffer editor

### 8. Outlet Creation (Lines ~1943-1983)
```cpp
void createOutlets() {
  auto max_obj = (c74::max::t_object *)maxobj();

  m_osc_outlet = c74::max::outlet_new(max_obj, nullptr);

  if (m_mc_mode == 1) {
    // MC mode: Create m_outputs signal outlets
    for (int i = 0; i < m_outputs; ++i) {
      void *sig_outlet = c74::max::outlet_new(max_obj, "signal");
      m_signal_outlets.push_back(sig_outlet);
    }
  } else {
    // Separated mode: Create N separate signal outlets
    for (int i = m_outputs - 1; i >= 0; --i) {
      void *sig_outlet = c74::max::outlet_new(max_obj, "signal");
      m_signal_outlets.insert(m_signal_outlets.begin(), sig_outlet);
    }
  }
}

void recreateOutlets(); // Line 1969 - Deletes and recreates outlets
```

### 9. Parameter Update System (Lines ~1452-1519)
```cpp
void updateEngineParameters() {
  ec2::SynthParameters params;

  // All 14 base parameters
  // All 14 deviation parameters
  // Spatial allocation configuration
  // LFO modulation routing

  m_engine->updateParameters(params);
}
```

### 10. Helper Functions
- `getOutputChannelCount()` - Line 1407
- `getModulationParameters()` - Line 1415 (maps param names to modulation targets)

---

## THREE ISSUES TO FIX (Only These!)

### Issue 1: FullPacket from udpreceive not working
**Location**: Lines 174-212
**Problem**: Min-DevKit `message<>` wrapper causes timing delay
**Fix**: Replace with Max SDK `class_addmethod` registration at ext_main

Current code (WRONG):
```cpp
message<> fullpacket{
    this, "FullPacket",
    MIN_FUNCTION{
        // Extract and parse...
    }
};
```

Needed fix (at ext_main in wrapper):
```cpp
class_addmethod(c, (method)fullpacket_handler, "FullPacket", A_GIMME, 0);

static void fullpacket_handler(void *x, t_symbol *s, long argc, t_atom *argv) {
    // Get ec2_tilde instance from Min wrapper
    // IMMEDIATELY copy buffer
    // Parse OSC
}
```

### Issue 2: No audio output
**Location**: Lines ~789-808 (dspsetup), Lines ~1148-1198 (perform64)
**Problem**: DSP chain not properly registered
**Current**: Uses Min-DevKit dspsetup message
**Needed**: Verify `dsp_add64` is called correctly

### Issue 3: MC mode not working
**Location**: Lines ~1943-1966 (createOutlets)
**Problem**: Creates multiple "signal" outlets instead of ONE "multichannelsignal"
**Current Code**:
```cpp
if (m_mc_mode == 1) {
  // Creates m_outputs separate signal outlets
  for (int i = 0; i < m_outputs; ++i) {
    void *sig_outlet = c74::max::outlet_new(max_obj, "signal");
    m_signal_outlets.push_back(sig_outlet);
  }
}
```

**Needed Fix** (from spat5 decompilation):
```cpp
if (m_mc_mode == 1) {
  // Create ONE multichannelsignal outlet
  void *sig_outlet = c74::max::outlet_new(max_obj, "multichannelsignal");
  m_signal_outlets.push_back(sig_outlet);
  c74::max::object_attr_setlong(sig_outlet, c74::max::gensym("chans"), m_outputs);
}
```

**ALSO NEEDED**: Register multichanneloutputs method:
```cpp
// At ext_main in Min wrapper
class_addmethod(c, (method)multichanneloutputs_handler, "multichanneloutputs", A_CANT, 0);

static long multichanneloutputs_handler(void *x, long index) {
    // Get ec2_tilde instance
    if (index == 0 && x->m_mc_mode == 1) {
        return x->m_outputs;
    }
    return 0;
}
```

---

## CRITICAL APPROACH

**DO NOT rewrite the file!**

Only make these surgical changes:

1. Keep ALL 2016 lines
2. Fix createOutlets() MC branch (lines ~1953-1958)
3. Add multichanneloutputs method to Min-DevKit wrapper
4. Fix FullPacket timing by adding direct Max SDK handler to wrapper
5. Verify dspsetup registration

---

## Min-DevKit Architecture

The backup uses **Min-DevKit C++ wrapper** which generates Max SDK code automatically:

```cpp
class ec2_tilde : public object<ec2_tilde> {
    // Min-DevKit class
};

MIN_EXTERNAL(ec2_tilde);  // This macro creates ext_main and class registration
```

The wrapper handles:
- `ext_main` generation
- `class_new` and `class_register`
- Attribute registration
- Message handler registration

We need to **extend** the wrapper, not replace it!

---

## File Structure

```
Lines 1-82: Includes and buffer helper
Lines 83-139: Class declaration start, member variables
Lines 140-171: Constructor
Lines 173-212: FullPacket handler (NEEDS FIX)
Lines 214-222: Signal inlets
Lines 227-760: All attributes (50+)
Lines 762-808: All messages (50+)
Lines 810-1140: Graphics/UI (paint, mouse handlers)
Lines 1142-1198: DSP methods (setupDSP, perform64)
Lines 1200-1404: OSC parsing
Lines 1406-1519: Helper functions (updateEngineParameters, etc.)
Lines 1521-1690: Parameter handlers
Lines 1692-1936: OSC output (writeOSCMessage, sendOSCBundle)
Lines 1938-1983: Outlet management (createOutlets, recreateOutlets) (NEEDS FIX)
Lines 1985-1988: Class closing and MIN_EXTERNAL
Lines 1990-2016: (empty/end)
```

---

## Next Session Action Plan

1. **Restore backup file**:
   ```bash
   cp source/ec2_tilde/ec2_tilde.cpp.mindevkit.backup source/ec2_tilde/ec2_tilde.cpp
   ```

2. **Fix MC outlets** (line ~1953):
   ```cpp
   if (m_mc_mode == 1) {
       void *sig_outlet = c74::max::outlet_new(max_obj, "multichannelsignal");
       m_signal_outlets.push_back(sig_outlet);
       c74::max::object_attr_setlong(sig_outlet, c74::max::gensym("chans"), m_outputs);
   }
   ```

3. **Add multichanneloutputs method** - Need to extend Min-DevKit wrapper or add custom Max SDK method

4. **Fix FullPacket timing** - Add immediate copy in handler or register custom Max SDK handler

5. **Build and test**

---

## Files Status

- ✅ `ec2_tilde.cpp.mindevkit.backup` - Original 2016 lines with ALL functionality
- ✅ `ec2_tilde_fullbackup.cpp` - Additional backup copy
- ❌ `ec2_tilde.cpp` (current) - Incomplete 912-line rewrite (DISCARD)
- ✅ All other source files (ec2_engine.cpp, etc.) - Untouched and working

---

**NEXT SESSION**: Restore backup, make ONLY the 3 surgical fixes, keep all 2016 lines intact!
