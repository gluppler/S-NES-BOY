# S-NES-BOY Game Boy Development Template

Production-ready Game Boy development template for the S-NES-BOY Learning & Development Framework.

## Scope

This template is part of the S-NES-BOY framework and provides a complete, hardware-accurate starting point for Game Boy development using the LR35902 CPU and the RGBDS toolchain. It targets the original Game Boy (DMG) and Game Boy Color (CGB), and is designed to include a valid cartridge header, respect LCD initialization timing, and perform VRAM writes in VBlank-safe fashion.

## Directory Layout

The Game Boy template follows the required layout:

- `build/` – Build scripts and notes
- `src/` – Game Boy source code (reset, initialization, main loop, interrupts)
- `assets/` – Tile, tilemap, and palette data used by the ROM
- `linker/` – Linker configuration files
- `headers/` – Hardware register definitions and memory layout includes
- `macros/` – Assembly macros and reusable patterns
- `tools/` – Helper tools and scripts (documented as they are added)
- `config/` – ROM configuration and build options
- `rom/` – Output ROM images

## Template Contents

- Main program and reset flow in `src/main.asm`
- Official `hardware.inc` in `headers/` for register and constant definitions
- Minimal Makefile that builds a deterministic `.gb` ROM into `rom/`
- Structure ready for adding assets, macros, tools, and configuration files

## Building

From `templates/gb/`:

```bash
make           # Build ROM into rom/
make run       # Run in configured Game Boy emulator
make clean     # Remove build outputs
```

## Requirements

- `rgbasm`, `rgblink`, `rgbfix` – RGBDS toolchain
- Game Boy emulator such as SameBoy, BGB, or mGBA

## Hardware Assumptions

This template assumes:
- Original Game Boy (DMG) hardware
- RGBDS-compatible assembly syntax
- VBlank-safe VRAM and OAM updates only
- Standard Game Boy button input
- LCD initialization timing respected
- Valid cartridge header with correct checksums

## Extending the Template

To extend this template:

1. **Add new subsystems**: Create modules in `src/` following existing patterns
2. **Add assets**: Place tile data and tilemaps in `assets/`
3. **Add macros**: Place reusable assembly macros in `macros/`
4. **Add headers**: Place hardware definitions and constants in `headers/`
5. **Configure cartridge**: Modify cartridge header settings in build process
6. **Add tools**: Place asset conversion scripts in `tools/` with documentation

Follow the existing code structure and maintain hardware-accurate timing constraints. Ensure all VRAM writes occur during VBlank or HBlank periods.

## Related Documentation

- [Framework Overview](../../README.md) – Main framework README
- [Game Boy Documentation Index](../../docs/gameboy/README.md) – Game Boy documentation index
- [Game Boy Fundamentals](../../docs/gameboy/fundamentals/) – Core Game Boy hardware concepts
- [Game Boy Advanced Fundamentals](../../docs/gameboy/advanced_fundamentals/) – Timing and constraints
- [Game Boy Core Concepts](../../docs/gameboy/concepts/) – System interaction patterns
- [Game Boy Gold Standard Examples](../../docs/gameboy/gold_standard/) – Reference implementations

## Philosophy

The Game Boy template is intended to be a minimal, correct starting point for real-hardware-safe Game Boy projects. It follows hardware-first principles and respects all Game Boy timing constraints and hardware limitations, including LCD mode restrictions and VBlank requirements.
