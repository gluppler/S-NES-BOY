# S-NES Directory Structure

This document describes the purpose and contents of each directory in the S-NES codebase.

## Root Directory

The root directory contains project-wide documentation and configuration files.

- `README.md` - Main project overview and introduction to S-NES
- `CHANGELOG.md` - Project version history and changes
- `CONTRIBUTING.md` - Guidelines for contributing to S-NES
- `CODE_OF_CONDUCT.md` - Community standards and conduct
- `LICENSE` - MIT License
- `REFERENCES.md` - External resources for NES, SNES, and Famicom development
- `GETTINGSTARTED.md` - Quick start guide for Linux development
- `.gitignore` - Files and directories to exclude from version control
- `.github/` - GitHub templates and workflows

## docs/

Comprehensive documentation for NES, SNES, and Famicom development.

### docs/01-fundamentals/

Core concepts and hardware basics. Essential reading for understanding system architecture.

- `1.1-nes-system-overview.md` - NES hardware overview, NTSC vs PAL, VBlank
- `1.2-6502-cpu-fundamentals.md` - 6502 CPU registers, addressing modes, instructions
- `1.3-memory-fundamentals.md` - CPU memory map, zero page, stack
- `1.4-ppu-fundamentals.md` - PPU tiles, pattern tables, name tables, sprites
- `1.5-rom-fundamentals.md` - iNES header, PRG/CHR ROM, Mapper 0

### docs/02-advanced-fundamentals/

Advanced topics covering timing, constraints, and hardware-specific details.

- `2.1-cpu-timing-cycles.md` - Cycle counts, branch penalties, timing
- `2.2-nmi-vblank-discipline.md` - NMI handling, VBlank windows
- `2.3-ppu-rendering-rules.md` - VRAM access, scroll registers, sprite evaluation
- `2.4-controller-io.md` - Controller shift register, strobing, button reading
- `2.5-audio-fundamentals.md` - APU channels, frame counter, timing
- `2.6-optimization-techniques.md` - Cycle optimization, memory access, performance tuning
- `2.7-graphics-pixel-art.md` - Tile design, palette systems, pixel art techniques

### docs/03-core-concepts/

System interactions and architectural patterns.

- `3.1-the-game-loop.md` - Main loop, NMI handler, frame synchronization
- `3.2-data-oriented-design.md` - Memory layout, zero page, struct-of-arrays
- `3.3-rendering-architecture.md` - OAM buffering, VRAM updates, rendering pipeline
- `3.4-input-state-output-pipeline.md` - Controller input, game state, rendering output
- `3.5-map-level-systems.md` - Metatiles, compression, attribute encoding

### docs/04-cheatsheets/

Quick reference tables for active coding.

- `4.1-cpu-cheatsheets.md` - Instruction reference, addressing modes, flags
- `4.2-ppu-cheatsheets.md` - Register reference, sprite attributes, palettes
- `4.3-memory-cheatsheets.md` - Memory maps, zero page, APU registers
- `4.4-timing-cheatsheets.md` - Frame timing, VBlank windows, cycle budgets
- `4.5-audio-cheatsheets.md` - APU register map, channel control, frame counter
- `4.6-optimization-cheatsheets.md` - Quick optimization reference, cycle costs, patterns

### docs/05-applied-patterns/

Reusable, proven solutions for common problems.

- `5.1-sprite-engine-patterns.md` - Fixed slots, dynamic allocation, flicker prevention
- `5.2-scrolling-patterns.md` - Horizontal, vertical, four-way scrolling
- `5.3-collision-systems.md` - Tile-based, bounding box, hybrid collision
- `5.4-animation-systems.md` - Frame tables, timers, state-driven animation
- `5.5-audio-integration.md` - FamiTone2, music vs SFX priority, direct APU control

### docs/06-tooling-debugging/

Tools and techniques for development.

- `6.1-toolchain.md` - ca65/ld65, asm6f, Makefiles
- `6.2-emulators-debuggers.md` - Mesen2 workflow, breakpoints, PPU viewers
- `6.3-test-roms.md` - CPU tests, PPU tests, APU tests

### docs/07-real-hardware/

Considerations for real hardware testing.

- `real-hardware-considerations.md` - Flashcarts, power-on state, emulator mismatches

## Projects/

Example projects demonstrating S-NES principles and best practices.

### Projects/hello-world/

Complete NES program demonstrating text rendering with full alphabet/lexicon (A-Z, 0-9, punctuation).

**Purpose**: Foundation example for understanding NES programming basics.

**Contents**:
- `main.asm` - Main assembly source with complete text rendering system
- `chars_data.asm` - CHR ROM data with complete alphabet tiles
- `nes.cfg` - Linker configuration (16 KB PRG ROM, 8 KB CHR ROM)
- `Makefile` - Build system
- `README.md` - Project documentation

### Projects/welcome/

Centered text display project showing "Welcome to S-NES".

**Purpose**: Demonstrates proper text centering and name table rendering.

**Contents**:
- `main.asm` - Main assembly source with centered text rendering
- `chars_data.asm` - CHR ROM data (shared with hello-world)
- `nes.cfg` - Linker configuration (16 KB PRG ROM, 8 KB CHR ROM)
- `Makefile` - Build system
- `README.md` - Project documentation

## template/

Minimal starter template for new NES projects.

**Purpose**: Quick start template with proper initialization, NMI handler, and build system.

**Contents**:
- `main.asm` - Template assembly source with complete NES program structure
- `chars.chr` - Empty CHR ROM file (8 KB, ready to replace)
- `nes.cfg` - Linker configuration file
- `Makefile` - Build system with compile, run, and clean targets
- `README.md` - Template documentation

## File Organization Principles

1. **Documentation First**: All documentation in `docs/` with clear hierarchical structure
2. **Examples in Projects**: All example projects in `Projects/` directory
3. **Templates Separate**: Starter templates in `template/` directory
4. **No Generated Files**: All generated files excluded via `.gitignore`
5. **Clear Naming**: All files use descriptive, consistent naming conventions

## Directory Naming Conventions

- **Lowercase with hyphens**: All directory names use lowercase and hyphens (e.g., `hello-world`)
- **Numbered sections**: Documentation uses numbered prefixes for ordering (e.g., `01-fundamentals`)
- **Descriptive names**: All names clearly indicate purpose and contents

