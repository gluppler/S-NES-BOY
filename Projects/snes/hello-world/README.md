# Hello World SNES Program

**This project applies to:**
- ✅ **SNES**: Primary focus
- ❌ **NES**: Does not apply (see `../../nes/` for NES projects)

A complete SNES program that displays text using a full alphabet/lexicon (A-Z, 0-9, punctuation). The code follows S-NES-BOY documentation best practices and includes a text rendering system.

## Overview

This program demonstrates complete text rendering on the SNES with a full character set. It serves as a foundational example for understanding SNES programming within the S-NES-BOY codebase.

## Features

- **Complete Alphabet/Lexicon**: All uppercase letters (A-Z), numbers (0-9), and common punctuation
- **Text Rendering System**: Write any text string to the tilemap
- **Character Lookup**: Efficient ASCII to tile index conversion
- **S-NES-BOY Best Practices**: Follows official S-NES-BOY documentation patterns
- **Clean Code Structure**: Well-organized with clear sections and comments
- **Mode 0 Graphics**: Uses Mode 0 (4 BGs, 4 colors per BG)

## Architecture

- **LoROM Mapping**: Banks $00-$7F
- **Mode 0**: 4 background layers, 4 colors per BG
- **Screen Resolution**: 256×224 pixels (NTSC)
- **Text System**: Null-terminated strings with automatic character conversion

## Requirements

- **ca65** - 65816 assembler (part of cc65) with `--cpu 65816` support
- **ld65** - Linker (part of cc65)
- **higan** - SNES emulator (recommended) - https://higan.readthedocs.io/en/stable/

### Installation

**Debian/Ubuntu:**
```bash
sudo apt-get install cc65 higan
```

**Arch Linux:**
```bash
sudo pacman -S cc65 higan
```

**From Source (higan):**
See https://higan.readthedocs.io/en/stable/install/linux/ for build instructions

## Building

```bash
make
```

This will:
1. Assemble `main.asm` to `main.o`
2. Link with `snes.cfg` to create `hello-world.sfc`

## Running

```bash
make run
```

This will launch higan with the ROM file. Per higan documentation, the ROM will load automatically. The program displays:
- "HELLO WORLD!" at row 5, column 5
- Complete alphabet (A-Z) at row 7
- Numbers (0-9) at row 8
- Punctuation at row 9

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
- **`load_background`**: Clears tilemap and writes text
- **`write_text`**: Writes null-terminated string to tilemap
- **`char_to_tile`**: Converts ASCII character to tile index

## SNES-Specific Features

### Native Mode

The program switches from emulation mode to native mode using:
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

## Differences from NES Version

1. **CPU**: 65816 (native mode) vs 6502
2. **Memory**: 128 KB WRAM vs 2 KB RAM
3. **VRAM**: 64 KB vs 2 KB
4. **CGRAM**: 512 bytes (256 colors) vs 32 bytes (64 colors)
5. **OAM**: 544 bytes (128 sprites) vs 256 bytes (64 sprites)
6. **Registers**: $2100-$213F vs $2000-$2007
7. **ROM Format**: SNES header vs iNES header
8. **Tile Format**: 32 bytes (4 bitplanes) vs 16 bytes (2 bitplanes)

## Optimization Notes

- **Direct Page Variables**: All hot data in direct page
- **Lookup Tables**: Pre-computed values for character conversion
- **Register Reuse**: Minimize memory access
- **Efficient Branches**: Not-taken preferred pattern
- **DMA Usage**: Fast bulk memory operations

## Related Resources

- [S-NES-BOY Main README](../../README.md) - S-NES-BOY project overview
- [S-NES-BOY Documentation](../../../snes-docs/README.md) - Comprehensive development guide
- [SNES System Overview](../../../snes-docs/01-fundamentals/1.1-snes-system-overview.md) - Hardware basics
- [65816 CPU Fundamentals](../../../snes-docs/01-fundamentals/1.2-65816-cpu-fundamentals.md) - CPU details
- [SNES PPU Fundamentals](../../../snes-docs/01-fundamentals/1.4-ppu-fundamentals.md) - PPU details
- [higan Documentation](https://higan.readthedocs.io/en/stable/) - Official higan emulator documentation
- [SNES Toolchain](../../../snes-docs/06-tooling-debugging/6.1-toolchain.md) - Build system and toolchain
- [SNES Emulators & Debuggers](../../../snes-docs/06-tooling-debugging/6.2-emulators-debuggers.md) - higan usage and debugging
- [Welcome Project](../welcome/README.md) - Centered text display example

## License

This project is part of the S-NES-BOY codebase and follows the same license terms.
