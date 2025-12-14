# System Applicability Guide

This guide explains how S-NES documentation applies to different systems (NES, SNES, Famicom).

## Quick Reference

### Fully Compatible (NES = Famicom)
- All fundamentals (1.1-1.5) - NES and Famicom are hardware-identical
- All advanced fundamentals (2.1-2.7) - Same hardware constraints
- All core concepts (3.1-3.5) - Same architectural patterns
- All cheatsheets (4.1-4.6) - Same hardware registers and memory maps
- All applied patterns (5.1-5.5) - Same programming patterns

### Partially Compatible (SNES)
- **CPU Fundamentals (1.2)**: SNES uses 65816 (backward compatible with 6502 in emulation mode)
- **CPU Timing (2.1)**: Different cycle counts and timing characteristics
- **Optimization (2.6)**: Concepts apply but different hardware constraints
- **Game Loop (3.1)**: Similar patterns but uses VBlank IRQ instead of NMI

### Not Compatible (SNES)
- **System Overview (1.1)**: Different hardware architecture
- **Memory (1.3)**: Different memory map (24-bit addressing)
- **PPU (1.4, 2.3)**: Completely different PPU architecture
- **ROM Format (1.5)**: Different ROM format and header
- **Audio (2.5)**: Different audio processor (SPC700)
- **Controller (2.4)**: Different controller protocol

## Famicom-Specific Features

### Expansion Audio
- Famicom supports expansion audio chips (VRC6, VRC7, FDS audio)
- NES does not support expansion audio (hardware limitation)
- See 2.5 Audio Fundamentals for details

### Famicom Disk System (FDS)
- Famicom-only feature (not available on NES)
- Uses disk-based storage instead of cartridges
- See 1.5 ROM Fundamentals for details

### Controller Differences
- Famicom controllers are hardwired (not removable)
- Controller 2 has microphone input
- Same shift register protocol as NES
- See 2.4 Controller I/O for details

## SNES Development Path

For SNES development:
1. Start with NES fundamentals to understand retro console architecture
2. Learn 65816 CPU (extends 6502 with 16-bit capabilities)
3. Study SNES-specific documentation (PPU modes, SPC700 audio)
4. Use SNES-specific tools and emulators

## Documentation Status

- ✅ **NES**: Complete coverage
- ✅ **Famicom**: Complete coverage (same as NES with additional features noted)
- ⚠️ **SNES**: Partial coverage (foundation concepts apply, SNES-specific content expanding)

