# SNES Config Directory

This directory contains ROM configuration files for mapping mode, banks, and build-time options.

## Purpose

Configuration files define:
- **ROM mapping mode**: LoROM or HiROM mapping
- **Bank configuration**: ROM bank layout and organization
- **Region settings**: NTSC or PAL timing
- **Build-time feature flags**: Optional features and configurations

## Configuration Files

The linker configuration in `linker/` uses settings defined here to generate the correct SNES header and memory mapping.

## Current Status

This directory is currently empty. Configuration files will be added as mapping support expands.

## Related Documentation

- [SNES Template README](../README.md) – Template overview
- [SNES ROM Fundamentals](../../../docs/snes/fundamentals/1.5-rom-fundamentals.md) – ROM structure and mapping
