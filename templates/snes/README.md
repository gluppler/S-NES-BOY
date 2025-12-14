# S-NES-BOY SNES Template - Complete Project Suite

A full-featured SNES project template with comprehensive modular architecture, ready for immediate use. This template provides a complete foundation for SNES development with proper initialization, NMI handling, frame synchronization, and a comprehensive library system, following all S-NES-BOY principles and documentation.

**This template applies to:
- ✅ **SNES (Super Nintendo Entertainment System): Primary focus
- ✅ **Super: Fully compatible (same hardware)
- ❌ **NES: Does not apply (see `../nes/` for NES template)

## Overview

This template includes:

- **Complete SNES initialization: Proper reset sequence, RAM clearing, PPU setup
- **NMI handler: Frame-synchronized interrupt handler for rendering updates
- **Main loop: Frame-based game loop with proper synchronization
- **Modular architecture: Organized directory structure
- **Memory management: WRAM, VRAM, CGRAM, OAM definitions
- **Constants system: CPU (65816), PPU, APU (SPC700), controller, and mapper constants
- **Input system: Controller input with pressed/released detection
- **State machine: Game state management system
- **Screen modules: Welcome, menu, game, pause, and ending screens
- **PPU system: Initialization, writing, scrolling, and attributes
- **Sprite system: DMA, buffer management, and utilities
- **Text system: Font mapping, printing, and centered text
- **Palette system: Data, loading, and fading (CGRAM)
- **Tilemap system: Definitions, loading, metatiles, and collision
- **Audio system: SPC700 initialization, music, and sound effects
- **Game logic: Entities, collisions, and rules
- **Build system: Makefile with organized output directory
- **S-NES-BOY Compliant**: Follows all principles and laws of code established in the S-NES-BOY codebase

## Quick Start

1. **Build the ROM:
   ```bash
   make
   ```
   This creates `build/rom/game.sfc`

2. **Run in emulator:
   ```bash
   make run
   ```

3. **Clean build files:
   ```bash
   make clean
   ```

## Requirements

- **ca65** - 65816 assembler (part of cc65)
- **ld65** - Linker (part of cc65)
- **SNES emulator** (bsnes, snes9x, etc.)

## Related Resources

- [SNES Documentation](../../snes-docs/README.md) - SNES-specific documentation
- [NES Template](../nes/README.md) - NES template for reference
- [Main README](../../README.md) - S-NES-BOY project overview

---

**Note: This template follows hardware-accurate SNES programming practices. All code is designed to work on real SNES hardware, not just emulators.
