# Binary Distribution Guide for ec2~

**Date**: 2025-11-21
**Purpose**: Best practices for distributing precompiled binaries

---

## Recommendation: YES, Provide Precompiled Binaries

**Answer**: It is **standard practice and highly recommended** to provide precompiled binaries for Max externals.

### Reasons

1. **User Convenience** - Most Max users don't have build tools installed
2. **Industry Standard** - Most commercial and open-source Max externals provide binaries
3. **Accessibility** - Lowers barrier to entry for testing and adoption
4. **Common Practice** - Examples: spat5, IRCAM tools, mc.* objects all ship precompiled

### When to Distribute

**Good timing for v1.0-beta**:
- ✅ Core functionality complete (Phases 1-13)
- ✅ Tested and stable
- ✅ Build successful
- ⏸️ Comprehensive help file (can wait for v1.0 final)

**Verdict**: Distribute now for beta testing, update for v1.0 final

---

## What to Distribute

### For Current Version (v1.0-beta)

**Single Binary Package**:
```
ec2~-v1.0-beta-macos-apple-silicon.zip
└── ec2~.mxo/
    └── Contents/
        ├── Info.plist
        ├── PkgInfo
        └── MacOS/
            └── ec2~  (arm64 binary)
```

**File**: `ec2~.mxo` (the entire bundle)
**Platform**: macOS Apple Silicon (M1/M2/M3)
**Architecture**: arm64

### For Future Releases (v1.0 final)

Provide **two binaries**:

1. **Apple Silicon** (arm64)
   - `ec2~-v1.0-macos-apple-silicon.zip`
   - Native performance on M1/M2/M3 Macs
   - Most current users

2. **Intel** (x86_64)
   - `ec2~-v1.0-macos-intel.zip`
   - For older Intel Macs
   - Compatibility for legacy systems

**Optional: Universal Binary**
- Contains both arm64 and x86_64
- Single download works on all Macs
- Larger file size (~2x)
- Consider for v1.0 final if file size reasonable

---

## Build Instructions for Distribution

### Create Apple Silicon Binary (Current)

```bash
# From repository root
mkdir -p build-release
cd build-release

# Configure for Release (optimized)
cmake .. -DCMAKE_BUILD_TYPE=Release

# Build
cmake --build . --config Release

# Locate binary
# Output: ~/Documents/dev/externals/ec2~.mxo
```

### Create Intel Binary (Future)

```bash
# On Intel Mac OR using Rosetta
mkdir -p build-intel
cd build-intel

# Configure for x86_64
cmake .. -DCMAKE_BUILD_TYPE=Release \
         -DCMAKE_OSX_ARCHITECTURES=x86_64

cmake --build . --config Release
```

### Create Universal Binary (Optional, Future)

```bash
mkdir -p build-universal
cd build-universal

# Configure for both architectures
cmake .. -DCMAKE_BUILD_TYPE=Release \
         -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64"

cmake --build . --config Release
```

---

## Packaging for Distribution

### Step 1: Verify Binary

```bash
# Check architecture
file ~/Documents/dev/externals/ec2~.mxo/Contents/MacOS/ec2~

# Expected output (Apple Silicon):
# ec2~: Mach-O 64-bit bundle arm64

# Expected output (Universal):
# ec2~: Mach-O universal binary with 2 architectures: [arm64:Mach-O 64-bit bundle arm64] [x86_64:Mach-O 64-bit bundle x86_64]
```

### Step 2: Clean Bundle

```bash
# Remove code signing extended attributes
xattr -cr ~/Documents/dev/externals/ec2~.mxo

# Remove debug symbols (if any)
# Usually not needed for Release builds
```

### Step 3: Create ZIP Archive

```bash
# Navigate to externals directory
cd ~/Documents/dev/externals

# Create versioned ZIP
zip -r ec2~-v1.0-beta-macos-apple-silicon.zip ec2~.mxo

# Verify archive
unzip -l ec2~-v1.0-beta-macos-apple-silicon.zip
```

### Step 4: Test Archive

```bash
# Extract to test location
mkdir test-install
cd test-install
unzip ../ec2~-v1.0-beta-macos-apple-silicon.zip

# Copy to Max library
cp -r ec2~.mxo ~/Documents/Max\ 8/Library/

# Test in Max
# 1. Open Max
# 2. Create [ec2~] object
# 3. Should load without errors
```

---

## GitHub Release Instructions

### Create Release on GitHub

1. **Go to Releases**
   - Navigate to repository on GitHub
   - Click "Releases" tab
   - Click "Draft a new release"

2. **Tag Version**
   - Tag: `v1.0-beta`
   - Target: `main` branch
   - Release title: `v1.0 Beta - Feature Complete`

3. **Release Notes Template**

```markdown
# ec2~ v1.0 Beta - Feature Complete

High-performance multichannel granular synthesis for Max/MSP.

## What's New in v1.0 Beta

- ✅ Complete granular synthesis engine (2048 voices)
- ✅ 16-channel multichannel output
- ✅ 7 spatial allocation modes
- ✅ 6 LFO modulators
- ✅ Signal-rate inputs (scan, grain rate, playback)
- ✅ OSC integration (odot/spat5 compatible)
- ✅ Waveform display and buffer editor

## Download

### macOS Apple Silicon (M1/M2/M3)
**Recommended for most users with newer Macs**

[ec2~-v1.0-beta-macos-apple-silicon.zip](link)

### Installation

1. Download the ZIP file above
2. Extract `ec2~.mxo`
3. Copy to `~/Documents/Max 8/Library/`
4. If macOS blocks the external:
   ```bash
   xattr -cr ~/Documents/Max\ 8/Library/ec2~.mxo
   ```

## Requirements

- macOS 10.13+ (High Sierra or later)
- Max/MSP 8.0+
- Apple Silicon Mac (M1/M2/M3)

*Intel Mac support coming in v1.0 final*

## Documentation

- **Parameter Reference**: See `docs/EC2_HELP_REFERENCE.md` in repository
- **Interactive Help**: Coming in v1.0 final (`ec2~.maxhelp`)
- **Build Instructions**: See `README.md`

## Known Limitations

- macOS only (Windows support planned)
- Help file incomplete (coming in v1.0 final)
- Intel Mac binary not included (coming in v1.0 final)

## Feedback

This is a **beta release** for testing. Please report issues:
- [GitHub Issues](https://github.com/yourusername/max-emission-control/issues)
- [Discussions](https://github.com/yourusername/max-emission-control/discussions)

## Credits

Based on EmissionControl2 by Curtis Roads, Greg Surges, et al.
Max/MSP port by Alessandro Anatrini.

---

**Full Changelog**: https://github.com/yourusername/max-emission-control/compare/v0.1-alpha...v1.0-beta
```

4. **Attach Binary**
   - Click "Attach binaries by dropping them here or selecting them"
   - Upload: `ec2~-v1.0-beta-macos-apple-silicon.zip`
   - Verify file appears in release

5. **Publish**
   - Check "This is a pre-release" (for beta)
   - Click "Publish release"

---

## Security Considerations

### Code Signing (Optional but Recommended)

**For v1.0 final**, consider Apple Developer code signing:

#### Benefits
- Users don't see "damaged or incomplete" warning
- More professional distribution
- Easier installation experience

#### Drawbacks
- Requires Apple Developer account ($99/year)
- Additional build complexity
- Needs certificate management

#### How to Code Sign (If Desired)

```bash
# Requires: Apple Developer account + valid certificate

# Sign the bundle
codesign --sign "Developer ID Application: Your Name" \
         --deep \
         --force \
         --options runtime \
         ec2~.mxo

# Verify signature
codesign -v ec2~.mxo

# Notarize (macOS 10.15+)
# This requires additional steps with Apple's notarization service
```

**Recommendation**: Skip code signing for v1.0-beta, consider for v1.0 final if you have Apple Developer account.

### Current Approach (No Code Signing)

**Acceptable for open source projects**:
1. Provide `xattr` command in documentation
2. Users can verify source code (it's open source)
3. Many Max externals distributed this way
4. Users comfortable with command line can inspect/build from source

---

## File Naming Convention

### Recommended Format

```
<name>-v<version>-<platform>-<architecture>.zip

Examples:
ec2~-v1.0-beta-macos-apple-silicon.zip
ec2~-v1.0-beta-macos-intel.zip
ec2~-v1.0-beta-macos-universal.zip
ec2~-v1.0-windows-x64.zip  (future)
```

### Benefits
- Clear platform/architecture
- Version immediately visible
- Alphabetically sorted by version
- No ambiguity for users

---

## Distribution Checklist

### Pre-Release Testing

- [ ] Build in clean environment
- [ ] Test on Apple Silicon Mac
- [ ] Test in Max 8.0+
- [ ] Verify all features work
- [ ] Check CPU usage reasonable
- [ ] Test with example patches
- [ ] No crashes or errors in console

### Packaging

- [ ] Clean binary (`xattr -cr`)
- [ ] Create versioned ZIP
- [ ] Test ZIP extraction
- [ ] Verify file size reasonable (< 5 MB expected)

### GitHub Release

- [ ] Create release tag
- [ ] Write release notes
- [ ] Upload binary ZIP
- [ ] Mark as pre-release (for beta)
- [ ] Link to documentation
- [ ] Provide installation instructions

### Post-Release

- [ ] Test download link
- [ ] Verify installation instructions work
- [ ] Monitor for user reports
- [ ] Update README with download link

---

## Size Expectations

### Typical Sizes

- **Debug Build**: 2-5 MB (includes debug symbols)
- **Release Build**: 500 KB - 2 MB (optimized, stripped)
- **Universal Binary**: ~2x single architecture

### Current Build

Check your binary size:
```bash
du -sh ~/Documents/dev/externals/ec2~.mxo
```

Expected: ~1-2 MB for Apple Silicon Release build

---

## Versioning Strategy

### For v1.0-beta (Now)

**Version**: `1.0-beta`
**Binary**: Apple Silicon only
**Help File**: Not included (link to docs)
**Purpose**: Beta testing, user feedback

### For v1.0-rc (After Phase 11)

**Version**: `1.0-rc` (release candidate)
**Binary**: Apple Silicon + Intel
**Help File**: Included (ec2~.maxhelp)
**Purpose**: Final testing before stable release

### For v1.0 (Stable)

**Version**: `1.0`
**Binary**: Apple Silicon + Intel (or Universal)
**Help File**: Complete
**Documentation**: All examples included
**Purpose**: Stable public release

---

## Best Practices Summary

### DO

✅ Provide precompiled binaries (standard practice)
✅ Use clear version naming (v1.0-beta)
✅ Include platform/architecture in filename
✅ Provide `xattr` command for macOS Gatekeeper
✅ Mark beta releases as "pre-release" on GitHub
✅ Include installation instructions
✅ Link to documentation
✅ Test binary before release

### DON'T

❌ Don't include debug builds (too large)
❌ Don't sign with ad-hoc signature (confuses users)
❌ Don't omit architecture from filename
❌ Don't release without testing
❌ Don't forget to mark as pre-release (for beta)

### OPTIONAL (Consider for v1.0 final)

💭 Code signing (requires Apple Developer account)
💭 Universal binary (larger file, better compatibility)
💭 Windows build (requires Windows build environment)
💭 Installer package (.pkg) instead of ZIP

---

## Recommendation for NOW

**For v1.0-beta**:

1. ✅ **Build Release binary** (Apple Silicon)
2. ✅ **Create ZIP archive**
3. ✅ **Create GitHub release** (mark as pre-release)
4. ✅ **Upload binary**
5. ✅ **Write clear release notes**
6. ✅ **Link installation instructions**

**Skip for now**:
- ⏸️ Code signing (can add for v1.0)
- ⏸️ Intel binary (can add for v1.0)
- ⏸️ Universal binary (can add for v1.0)
- ⏸️ Help file inclusion (complete in Phase 11)

**Timeline**:
- v1.0-beta: Now (Apple Silicon binary only)
- v1.0-rc: After Phase 11 (add Intel binary, include help file)
- v1.0: After user testing (stable release)

---

## Summary

**YES, provide precompiled binaries for v1.0-beta!**

It's standard practice, helps users, and enables broader testing. The current implementation is stable enough for beta distribution.

Start with Apple Silicon binary now, add Intel and help file for v1.0 final.

---

**Document Author**: Best practices guide
**Last Updated**: 2025-11-21
**Status**: Ready for v1.0-beta distribution
