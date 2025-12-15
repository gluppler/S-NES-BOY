# Game Boy Config Directory

This directory contains ROM configuration files and build-time options.

## Purpose

Configuration files define:
- **Cartridge type and MBC settings**: Which Memory Bank Controller to use
- **ROM size and RAM size**: Cartridge memory configuration
- **Region settings**: Region-specific settings if needed
- **Build-time feature flags**: Optional features and configurations

## Configuration Files

The linker configuration in `linker/` and `rgbfix` use settings defined here to generate the correct cartridge header.

## Current Status

This directory is currently empty. Configuration files will be added as cartridge support expands.

## Related Documentation

- [Game Boy Template README](../README.md) – Template overview
- [Game Boy Cartridge Abstraction](../../../docs/gameboy/concepts/3.5-cartridge-abstraction.md) – Cartridge types and MBC behavior
