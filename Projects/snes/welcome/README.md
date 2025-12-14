# Welcome to S-NES-BOY

A centered text display project for the SNES that displays "Welcome to S-NES-BOY" centered on screen. This project demonstrates proper text centering, tilemap rendering, and follows all S-NES-BOY principles and documentation.

## Overview

This program displays "Welcome to S-NES-BOY" centered both horizontally and vertically on the SNES screen. It serves as a simple demonstration of text rendering and proper SNES programming practices following S-NES-BOY documentation.

## Features

- **Centered Text Display**: Text is perfectly centered horizontally and vertically on the SNES screen
- **Tilemap Rendering**: Uses tilemap for background text rendering
- **Hardware Accurate**: Follows strict SNES documentation principles and optimization techniques
- **S-NES-BOY Compliant**: Follows all principles and laws of code established in the S-NES-BOY codebase
- **Mode 0 Graphics**: Uses Mode 0 (4 BGs, 4 colors per BG)

## Architecture

- **LoROM Mapping**: Banks $00-$7F
- **Mode 0**: 4 background layers, 4 colors per BG
- **Screen Resolution**: 256×224 pixels (NTSC)
- **Tilemap Rendering** using background tiles
- **8×8 Tile Mode** for character display

## Requirements

- `ca65` (assembler, part of cc65)
- `ld65` (linker, part of cc65)
- `higan` (recommended) - SNES emulator - https://higan.readthedocs.io/en/stable/

## Build Instructions

### Build ROM

```bash
make
```

### Run in Emulator

```bash
make run
```

### Clean Build Files

```bash
make clean
```

### Verify ROM Structure

```bash
make verify
```

## Code Structure

### Main Components

- **`main.asm`**: Main program entry point, initialization, text rendering
- **`chars_data.asm`**: Tile data for all characters (512 tiles, 8 KB)
- **`snes.cfg`**: Linker configuration for LoROM mapping
- **`Makefile`**: Build system

### Key Functions

- **`reset`**: Complete SNES initialization (native mode, WRAM clear, PPU setup)
- **`nmi`**: NMI handler for frame synchronization
- **`load_palette`**: Loads 16-color palette into CGRAM
- **`load_background`**: Clears tilemap and writes centered text
- **`write_text`**: Writes null-terminated string to tilemap
- **`char_to_tile`**: Converts ASCII character to tile index

## SNES-Specific Features

### Native Mode

The program switches from emulation mode to native mode:
```asm
REP #$38     ; Native mode, clear decimal, clear accumulator
XCE          ; Switch to native mode
```

### Direct Page

Uses direct page addressing for frequently accessed variables:
```asm
LDA #$0000
TCD          ; Direct page = $0000
```

### DMA Operations

Uses DMA for fast memory operations:
- WRAM clearing (64 KB transfer)
- VRAM clearing (64 KB transfer)
- CGRAM clearing (512 bytes)
- OAM clearing (544 bytes)

### Mode 0 Graphics

- **4 Background Layers**: BG1-BG4
- **4 Colors per BG**: From 16-color subpalette
- **32×32 Tilemap**: 1024 tiles per BG
- **8×8 Tiles**: Standard tile size

## Text Centering

The text "WELCOME TO S-NES-BOY" (20 characters) is centered:
- **Horizontal**: (32 - 17) / 2 = 7.5, rounded to 7 columns from left
- **Vertical**: Row 14 (14 rows above, 15 rows below for visual center)
- **Tilemap Address**: (14 * 32 + 7) * 2 = 910 = $038E

## Differences from NES Version

1. **CPU**: 65816 (native mode) vs 6502
2. **Memory**: 128 KB WRAM vs 2 KB RAM
3. **VRAM**: 64 KB vs 2 KB
4. **CGRAM**: 512 bytes (256 colors) vs 32 bytes (64 colors)
5. **OAM**: 544 bytes (128 sprites) vs 256 bytes (64 sprites)
6. **Registers**: $2100-$213F vs $2000-$2007
7. **ROM Format**: SNES header vs iNES header
8. **Tile Format**: 32 bytes (4 bitplanes) vs 16 bytes (2 bitplanes)
9. **Tilemap**: 32×32 tiles (1024 tiles) vs 32×30 tiles (960 tiles)

## Related Resources

- [S-NES-BOY Main README](../../README.md) - S-NES-BOY project overview
- [S-NES-BOY Documentation](../../../snes-docs/README.md) - Comprehensive development guide
- [SNES System Overview](../../../snes-docs/01-fundamentals/1.1-snes-system-overview.md) - Hardware basics
- [65816 CPU Fundamentals](../../../snes-docs/01-fundamentals/1.2-65816-cpu-fundamentals.md) - CPU details
- [SNES PPU Fundamentals](../../../snes-docs/01-fundamentals/1.4-ppu-fundamentals.md) - PPU details
- [higan Documentation](https://higan.readthedocs.io/en/stable/) - Official higan emulator documentation
- [SNES Toolchain](../../../snes-docs/06-tooling-debugging/6.1-toolchain.md) - Build system and toolchain
- [SNES Emulators & Debuggers](../../../snes-docs/06-tooling-debugging/6.2-emulators-debuggers.md) - higan usage and debugging
- [Hello World Project](../hello-world/README.md) - Full alphabet/lexicon example

## License

This project is part of the S-NES-BOY codebase and follows the same license terms.
