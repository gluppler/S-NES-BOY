# NES Template Validation

This document describes the checks that must pass for the NES template under continuous integration.

## Required Properties

- Generates a valid iNES ROM with a correct header
- Uses correct reset, NMI, and IRQ vectors
- Performs PPU initialization and VRAM updates according to documented timing rules
- Produces deterministic ROM output from a clean checkout
- Does not rely on emulator-specific behavior

## Suggested Checks

- Build `templates/nes` and verify that the ROM is produced in `templates/nes/rom/`
- Validate iNES header fields (mapper, mirroring, PRG/CHR sizes)
- Optionally run known NES test ROMs to confirm basic CPU and PPU correctness
