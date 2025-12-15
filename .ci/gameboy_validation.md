# Game Boy Template Validation

This document describes the checks that must pass for the Game Boy template under continuous integration.

## Required Properties

- Generates a `.gb` ROM with a valid cartridge header
- Uses RGBDS-compatible syntax and build steps
- Performs LCD and PPU initialization with correct timing
- Restricts VRAM writes to VBlank-safe periods
- Produces deterministic ROM output from a clean checkout

## Suggested Checks

- Build `templates/gb` and verify that the ROM is produced in `templates/gb/rom/`
- Confirm that `rgbfix` is applied and header fields are consistent
- Optionally run hardware-focused test ROMs in a cycle-accurate emulator
