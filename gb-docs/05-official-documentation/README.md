# 5. Official Documentation & References

## System Applicability

**This document applies to:**
- ✅ **Game Boy (DMG): Primary focus
- ✅ **Game Boy Color (CGB): Differences explicitly labeled
- ❌ **NES/SNES: Does not apply

## Primary Sources of Truth

### Hardware & Behavior (Highest Authority)

- **Pan Docs**: https://gbdev.io/pandocs/
  - Final authority on hardware behavior
  - Complete register documentation
  - Timing specifications
  - Memory map details
  - LCD controller behavior
  - Interrupt system
  - DMA behavior
  - DMG vs CGB differences

### General Game Boy Development Knowledge

- **gbdev.io**: https://gbdev.io
  - Community resources
  - Development guides
  - Tool documentation

- **gbdev.io/resources.html**: https://gbdev.io/resources.html
  - Comprehensive resource list
  - Links to tools and documentation
  - Community projects

### Assembly Language Syntax, Tooling, and Conventions

- **RGBDS**: https://rgbds.gbdev.io
  - Assembler directives
  - Macro system
  - Linker behavior
  - Object file format
  - Toolchain documentation

- **GB ASM Tutorial**: https://gbdev.io/gb-asm-tutorial/index.html
  - Assembly syntax validation
  - Idioms and conventions
  - Best practices
  - Code examples

### Framework-Level Reference (NOT Hardware Authority)

- **GBDK-2020**: https://github.com/gbdk-2020/gbdk-2020
  - C compiler and library
  - Framework abstractions
  - Clearly marked as framework, not hardware authority

## Validation Rules

- Pan Docs MUST be treated as final authority on hardware behavior
- GB ASM Tutorial MUST be used to validate assembly syntax, idioms, and conventions
- RGBDS documentation defines assembler directives, macros, and toolchain behavior
- GBDK is framework-level reference, NOT hardware authority

## Cross-References

- Related Fundamentals: All sections reference Pan Docs
- Related Advanced Fundamentals: All sections reference Pan Docs
- Related Core Concepts: All sections reference Pan Docs
- Related Cheatsheets: Derived from Pan Docs
