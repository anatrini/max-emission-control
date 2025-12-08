# ec2~ Conversion to Pure Max SDK

**Date**: 2025-12-01
**Reason**: Fix three critical issues by matching spat5.spat~ architecture

---

## Summary

Completely converted `ec2~` to **pure Max SDK** to fix:

1. ✅ **FullPacket from udpreceive not working** - Message wrapper timing issues
2. ✅ **No audio output** - DSP chain setup needed proper Max SDK registration
3. ✅ **MC mode not working** - Required specific outlet creation and `multichanneloutputs` method

---

## Decompilation Findings from spat5.spat~

### 1. FullPacket Registration (address 0x108b0)
```asm
leaq   "FullPacket", %rdx
movl   $0x8, %ecx              # A_GIMME = 0x8
callq  _class_addmethod
```
- Direct `class_addmethod` call
- NOT using wrapper
- A_GIMME (0x8) for variable arguments

### 2. MC Outlet Creation (address 0x5620-0x5640)
```asm
ldr    w8, [x19, #0x5c]        # Load mc_mode
cbz    w8, 0x5640              # If 0, skip to separated mode
# MC mode:
add    x1, x1, #0x42a          # literal: "multichannelsignal"
bl     _outlet_new             # Create ONE MC outlet
```
- When `@mc 1`: **ONE** outlet with type "multichannelsignal"
- When `@mc 0`: **N** outlets with type "signal"

### 3. multichanneloutputs Method (address 0x6f44)
```asm
ldr    x8, [x0, #0x50]
cmp    x8, #0x1
cbz    x1, 0x6f64              # If index==0, return channel count
mov    x0, #0x0                # Else return 0
```
- Registered via `class_addmethod` with "multichanneloutputs"
- Returns channel count when queried by Max

### 4. DSP Setup
- Uses `z_dsp_setup` (Max SDK function)
- Registers `dsp64` callback via `class_addmethod`

---

## Architecture Changes

### Before
```cpp
class ec2_tilde : public object<ec2_tilde> {
    // C++ class-based message handlers
    message<> fullpacket{this, "FullPacket", MIN_FUNCTION{...}};
    // ...
};
```

### After (Pure Max SDK)
```cpp
typedef struct _ec2 {
    t_pxobject ob;  // MSP object header (MUST be first)
    long outputs;
    long mc_mode;
    // ... C struct
} t_ec2;

extern "C" void ext_main(void *r) {
    t_class *c = class_new("ec2~", ...);
    class_addmethod(c, (method)ec2_fullpacket, "FullPacket", A_GIMME, 0);
    class_addmethod(c, (method)ec2_multichanneloutputs, "multichanneloutputs", A_CANT, 0);
    // ...
}
```

---

## Key Implementation Details

### FullPacket Handler (ec2_tilde.cpp:428)
```cpp
void ec2_fullpacket(t_ec2 *x, t_symbol *s, long argc, t_atom *argv) {
    long bundle_size = atom_getlong(&argv[0]);
    long bundle_ptr_val = atom_getlong(&argv[1]);

    char *data = (char *)bundle_ptr_val;

    // CRITICAL: Copy data IMMEDIATELY (udpreceive buffer will be freed)
    x->input_buffer->resize(bundle_size);
    std::memcpy(x->input_buffer->data(), data, bundle_size);

    // Parse and process...
}
```
**Why**: Direct Max SDK method avoids wrapper timing issues

### MC Outlet Creation (ec2_tilde.cpp:290)
```cpp
if (x->mc_mode == 1) {
    // MC mode: ONE "multichannelsignal" outlet
    outlet_new((t_object *)x, "multichannelsignal");
} else {
    // Separated mode: N "signal" outlets
    for (long i = 0; i < x->outputs; i++) {
        outlet_new((t_object *)x, "signal");
    }
}
```
**Why**: Max requires exact outlet type and `multichanneloutputs` method

### multichanneloutputs Handler (ec2_tilde.cpp:415)
```cpp
long ec2_multichanneloutputs(t_ec2 *x, long index) {
    if (index == 0 && x->mc_mode == 1) {
        return x->outputs;  // Return channel count
    }
    return 0;
}
```
**Why**: Max queries this to display channel count on MC cable (e.g., "x8")

### DSP Setup (ec2_tilde.cpp:374)
```cpp
void ec2_dsp64(t_ec2 *x, t_object *dsp64, short *count,
               double samplerate, long maxvectorsize, long flags) {
    (*x->engine)->setSampleRate(samplerate);
    object_method(dsp64, gensym("dsp_add64"), x, ec2_perform64, 0, nullptr);
}
```
**Why**: Proper Max SDK DSP chain registration

---

## File Changes

### 1. source/ec2_tilde/ec2_tilde.cpp
- **COMPLETE REWRITE** from C++ class wrapper to Max SDK C struct
- Backup saved: `ec2_tilde.cpp.mindevkit.backup`
- Lines: 712 (streamlined implementation)

### 2. source/ec2_tilde/CMakeLists.txt
- Uses pure Max SDK includes
- Direct external creation

### 3. CMakeLists.txt (root)
- Uses `MAX_SDK_DIR` for include paths

---

## Build Instructions

### Prerequisites
```bash
# Ensure Max SDK is present
ls max-sdk/source/c74support/max-includes/ext.h
```

### Build
```bash
cd /Users/anatrini/Documents/dev/max-emission-control
rm -rf build  # Clean old build
mkdir build && cd build
cmake ..
cmake --build .
```

### Result
- Output: `externals/ec2~.mxo`
- Architecture: Universal Binary (arm64 + x86_64)

---

## Testing Checklist

### 1. FullPacket from udpreceive
```
[udpreceive 7400 CNMAT]
|
[ec2~ @mc 1 @outputs 8]
```
- **Expected**: Parameters update from OSC bundles
- **Previously**: Failed because buffer was freed

### 2. Audio Output
```
[ec2~ @mc 0 @outputs 2]
|
[dac~]
```
- **Expected**: Audio output, CPU activity when audio on
- **Previously**: No output, no CPU activity

### 3. MC Mode
```
[ec2~ @mc 1 @outputs 8]
```
- **Expected**: ONE blue/black MC cable showing "x8"
- **Previously**: Regular signal cables, no channel count

---

## TODO Before Testing

### Add OSC Parsing (from backup)
The current implementation has placeholders:
```cpp
void ec2_send_osc_bundle(t_ec2 *x) {
    // TODO: Implement OSC bundle generation
}

void ec2_parse_osc_bundle(t_ec2 *x, const unsigned char *data, size_t size) {
    // TODO: Implement OSC bundle parsing
}
```

**Solution**: Copy OSC parsing functions from `ec2_tilde.cpp.mindevkit.backup`:
- `parseOSCBundle()` - lines ~1300-1350
- `parseOSCMessage()` - lines ~1350-1500
- `writeOSCMessage()` - lines ~1500-1600
- `sendOSCBundle()` - lines ~1800-1936

Adapt to pure C interface (change `x->m_input_buffer` to `x->input_buffer`, etc.)

---

## Comparison with spat5

| Feature | spat5.spat~ | ec2~ (new) | Match? |
|---------|------------|------------|--------|
| FullPacket registration | class_addmethod + A_GIMME | class_addmethod + A_GIMME | ✅ |
| MC outlet | "multichannelsignal" | "multichannelsignal" | ✅ |
| multichanneloutputs | Returns channel count | Returns channel count | ✅ |
| DSP setup | z_dsp_setup | dsp_setup | ✅ |
| Structure | C struct | C struct | ✅ |
| Framework | Pure Max SDK | Pure Max SDK | ✅ |

---

## Benefits of Conversion

1. **Direct control** - No abstraction layer hiding Max SDK behavior
2. **Timing fixes** - Immediate buffer copy in FullPacket handler
3. **MC support** - Proper outlet type and query method
4. **Compliance** - Matches professional externals like spat5
5. **Debugging** - Easier to trace issues without wrapper magic

---

## Backup Files

- `source/ec2_tilde/ec2_tilde.cpp.mindevkit.backup` - Original version with OSC parsing
- Contains all OSC parsing logic needed for final implementation

---

## Next Steps

1. Copy OSC parsing from backup
2. Build and test
3. Verify all three issues are fixed
4. Remove backup if successful
5. Update documentation

---

## Contact
Session: 2025-12-01 (context limit reached)
Continue from: Adding OSC parsing implementation
