# S-NES-BOY Game Boy Documentation

A comprehensive, hardware-accurate guide to Game Boy programming using the LR35902 CPU (Game Boy assembly).

## Overview

This documentation is part of **S-NES-BOY**, a codebase dedicated to learning and development of Nintendo Entertainment System (NES), Super Nintendo Entertainment System (SNES), and Game Boy systems and programming.

**This documentation applies to:**
- ✅ **Game Boy (DMG): Primary focus
- ✅ **Game Boy Color (CGB): Differences explicitly labeled
- ❌ **NES/SNES: Does not apply (see `../nes-docs/` and `../snes-docs/` for other systems)

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

Establish correct mental models of Game Boy hardware and the LR35902 CPU.

- Game Boy system overview
- LR35902 CPU fundamentals
- Memory map overview
- Boot process
- Execution flow

### 2. Advanced Fundamentals

Explain constraints, timing rules, and failure modes.

- Instruction timing
- Memory access restrictions
- LCD controller modes
- Interrupt system
- DMA behavior
- DMG vs CGB differences

### 3. Core Concepts

Explain subsystem interaction.

- Game loop architecture
- Rendering pipeline
- Tile and tilemap system
- Input → state → render pipeline
- Cartridge abstraction (conceptual)

### 4. Cheatsheets

Provide dense, zero-fluff reference material.

- Tables and bullet lists only
- No narrative prose
- LR35902 instruction reference
- Memory map quick reference
- Register reference
- LCD controller modes
- Interrupt vectors

### 5. Official Documentation & References

Provide verified authoritative sources only.

- Direct links to Pan Docs sections
- RGBDS documentation references
- GB ASM Tutorial references
- Known authoritative technical documents

### 6. Gold-Standard Example Section

Demonstrate correct, hardware-accurate documentation.

- VBlank-Safe Background Tile Update (DMG)

## Philosophy

This knowledge base follows these principles:

- **Hardware-first: No abstractions until justified by hardware constraints
- **Assembly-aware: Assembly language is the foundation
- **Deterministic: Cycle counts, registers, memory maps matter
- **Cross-linked: Concepts reference each other
- **Cheatsheet-driven: Fast recall is a first-class feature
- **Game Boy focused: Dedicated to Game Boy development

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

- Programmers comfortable with low-level concepts
- New to Game Boy hardware
- Familiar with assembly or systems programming
- No prior Game Boy-specific knowledge assumed

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

- [Main README](../../README.md) - S-NES-BOY project overview
- [NES Documentation](../nes-docs/README.md) - NES-specific documentation
- [SNES Documentation](../snes-docs/README.md) - SNES-specific documentation
- [References](../../REFERENCES.md) - External resources and authoritative links
- [Contributing Guide](../../CONTRIBUTING.md) - How to contribute to this project

---

**S-NES-BOY Game Boy Documentation**: Dedicated to learning and development of Game Boy systems.

**Note: This documentation is maintained as part of the S-NES-BOY open source project. Contributions are welcome! See [CONTRIBUTING.md](../../CONTRIBUTING.md) for guidelines.
