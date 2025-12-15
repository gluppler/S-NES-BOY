# S-NES-BOY SNES Development Template

Production-ready SNES development template for the S-NES-BOY Learning & Development Framework.

## Scope

This template is part of the S-NES-BOY framework and provides a complete, hardware-accurate starting point for SNES development using the 65C816 CPU. It is designed to boot under real hardware conditions, enter native 65816 mode explicitly, configure banks correctly, and upload data to VRAM safely.

## Directory Layout

The SNES template uses the following layout:

- `build/` – Build scripts and notes
- `src/` – SNES source code (reset, initialization, main loop, interrupts, subsystems)
- `assets/` – Tile, tilemap, and palette data used by the ROM
- `linker/` – Linker scripts and memory maps
- `headers/` – Hardware register definitions and memory layout includes
- `macros/` – Assembly macros and reusable patterns
- `tools/` – Helper tools and scripts
- `config/` – ROM configuration files (mapping mode, banks, build options)
- `rom/` – Output ROM images

## Template Contents

- Reset vector and entry point in `src/` with explicit 65816 mode selection
- Hardware initialization for CPU, PPU, memory, and VRAM paths
- Main loop and NMI handler for frame-based execution
- Separate modules for input, state management, screens, PPU, sprites, text, palettes, tilemaps, and audio
- Linker configuration in `linker/` for LoROM mapping
- Headers in `headers/` describing WRAM, VRAM, CGRAM, and OAM layout
- Macros in `macros/` for timing, memory operations, PPU operations, and register management
- Build system in `Makefile` that produces a deterministic `.sfc` ROM in `rom/`

## Building

From `templates/snes/`:

```bash
make
make run
make clean
```

## Requirements

- `ca65` – 65816 assembler (part of cc65)
- `ld65` – Linker (part of cc65)
- SNES emulator such as bsnes or higan

## Hardware Assumptions

This template assumes:
- LoROM mapping mode
- Native 65816 mode (16-bit accumulator, 16-bit index registers)
- NTSC timing
- Standard SNES controller input
- Mode 0 background rendering (4 BGs, 4 colors per BG)
- All VRAM updates use DMA or occur during safe periods
- NMI handler completes within VBlank window

## Extending the Template

To extend this template:

1. **Add new subsystems**: Create modules in `src/` following existing patterns
2. **Add assets**: Place tile data, tilemaps, and palettes in `assets/`
3. **Add macros**: Place reusable assembly macros in `macros/`
4. **Add headers**: Place hardware definitions and constants in `headers/`
5. **Configure mapping**: Modify `linker/` configuration for different mapping modes
6. **Add tools**: Place asset conversion scripts in `tools/` with documentation

Follow the existing code structure and maintain hardware-accurate timing constraints.

## Reference Implementation

This template follows patterns from the canonical snes-hello example (https://github.com/SlithyMatt/snes-hello), which demonstrates:

- Correct native 65816 mode entry (`clc; xce`)
- Proper register size configuration (`.p816`, `.i16`, `.a8`)
- LoROM mapping with correct header placement
- DMA-based VRAM clearing
- Hardware-accurate PPU initialization

The snes-hello patterns are integrated into the example at `examples/snes/hello_world/`, which serves as the reference for minimal SNES initialization.

## Related Documentation

- [Framework Overview](../../README.md) – Main framework README
- [SNES Documentation Index](../../docs/snes/README.md) – SNES documentation index
- [SNES Fundamentals](../../docs/snes/fundamentals/) – Core SNES hardware concepts
- [SNES Advanced Fundamentals](../../docs/snes/advanced_fundamentals/) – Timing and constraints
- [SNES Core Concepts](../../docs/snes/concepts/) – System interaction patterns
- [SNES Gold Standard Examples](../../docs/snes/gold_standard/) – Reference implementations
- [SNES Hello World Example](../../examples/snes/hello_world/) – Canonical SNES example

## Philosophy

The SNES template is intended to be a minimal, correct starting point for real-hardware-safe SNES projects. It follows hardware-first principles and respects all SNES timing constraints and hardware limitations.
