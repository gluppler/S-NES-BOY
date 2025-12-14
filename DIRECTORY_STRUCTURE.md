# S-NES-BOY Directory Structure

This document describes the purpose and contents of each directory in the S-NES-BOY codebase.

## Root Directory

The root directory contains project-wide documentation and configuration files.

- `README.md` - Main project overview and introduction to S-NES-BOY
- `CHANGELOG.md` - Project version history and changes
- `CONTRIBUTING.md` - Guidelines for contributing to S-NES-BOY
- `CODE_OF_CONDUCT.md` - Community standards and conduct
- `LICENSE` - MIT License
- `REFERENCES.md` - External resources for NES, SNES, and Game Boy development
- `GETTINGSTARTED.md` - Quick start guide for Linux development
- `.gitignore` - Files and directories to exclude from version control
- `.github/` - GitHub templates and workflows

## nes-docs/

Comprehensive documentation for NES development.

### nes-docs/01-fundamentals/

Core concepts and hardware basics. Essential reading for understanding NES architecture.

- `1.1-nes-system-overview.md` - NES hardware overview, NTSC vs PAL, VBlank
- `1.2-6502-cpu-fundamentals.md` - 6502 CPU registers, addressing modes, instructions
- `1.3-memory-fundamentals.md` - CPU memory map, zero page, stack
- `1.4-ppu-fundamentals.md` - PPU tiles, pattern tables, name tables, sprites
- `1.5-rom-fundamentals.md` - iNES header, PRG/CHR ROM, Mapper 0

### nes-docs/02-advanced-fundamentals/

Advanced topics covering timing, constraints, and hardware-specific details.

- `2.1-cpu-timing-cycles.md` - Cycle counts, branch penalties, timing
- `2.2-nmi-vblank-discipline.md` - NMI handling, VBlank windows
- `2.3-ppu-rendering-rules.md` - VRAM access, scroll registers, sprite evaluation
- `2.4-controller-io.md` - Controller shift register, strobing, button reading
- `2.5-audio-fundamentals.md` - APU channels, frame counter, timing
- `2.6-optimization-techniques.md` - Cycle optimization, memory access, performance tuning
- `2.7-graphics-pixel-art.md` - Tile design, palette systems, pixel art techniques

### nes-docs/03-core-concepts/

System interactions and architectural patterns.

- `3.1-the-game-loop.md` - Main loop, NMI handler, frame synchronization
- `3.2-data-oriented-design.md` - Memory layout, zero page, struct-of-arrays
- `3.3-rendering-architecture.md` - OAM buffering, VRAM updates, rendering pipeline
- `3.4-input-state-output-pipeline.md` - Controller input, game state, rendering output
- `3.5-map-level-systems.md` - Metatiles, compression, attribute encoding

### nes-docs/04-cheatsheets/

Quick reference tables for active coding.

- `4.1-cpu-cheatsheets.md` - Instruction reference, addressing modes, flags
- `4.2-ppu-cheatsheets.md` - Register reference, sprite attributes, palettes
- `4.3-memory-cheatsheets.md` - Memory maps, zero page, APU registers
- `4.4-timing-cheatsheets.md` - Frame timing, VBlank windows, cycle budgets
- `4.5-audio-cheatsheets.md` - APU register map, channel control, frame counter
- `4.6-optimization-cheatsheets.md` - Quick optimization reference, cycle costs, patterns

### nes-docs/05-applied-patterns/

Reusable, proven solutions for common problems.

- `5.1-sprite-engine-patterns.md` - Fixed slots, dynamic allocation, flicker prevention
- `5.2-scrolling-patterns.md` - Horizontal, vertical, four-way scrolling
- `5.3-collision-systems.md` - Tile-based, bounding box, hybrid collision
- `5.4-animation-systems.md` - Frame tables, timers, state-driven animation
- `5.5-audio-integration.md` - FamiTone2, music vs SFX priority, direct APU control

### nes-docs/06-tooling-debugging/

Tools and techniques for development.

- `6.1-toolchain.md` - ca65/ld65, asm6f, Makefiles
- `6.2-emulators-debuggers.md` - Mesen2 workflow, breakpoints, PPU viewers
- `6.3-test-roms.md` - CPU tests, PPU tests, APU tests

### nes-docs/07-real-hardware/

Considerations for real hardware testing.

- `real-hardware-considerations.md` - Flashcarts, power-on state, emulator mismatches

## snes-docs/

Comprehensive documentation for SNES and Super  development.

### snes-docs/01-fundamentals/

Core concepts and hardware basics for SNES architecture.

- SNES system architecture overview
- Differences from NES (CPU, PPU, memory, audio)
- 65816 CPU fundamentals (registers, native vs emulation mode, 8-bit vs 16-bit)
- Memory map overview (WRAM, ROM mapping, VRAM, CGRAM, OAM)
- Basic execution flow (reset → main loop → NMI)

### snes-docs/02-advanced-fundamentals/

Advanced topics covering timing, constraints, and SNES-specific details.

- 65816 mode switching rules
- Banked memory addressing
- PPU register write rules
- VRAM access timing
- DMA vs HDMA
- Interrupt behavior (NMI, IRQ)
- CPU ↔ PPU ↔ APU synchronization
- Common hardware pitfalls

### snes-docs/03-core-concepts/

System interactions and architectural patterns for SNES.

- Game loop architecture (SNES-style)
- Rendering pipeline (backgrounds, sprites, modes 0–7)
- Tilemaps and metatiles on SNES
- Input → state → render pipeline
- Audio pipeline (CPU ↔ SPC700)
- Scene/state management

### snes-docs/04-cheatsheets/

Quick reference tables for SNES development.

- 65816 instruction behavior
- CPU modes & flags
- SNES memory map
- PPU registers
- DMA / HDMA channels
- Background modes
- Sprite limits
- Interrupt vectors

### snes-docs/05-applied-patterns/

Reusable, proven solutions for SNES development.

- Sprite engine patterns
- Scrolling patterns
- Collision systems
- Animation systems
- Audio integration

### snes-docs/06-tooling-debugging/

Tools and techniques for SNES development.

- Toolchain setup (ca65 with 65816 support)
- Emulators and debuggers
- Test ROMs

### snes-docs/07-real-hardware/

Considerations for real SNES hardware testing.

- Real hardware considerations

## gb-docs/

Comprehensive documentation for Game Boy development.

### gb-docs/01-fundamentals/

Core concepts and hardware basics for Game Boy architecture.

- Game Boy system overview
- LR35902 CPU fundamentals
- Memory fundamentals
- Boot process
- Execution flow

### gb-docs/02-advanced-fundamentals/

Advanced topics covering timing, constraints, and Game Boy-specific details.

- Instruction timing
- Memory access restrictions
- LCD controller modes
- Interrupt system
- DMA behavior
- DMG vs CGB differences

### gb-docs/03-core-concepts/

System interactions and architectural patterns for Game Boy.

- The game loop
- Rendering pipeline
- Tile and tilemap system
- Input → state → render pipeline
- Cartridge abstraction

### gb-docs/04-cheatsheets/

Quick reference tables for Game Boy development.

- LR35902 CPU cheatsheets
- PPU cheatsheets
- Memory cheatsheets
- Timing cheatsheets

### gb-docs/05-official-documentation/

Verified source material and references.

- Pan Docs references
- RGBDS documentation
- GB ASM Tutorial references

### gb-docs/06-gold-standard-examples/

Gold-standard examples demonstrating best practices.

- VBlank-Safe Background Tile Update (DMG)

### snes-docs/01-fundamentals/

Core concepts and hardware basics for SNES architecture.

- SNES system architecture overview
- Differences from NES (CPU, PPU, memory, audio)
- 65816 CPU fundamentals (registers, native vs emulation mode, 8-bit vs 16-bit)
- Memory map overview (WRAM, ROM mapping, VRAM, CGRAM, OAM)
- Basic execution flow (reset → main loop → NMI)

### snes-docs/02-advanced-fundamentals/

Advanced topics covering timing, constraints, and SNES-specific details.

- 65816 mode switching rules
- Banked memory addressing
- PPU register write rules
- VRAM access timing
- DMA vs HDMA
- Interrupt behavior (NMI, IRQ)
- CPU ↔ PPU ↔ APU synchronization
- Common hardware pitfalls

### snes-docs/03-core-concepts/

System interactions and architectural patterns for SNES.

- Game loop architecture (SNES-style)
- Rendering pipeline (backgrounds, sprites, modes 0–7)
- Tilemaps and metatiles on SNES
- Input → state → render pipeline
- Audio pipeline (CPU ↔ SPC700)
- Scene/state management

### snes-docs/04-cheatsheets/

Quick reference tables for SNES development.

- 65816 instruction behavior
- CPU modes & flags
- SNES memory map
- PPU registers
- DMA / HDMA channels
- Background modes
- Sprite limits
- Interrupt vectors

### snes-docs/05-official-documentation/

Verified source material and references.

- Direct links to SNESdev Wiki pages
- Super  Wiki references
- Official register documentation
- Known authoritative technical documents

## templates/

Project templates organized by system.

### templates/nes/

Complete NES project template with modular architecture.

**Purpose: Quick start template for NES projects with proper initialization, NMI handler, and comprehensive library system.

**Contents:
- `src/` - Source code with modular architecture
  - `main.asm`, `reset.asm`, `vectors.asm`, `nmi.asm`, `irq.asm`
  - `memory/` - Memory definitions (zeropage, ram, oam, stack)
  - `constants/` - Constants (cpu, ppu, apu, controller, mapper)
  - `macros/` - Assembly macros (registers, ppu, memory, math, sprites, etc.)
  - `input/` - Input system (controller, debounce)
  - `state/` - State management (state machine, transitions)
  - `screens/` - Screen modules (welcome, menu, game, pause, ending)
  - `ppu/` - PPU system (init, write, scrolling, attributes)
  - `tilemap/` - Tilemap system (defs, loader, metatiles, collision)
  - `text/` - Text system (font_map, print, print_centered, strings)
  - `sprites/` - Sprite system (dma, buffer, utils, defs)
  - `palette/` - Palette system (data, load, fade)
  - `audio/` - Audio system (apu_init, music, sfx)
  - `game/` - Game logic (entities, collisions, rules)
- `linker/` - Linker configurations (nrom, mmc1, mmc3, custom)
- `data/` - Data files (tilemaps, nametables, tables)
- `graphics/` - Graphics files (chr, palettes, source)
- `tests/` - Test directories
- `debug/` - Debug utilities
- `build/` - Build output (generated)
- `Makefile` - Build system
- `README.md` - Template documentation

### templates/snes/

Complete SNES project template with modular architecture.

**Purpose: Quick start template for SNES projects with proper initialization, NMI handler, and comprehensive library system.

**Contents: Similar structure to NES template but adapted for SNES:
- 65816 CPU constants and macros
- WRAM, VRAM, CGRAM, OAM definitions
- SPC700 audio system
- SNES-specific PPU and rendering systems
- Complete build system for SNES ROMs with auto-installation

### templates/gb/

Complete Game Boy project template with modular architecture.

**Purpose: Quick start template for Game Boy projects with proper initialization, VBlank handler, and comprehensive library system.

**Contents:
- Official hardware.inc from GB ASM Tutorial
- LR35902 CPU constants
- PPU, LCD, DMA definitions
- Complete build system for Game Boy ROMs with auto-installation
- RGBDS toolchain integration

## Projects/

Example projects organized by system.

### Projects/nes/

NES example projects demonstrating S-NES-BOY principles and best practices.

#### Projects/nes/hello-world/

Complete NES program demonstrating text rendering with full alphabet/lexicon (A-Z, 0-9, punctuation).

**Purpose: Foundation example for understanding NES programming basics.

**Contents:
- `main.asm` - Main assembly source with complete text rendering system
- `chars_data.asm` - CHR ROM data with complete alphabet tiles
- `nes.cfg` - Linker configuration (16 KB PRG ROM, 8 KB CHR ROM)
- `Makefile` - Build system
- `README.md` - Project documentation

#### Projects/nes/welcome/

Centered text display project showing "Welcome to S-NES-BOY".

**Purpose: Demonstrates proper text centering and name table rendering.

**Contents:
- `main.asm` - Main assembly source with centered text rendering
- `chars_data.asm` - CHR ROM data (shared with hello-world)
- `nes.cfg` - Linker configuration (16 KB PRG ROM, 8 KB CHR ROM)
- `Makefile` - Build system
- `README.md` - Project documentation

### Projects/snes/

SNES example projects demonstrating S-NES-BOY principles and best practices.

#### Projects/snes/hello-world/

Complete SNES program demonstrating text rendering with full alphabet/lexicon (A-Z, 0-9, punctuation).

**Purpose**: Foundation example for understanding SNES programming basics.

**Contents**:
- `main.asm` - Main assembly source with complete text rendering system (65816 native mode)
- `chars_data.asm` - CHR ROM data with complete alphabet tiles (Mode 0, 2 bitplanes)
- `snes.cfg` - Linker configuration (LoROM, 16 KB PRG ROM, 8 KB CHR ROM)
- `Makefile` - Build system with `--cpu 65816 --feature force_range`
- `README.md` - Project documentation

#### Projects/snes/welcome/

Centered text display project showing "WELCOME TO S-NES-BOY".

**Purpose**: Demonstrates proper text centering and tilemap rendering on SNES.

**Contents**:
- `main.asm` - Main assembly source with centered text rendering (65816 native mode)
- `chars_data.asm` - CHR ROM data (shared with hello-world)
- `snes.cfg` - Linker configuration (LoROM, 16 KB PRG ROM, 8 KB CHR ROM)
- `Makefile` - Build system with `--cpu 65816 --feature force_range`
- `README.md` - Project documentation

### Projects/gb/

Game Boy example projects demonstrating S-NES-BOY principles and best practices.

#### Projects/gb/hello-world/

Complete Game Boy program demonstrating text rendering with full alphabet/lexicon (A-Z, 0-9, punctuation).

**Purpose**: Foundation example for understanding Game Boy programming basics.

**Contents**:
- `main.asm` - Main assembly source with complete text rendering system
- `hardware.inc` - Official hardware definitions from GB ASM Tutorial
- `Makefile` - Build system with RGBDS toolchain auto-installation
- `README.md` - Project documentation

## File Organization Principles

1. **Documentation First**: All documentation in `nes-docs/`, `snes-docs/`, and `gb-docs/` with clear hierarchical structure
2. **Examples in Projects**: All example projects in `Projects/nes/`, `Projects/snes/`, and `Projects/gb/` directories
3. **Templates Separate**: Starter templates in `templates/nes/`, `templates/snes/`, and `templates/gb/` directories
4. **No Generated Files**: All generated files excluded via `.gitignore`
5. **Clear Naming**: All files use descriptive, consistent naming conventions
6. **System Separation**: NES, SNES, and Game Boy content clearly separated into their own directories

## Directory Naming Conventions

- **Lowercase with hyphens: All directory names use lowercase and hyphens (e.g., `hello-world`)
- **Numbered sections: Documentation uses numbered prefixes for ordering (e.g., `01-fundamentals`)
- **Descriptive names: All names clearly indicate purpose and contents
- **System prefixes: Documentation and templates use `nes-` and `snes-` prefixes where appropriate
