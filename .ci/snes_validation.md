# SNES Template Validation

This document describes the checks that must pass for the SNES template under continuous integration.

## Required Properties

- Boots under conditions matching real SNES hardware
- Enters native 65816 mode explicitly from reset
- Configures banks and mapping according to the linker script
- Uploads data to VRAM only using safe transfer paths (DMA or HDMA) and valid timing
- Produces deterministic `.sfc` output from a clean checkout

## Suggested Checks

- Build `templates/snes` and verify that the ROM is produced in `templates/snes/rom/`
- Inspect the SNES header region for expected mapping mode and checksum fields
- Optionally run basic SNES test ROMs or emulator-integrated checks for CPU and PPU behavior
