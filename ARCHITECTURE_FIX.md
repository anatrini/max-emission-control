# Architecture Fix for M1/M2/M3 Macs

**Issue**: "Object cannot load due to incorrect architecture" error in Max 9

## Problem

The min-devkit build system creates universal binaries (both x86_64 and arm64) by default. Max 9 on Apple Silicon sometimes has issues loading universal binaries and prefers architecture-specific binaries.

## Solution

Extract only the arm64 slice from the universal binary:

```bash
# After building
cd /path/to/max-emission-control
cp -r ~/Documents/dev/externals/ec2~.mxo externals/
lipo externals/ec2~.mxo/Contents/MacOS/ec2~ -thin arm64 -output externals/ec2~.mxo/Contents/MacOS/ec2~
xattr -cr externals/ec2~.mxo
```

## Verification

```bash
file externals/ec2~.mxo/Contents/MacOS/ec2~
# Should output: Mach-O 64-bit bundle arm64
```

## New Location

The precompiled binary is now in:
```
externals/ec2~.mxo  (arm64 only, not universal)
```

This is best practice for Max externals:
- ✅ Easy to find in repository
- ✅ Easy to distribute (include in git)
- ✅ Users can copy directly to Max library
- ✅ Clear what architecture is provided

## Installation

```bash
cp -r externals/ec2~.mxo ~/Documents/Max\ 9/Library/
```

## Future

For v1.0 final release, consider providing:
- Separate arm64 binary (M1/M2/M3)
- Separate x86_64 binary (Intel Macs)
- Optional: Universal binary (both architectures)

**Current status**: arm64 only (M1/M2/M3) in `externals/` folder
