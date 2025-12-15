# Game Boy Build Directory

This directory contains build scripts and build-related documentation.

## Purpose

The build system produces deterministic ROM output from source code. The Makefile in the parent directory orchestrates the build process.

## Build Process

1. **Assembly**: Source files in `src/` are assembled using `rgbasm`
2. **Linking**: Object files are linked using `rgblink` with configuration from `linker/`
3. **ROM Fix**: `rgbfix` applies cartridge header and validation
4. **Output**: Final ROM is placed in `rom/` directory

## Build Output

- **Object files** (`.o`) – Generated during assembly
- **Map files** (`.map`) – Show memory layout and symbol addresses
- **List files** (`.lst`) – Show assembly with addresses and generated code
- **Final ROM** (`.gb`) – The output artifact ready for emulation or hardware

## Deterministic Builds

The build system is designed to produce identical ROM output from the same source code, ensuring reproducible builds. This is critical for version control and debugging.

## Related Documentation

- [Game Boy Template README](../README.md) – Template overview
- [RGBDS Documentation](https://rgbds.gbdev.io) – RGBDS toolchain documentation
