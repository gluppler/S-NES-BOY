# NES Config Directory

This directory contains ROM configuration files for mapper settings, mirroring, and build-time options.

## Purpose

Configuration files define:
- **Mapper type and bank switching behavior**: Which mapper hardware to use
- **Mirroring mode**: Horizontal, vertical, or four-screen mirroring
- **Region settings**: NTSC or PAL timing
- **Build-time feature flags**: Optional features and configurations

## Configuration Files

The linker configuration in `linker/` uses settings defined here to generate the correct iNES header and memory mapping.

## Current Status

This directory is currently empty. Configuration files will be added as mapper support expands.

## Related Documentation

- [NES Template README](../README.md) – Template overview
- [NES ROM Fundamentals](../../../docs/nes/fundamentals/1.5-rom-fundamentals.md) – ROM structure and mappers
