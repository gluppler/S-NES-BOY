# S-NES-BOY SNES Documentation

A comprehensive, hardware-accurate guide to SNES programming using the 65C816 (65816) assembly language.

## Overview

This documentation is part of **S-NES-BOY**, a codebase dedicated to learning and development of Nintendo Entertainment System (NES), Super Nintendo Entertainment System (SNES), and Game Boy systems and programming.

**This documentation applies to:**
- ✅ **SNES (Super Nintendo Entertainment System)**: Primary focus
- ✅ **Super: Fully compatible (Japanese variant of SNES, same hardware)
- ❌ **NES: Does not apply (see `../nes-docs/` for NES documentation)
- ❌ **Game Boy**: Does not apply (see `../gb-docs/` for Game Boy documentation)

## Primary Sources of Truth

- [SNES Dev Wiki](https://snes.nesdev.org/wiki/SNESdev_Wiki)
- [Super  Wiki](https://wiki.super.org)

## Structure

This knowledge base is organized into five primary sections:

### 1. Fundamentals

Establish correct mental models of SNES hardware and the 65816 CPU.

- SNES system architecture overview
- Differences from NES (CPU, PPU, memory, audio)
- 65816 CPU fundamentals:
  - Registers (A, X, Y, DBR, PBR, DP, SP, status flags)
  - Native vs emulation mode
  - 8-bit vs 16-bit register widths
- Memory map overview:
  - WRAM
  - ROM mapping (LoROM / HiROM)
  - VRAM, CGRAM, OAM
- Basic execution flow (reset → main loop → NMI)

### 2. Advanced Fundamentals

Explain timing, constraints, and failure modes.

- 65816 mode switching rules
- Banked memory addressing
- PPU register write rules
- VRAM access timing
- DMA vs HDMA
- Interrupt behavior (NMI, IRQ)
- CPU ↔ PPU ↔ APU synchronization
- Common hardware pitfalls

Each subsection includes:
- Exact registers involved
- Why the rule exists
- What breaks if violated

### 3. Core Concepts

Explain how subsystems interact.

- Game loop architecture (SNES-style)
- Rendering pipeline (backgrounds, sprites, modes 0–7)
- Tilemaps and metatiles on SNES
- Input → state → render pipeline
- Audio pipeline (CPU ↔ SPC700)
- Scene/state management

Each concept describes:
- Subsystems involved
- Data flow
- Timing implications
- Hardware rationale

### 4. Cheatsheets

Provide dense, zero-fluff reference material.

- 65816 instruction behavior
- CPU modes & flags
- SNES memory map
- PPU registers
- DMA / HDMA channels
- Background modes
- Sprite limits
- Interrupt vectors

### 5. Official Documentation & References

Provide verified source material.

- Direct links to SNESdev Wiki pages
- Super  Wiki references
- Official register documentation
- Known authoritative technical documents

## Philosophy

This knowledge base follows these principles:

- **Hardware-first: No abstractions until justified by hardware constraints
- **Assembly-aware: Assembly language is the foundation
- **Deterministic: Cycle counts, registers, memory maps matter
- **Cross-linked: Concepts reference each other
- **Cheatsheet-driven: Fast recall is a first-class feature
- **SNES/Super  focused: Dedicated to SNES development

## Global Constraints

- Hardware-first explanations
- Precise terminology (use official register names)
- Explicitly describe limitations and invariants
- Clearly distinguish SNES vs NES behavior
- Assume native 65816 mode unless stated otherwise

## Tone

- Technical
- Precise
- Non-tutorial
- Non-hand-holding

## Target Audience

- Technically competent programmers
- New to SNES hardware
- Comfortable with low-level concepts
- No prior SNES-specific knowledge assumed

## Related Resources

- [Main README](../../README.md) - S-NES-BOY project overview
- [NES Documentation](../nes-docs/README.md) - NES-specific documentation
- [References](../../REFERENCES.md) - External resources and authoritative links
- [Contributing Guide](../../CONTRIBUTING.md) - How to contribute to this project

## External Resources

- [SNES Dev Wiki](https://snes.nesdev.org/wiki/SNESdev_Wiki) - Comprehensive SNES development resources
- [Super  Wiki](https://wiki.super.org) - SNES development resources
- [65816.org](http://www.65816.org/) - 65816 processor documentation

---

**S-NES-BOY SNES Documentation**: Dedicated to learning and development of SNES and Super  systems.

**Note: This documentation is maintained as part of the S-NES-BOY open source project. Contributions are welcome! See [CONTRIBUTING.md](../../CONTRIBUTING.md) for guidelines.
