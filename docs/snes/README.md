# S-NES-BOY SNES Documentation

Hardware-accurate documentation for the Super Nintendo Entertainment System using the 65C816 (65816) CPU.

## Overview

This documentation is part of **S-NES-BOY**, a Learning & Development Framework for NES, SNES, and Game Boy systems. The content in this tree is specific to the SNES and provides a complete learning path from fundamentals to advanced development.

This documentation applies to:
- SNES (Super Nintendo Entertainment System): Primary focus

## Primary Sources of Truth

- [Super Wiki](https://wiki.super.org) - Comprehensive SNES development resources and documentation
- [65816.org](http://www.65816.org/) - 65816 processor documentation

## Reference Implementation

The canonical minimal SNES example is **snes-hello** (https://github.com/SlithyMatt/snes-hello). The code patterns from snes-hello have been integrated into the S-NES-BOY example at `examples/snes/hello_world/`, which demonstrates correct hardware initialization patterns and serves as the reference for SNES development.

## Structure

This knowledge base is organized into seven primary sections:

### 1. Fundamentals

Establish correct mental models and non-negotiable concepts for SNES systems.

- [1.1 SNES System Overview](fundamentals/1.1-snes-system-overview.md) - Hardware overview, NTSC vs PAL, VBlank
- [1.2 65816 CPU Fundamentals](fundamentals/1.2-65816-cpu-fundamentals.md) - Registers, addressing modes, instructions
- [1.3 Memory Fundamentals](fundamentals/1.3-memory-fundamentals.md) - CPU memory map, WRAM, ROM mapping
- [1.4 PPU Fundamentals](fundamentals/1.4-ppu-fundamentals.md) - Backgrounds, sprites, modes, VRAM
- [1.5 ROM Fundamentals](fundamentals/1.5-rom-fundamentals.md) - LoROM/HiROM, header, cartridge structure

### 2. Advanced Fundamentals

Move from "it works" to "it is correct on real hardware".

- [2.1 CPU Timing & Cycles](advanced_fundamentals/2.1-cpu-timing-cycles.md) - Cycle counts, branch penalties, timing
- [2.2 NMI & VBlank Discipline](advanced_fundamentals/2.2-nmi-vblank-discipline.md) - NMI handling, VBlank windows
- [2.3 PPU Rendering Rules](advanced_fundamentals/2.3-ppu-rendering-rules.md) - VRAM access, register writes, rendering
- [2.4 Controller I/O](advanced_fundamentals/2.4-controller-io.md) - Controller reading, auto-joypad
- [2.5 Audio Fundamentals](advanced_fundamentals/2.5-audio-fundamentals.md) - SPC700, communication, channels
- [2.6 Advanced Optimization Techniques](advanced_fundamentals/2.6-optimization-techniques.md) - Cycle optimization, DMA usage, performance tuning
- [2.7 Graphics & Pixel Art](advanced_fundamentals/2.7-graphics-pixel-art.md) - Tile design, palette systems, pixel art techniques

### 3. Core Concepts

Learn how subsystems interact and work together.

- [3.1 The Game Loop](concepts/3.1-the-game-loop.md) - Main loop, NMI handler, frame synchronization
- [3.2 Data-Oriented Design (SNES Style)](concepts/3.2-data-oriented-design.md) - Memory layout, WRAM organization, struct-of-arrays
- [3.3 Rendering Architecture](concepts/3.3-rendering-architecture.md) - OAM buffering, VRAM updates, rendering pipeline
- [3.4 Input → State → Output Pipeline](concepts/3.4-input-state-output-pipeline.md) - Controller input, game state, rendering output
- [3.5 Map & Level Systems](concepts/3.5-map-level-systems.md) - Metatiles, compression, level data

### 4. Cheatsheets

Fast reference for active coding.

- [4.1 CPU Cheatsheets](cheatsheets/04-cheatsheets/4.1-cpu-cheatsheets.md) - Instruction reference, addressing modes, flags
- [4.2 PPU Cheatsheets](cheatsheets/04-cheatsheets/4.2-ppu-cheatsheets.md) - Register reference, background modes, sprites
- [4.3 Memory Cheatsheets](cheatsheets/04-cheatsheets/4.3-memory-cheatsheets.md) - Memory maps, WRAM, ROM mapping
- [4.4 Timing Cheatsheets](cheatsheets/04-cheatsheets/4.4-timing-cheatsheets.md) - Frame timing, VBlank windows, cycle budgets
- [4.5 Audio Cheatsheets](cheatsheets/04-cheatsheets/4.5-audio-cheatsheets.md) - SPC700 register map, communication protocol
- [4.6 Optimization Cheatsheets](cheatsheets/04-cheatsheets/4.6-optimization-cheatsheets.md) - Quick optimization reference, cycle costs, patterns

### 5. Applied Patterns & Systems

Reusable, proven solutions for common problems.

- [5.1 Sprite Engine Patterns](techniques/05-applied-patterns/5.1-sprite-engine-patterns.md) - Fixed slots, dynamic allocation, priority
- [5.2 Scrolling Patterns](techniques/05-applied-patterns/5.2-scrolling-patterns.md) - Horizontal, vertical, four-way scrolling
- [5.3 Collision Systems](techniques/05-applied-patterns/5.3-collision-systems.md) - Tile-based, bounding box, hybrid collision
- [5.4 Animation Systems](techniques/05-applied-patterns/5.4-animation-systems.md) - Frame tables, timers, state-driven animation
- [5.5 Audio Integration](techniques/05-applied-patterns/5.5-audio-integration.md) - SPC700 communication, music vs SFX priority

### 6. Tooling & Debugging

Tools and techniques for development.

- [6.1 Toolchain (Linux-first)](06-tooling-debugging/6.1-toolchain.md) - ca65/ld65, Makefiles
- [6.2 Emulators & Debuggers](06-tooling-debugging/6.2-emulators-debuggers.md) - bsnes workflow, breakpoints, PPU viewers
- [6.3 Test ROMs](06-tooling-debugging/6.3-test-roms.md) - CPU tests, PPU tests, SPC700 tests

### 7. Real Hardware Considerations

What you need to know for real SNES hardware.

- [Real Hardware Considerations](07-real-hardware/real-hardware-considerations.md) - Flashcarts, power-on state, emulator mismatches

## Philosophy

This knowledge base follows these principles:

- **Hardware-first**: No abstractions until justified by hardware constraints
- **Assembly-aware**: Assembly language is the foundation; higher-level languages are convenience layers
- **Deterministic**: Cycle counts, registers, memory maps matter
- **Cross-linked**: Concepts reference each other, not isolated chapters
- **Cheatsheet-driven**: Fast recall is a first-class feature
- **SNES focused**: Dedicated to SNES development

## Global Constraints

- Hardware-first explanations
- Precise terminology (use official register names)
- Explicitly describe limitations and invariants
- Assume native 65816 mode unless stated otherwise

## Tone

- Technical
- Precise
- Non-tutorial
- Non-hand-holding

## Target Audience

- **Technically competent**: Assumes programming knowledge
- **New to SNES**: No system-specific intuition required
- **65816 literate**: Basic assembly understanding helpful but not required
- **Hardware enthusiasts**: Interest in understanding how these systems work

## Related Resources

- [Main README](../../README.md) - Framework overview
- [References](references/REFERENCES.md) - SNES-specific external resources
- [Gold Standard Examples](gold_standard/) - Verified implementation patterns
- [Contributing Guide](../../CONTRIBUTING.md) - How to contribute to this framework

## External Resources

- [Super Wiki](https://wiki.super.org) - SNES development resources
- [65816.org](http://www.65816.org/) - 65816 processor documentation

---

S-NES-BOY SNES documentation is dedicated to learning and development of SNES systems.

This documentation is maintained as part of the S-NES-BOY Learning & Development Framework. See [CONTRIBUTING.md](../../CONTRIBUTING.md) for contribution guidelines.
