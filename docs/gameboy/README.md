# S-NES-BOY Game Boy Documentation

Hardware-accurate documentation for the Game Boy family using the LR35902 CPU.

## Overview

This documentation is part of **S-NES-BOY**, a Learning & Development Framework for NES, SNES, and Game Boy systems. The content in this tree is specific to the Game Boy family and provides a complete learning path from fundamentals to advanced development.

**This documentation applies to:**
- Game Boy (DMG): Primary focus
- Game Boy Color (CGB): Differences explicitly labeled

## Primary Sources of Truth

Hardware & behavior (highest authority):
- [Pan Docs](https://gbdev.io/pandocs/) - Final authority on hardware behavior

General Game Boy development knowledge:
- [gbdev.io](https://gbdev.io)
- [gbdev.io/resources.html](https://gbdev.io/resources.html)

Assembly language syntax, tooling, and conventions:
- [RGBDS](https://rgbds.gbdev.io) - Assembler directives, macros, toolchain behavior
- [GB ASM Tutorial](https://gbdev.io/gb-asm-tutorial/index.html) - Assembly syntax, idioms, conventions

Framework-level reference (clearly marked, NOT hardware authority):
- [GBDK-2020](https://github.com/gbdk-2020/gbdk-2020) - Framework abstractions

## Structure

This knowledge base is organized into six primary sections:

### 1. Fundamentals

Establish correct mental models and non-negotiable concepts for Game Boy systems.

- [1.1 Game Boy System Overview](fundamentals/1.1-game-boy-system-overview.md) - Hardware overview, DMG vs CGB, VBlank
- [1.2 LR35902 CPU Fundamentals](fundamentals/1.2-lr35902-cpu-fundamentals.md) - Registers, instructions, addressing
- [1.3 Memory Fundamentals](fundamentals/1.3-memory-fundamentals.md) - CPU memory map, VRAM, WRAM, OAM
- [1.4 Boot Process](fundamentals/1.4-boot-process.md) - Cartridge header, boot sequence, initialization
- [1.5 Execution Flow](fundamentals/1.5-execution-flow.md) - Reset vector, main loop, interrupt handling

### 2. Advanced Fundamentals

Move from "it works" to "it is correct on real hardware".

- [2.1 Instruction Timing](advanced_fundamentals/2.1-instruction-timing.md) - Cycle counts, timing rules
- [2.2 LCD Controller Modes](advanced_fundamentals/2.2-lcd-controller-modes.md) - Mode 0-3, VRAM/OAM access restrictions
- [2.3 Memory Access Restrictions](advanced_fundamentals/2.3-memory-access-restrictions.md) - VRAM/OAM access timing, LCD mode constraints
- [2.4 Interrupt System](advanced_fundamentals/2.4-interrupt-system.md) - VBlank, LCD STAT, Timer, Serial interrupts
- [2.5 DMA Behavior](advanced_fundamentals/2.5-dma-behavior.md) - OAM DMA, timing, restrictions
- [2.6 DMG vs CGB Differences](advanced_fundamentals/2.6-dmg-vs-cgb-differences.md) - Hardware differences, compatibility

### 3. Core Concepts

Learn how subsystems interact and work together.

- [3.1 The Game Loop](concepts/3.1-the-game-loop.md) - Main loop, VBlank handler, frame synchronization
- [3.2 Rendering Pipeline](concepts/3.2-rendering-pipeline.md) - Tile rendering, sprite rendering, LCD output
- [3.3 Tile and Tilemap System](concepts/3.3-tile-and-tilemap-system.md) - Tile data, tilemaps, background rendering
- [3.4 Input → State → Render Pipeline](concepts/3.4-input-state-render-pipeline.md) - Joypad input, game state, rendering output
- [3.5 Cartridge Abstraction](concepts/3.5-cartridge-abstraction.md) - ROM banking, MBC behavior, cartridge types

### 4. Cheatsheets

Fast reference for active coding.

- [4.1 LR35902 CPU Cheatsheets](cheatsheets/04-cheatsheets/4.1-lr35902-cpu-cheatsheets.md) - Instruction reference, addressing modes, flags
- [4.2 PPU Cheatsheets](cheatsheets/04-cheatsheets/4.2-ppu-cheatsheets.md) - Register reference, LCD modes, sprite attributes
- [4.3 Memory Cheatsheets](cheatsheets/04-cheatsheets/4.3-memory-cheatsheets.md) - Memory maps, VRAM, WRAM, OAM
- [4.4 Timing Cheatsheets](cheatsheets/04-cheatsheets/4.4-timing-cheatsheets.md) - Frame timing, VBlank windows, cycle budgets

### 5. Gold Standard Examples

Demonstrate correct, hardware-accurate patterns.

- [Gold Standard Examples](gold_standard/) - Verified implementation patterns (currently empty, awaiting verified authoritative examples)

### 6. References

Provide verified authoritative sources.

- [References](references/REFERENCES.md) - Pan Docs links, RGBDS documentation, authoritative sources

## Philosophy

This knowledge base follows these principles:

- **Hardware-first**: No abstractions until justified by hardware constraints
- **Assembly-aware**: Assembly language is the foundation; higher-level languages are convenience layers
- **Deterministic**: Cycle counts, registers, memory maps matter
- **Cross-linked**: Concepts reference each other, not isolated chapters
- **Cheatsheet-driven**: Fast recall is a first-class feature
- **Game Boy focused**: Dedicated to Game Boy development

## Global Constraints

- Hardware-first explanations
- Precise terminology (use official register names from Pan Docs)
- Explicitly describe limitations and invariants
- Clearly distinguish DMG vs CGB behavior
- Assume real DMG hardware unless explicitly stated
- CGB differences MUST be explicitly labeled and isolated

## Tone

- Technical
- Precise
- Non-tutorial
- Non-hand-holding
- Non-opinionated

## Target Audience

- **Technically competent**: Assumes programming knowledge
- **New to Game Boy**: No system-specific intuition required
- **LR35902 literate**: Basic assembly understanding helpful but not required
- **Hardware enthusiasts**: Interest in understanding how these systems work

## Validation Rules

Any generated documentation MUST be REJECTED if ANY of the following are true:

- Uses behavior not documented in Pan Docs
- Confuses DMG and CGB behavior
- Uses incorrect register names or addresses
- Omits required hardware limitations
- Writes to VRAM or OAM without respecting LCD modes
- Ignores VBlank as a synchronization boundary
- Uses syntax not valid in RGBDS
- Uses pseudo-instructions without labeling them as such
- Mixes Z80 semantics with LR35902 behavior
- Includes opinions, speculation, or filler
- Uses emulator-specific assumptions
- Makes factual claims without traceable sources

## Related Resources

- [Main README](../../README.md) - Framework overview
- [References](references/REFERENCES.md) - Game Boy-specific external resources and authoritative links
- [Contributing Guide](../../CONTRIBUTING.md) - How to contribute to this framework

---

S-NES-BOY Game Boy documentation is dedicated to learning and development of Game Boy systems.

This documentation is maintained as part of the S-NES-BOY Learning & Development Framework. See [CONTRIBUTING.md](../../CONTRIBUTING.md) for contribution guidelines.
