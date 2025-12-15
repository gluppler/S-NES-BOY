# S-NES-BOY NES Development Template

Production-ready NES development template for the S-NES-BOY Learning & Development Framework.

## Scope

This template is part of the S-NES-BOY framework and provides a complete, hardware-accurate starting point for NES development. It is designed to generate a valid iNES ROM with correct vectors and NMI usage, respect PPU timing rules, and support CHR-ROM or CHR-RAM cleanly.

## Directory Layout

The NES template uses the following layout:

- `build/` – Build scripts and notes
- `src/` – NES source code (reset, initialization, main loop, interrupts, subsystems)
- `assets/` – Tile, tilemap, and palette data used by the ROM
- `linker/` – Linker scripts and memory maps
- `headers/` – Hardware register definitions and memory layout includes
- `macros/` – Assembly macros and reusable patterns
- `tools/` – Helper tools and scripts
- `config/` – Mapper, mirroring, and build options
- `rom/` – Output ROM images

## Template Contents

- Reset vector and entry point in `src/`
- Hardware initialization for CPU, PPU, APU, and controller ports
- Main loop and NMI handler for frame-based execution
- Separate modules for input, state management, screens, PPU, sprites, text, palettes, tilemaps, and audio
- Linker configurations in `linker/` for NROM and other mappers
- Headers in `headers/` describing RAM, zero page, OAM, and register layout
- Macros in `macros/` for timing, memory operations, PPU operations, and register management
- Build system in `Makefile` that produces a deterministic `.nes` ROM in `rom/`

## Building

From `templates/nes/`:

```bash
make
make run
make clean
```

## Requirements

- `ca65` – 6502 assembler (part of cc65)
- `ld65` – Linker (part of cc65)
- NES emulator such as Mesen2 or FCEUX

## Hardware Assumptions

This template assumes:
- NROM mapper (Mapper 0) with 32 KB PRG ROM and 8 KB CHR ROM
- NTSC timing (60.098 Hz frame rate, 262 scanlines)
- Standard NES controller input
- Horizontal mirroring for nametables
- All PPU updates occur during VBlank
- NMI handler completes within VBlank window

## Extending the Template

To extend this template:

1. **Add new subsystems**: Create modules in `src/` following existing patterns
2. **Add assets**: Place tile data, tilemaps, and palettes in `assets/`
3. **Add macros**: Place reusable assembly macros in `macros/`
4. **Add headers**: Place hardware definitions and constants in `headers/`
5. **Configure mapper**: Modify `linker/` configuration for different mappers
6. **Add tools**: Place asset conversion scripts in `tools/` with documentation

Follow the existing code structure and maintain hardware-accurate timing constraints.

## Related Documentation

- [Framework Overview](../../README.md) – Main framework README
- [NES Documentation Index](../../docs/nes/README.md) – NES documentation index
- [NES Fundamentals](../../docs/nes/fundamentals/) – Core NES hardware concepts
- [NES Advanced Fundamentals](../../docs/nes/advanced_fundamentals/) – Timing and constraints
- [NES Core Concepts](../../docs/nes/concepts/) – System interaction patterns

## Philosophy

The NES template is intended to be a minimal, correct starting point for real-hardware-safe NES projects. It follows hardware-first principles and respects all NES timing constraints and hardware limitations.
