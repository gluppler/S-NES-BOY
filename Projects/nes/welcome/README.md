# Welcome to S-NES-BOY

A centered text display project for the NES that displays "Welcome to S-NES-BOY" centered on screen. This project demonstrates proper text centering, name table rendering, and follows all S-NES-BOY principles and documentation.

## Overview

This program displays "Welcome to S-NES-BOY" centered both horizontally and vertically on the NES screen. It serves as a simple demonstration of text rendering and proper NES programming practices following S-NES-BOY documentation.

## Features

- **Centered Text Display: Text is perfectly centered horizontally and vertically on the NES screen
- **Name Table Rendering: Uses name table for background text rendering
- **Hardware Accurate: Follows strict NES documentation principles and optimization techniques
- **S-NES-BOY Compliant**: Follows all principles and laws of code established in the S-NES-BOY codebase

## Architecture

- **16 KB PRG ROM** (Mapper 0, NROM)
- **8 KB CHR ROM** (512 tiles)
- **Name Table Rendering** using background tiles
- **8x8 Tile Mode** for character display

## Requirements

- `ca65` (assembler, part of cc65)
- `ld65` (linker, part of cc65)
- `FCEUX` or compatible NES emulator

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

## Technical Details

### Text Centering

The text "WELCOME TO S-NES-BOY" has 20 characters:
- **Horizontal center: (32 - 17) / 2 = 7.5, rounded down to column 7
- **Vertical center: Row 14 (perfect visual center: 14 rows above, 15 rows below)
- **Address: $21C7 = $2000 + (14 × 32) + 7

### Name Table Layout

- Name table: $2000-$23BF (960 bytes, 32×30 tiles)
- Attribute table: $23C0-$23FF (64 bytes)
- Text uses palette 0 (attribute bytes set to 0)

### Character Rendering

The program uses the same character tiles as the hello-world project:
- Complete alphabet (A-Z)
- Numbers (0-9)
- Common punctuation

## Files

- `main.asm` - Main assembly source with text rendering
- `chars_data.asm` - CHR ROM data with character tiles (shared with hello-world)
- `nes.cfg` - Linker configuration (16 KB PRG ROM, 8 KB CHR ROM)
- `Makefile` - Build system with targets
- `README.md` - This file

## Code Structure

1. **Zero Page Variables: Text pointer for efficient access
2. **Reset Handler: System initialization following NES documentation
3. **NMI Handler: Frame-synchronized rendering updates
4. **Text Rendering: Functions for writing text to name table
5. **Character Conversion: ASCII to tile index lookup
6. **Data Section: Palettes and text strings

## Customization

### Change Text

Modify the text string in the data section:

```asm
hello_text:
    .byte "YOUR TEXT HERE", 0
```

**Note: Adjust the centering calculation in `load_background` if text length changes.

## Build Targets

- `make` or `make all` - Build ROM (default)
- `make clean` - Remove build artifacts (object files and ROM)
- `make distclean` - Deep clean
- `make verify` - Verify ROM structure (size and header)
- `make run` - Run ROM in FCEUX
- `make help` - Show help information

## Optimization Techniques

This program uses advanced optimization techniques from S-NES-BOY documentation:

- **Zero Page Variables: All frequently accessed data in zero page ($0000-$00FF)
- **Lookup Tables: Character-to-tile conversion uses lookup table (4 cycles vs 10+ cycles with branches)
- **Register Reuse: Keep values in A, X, Y registers to avoid memory access
- **Efficient Branches: Not-taken preferred, early exits, no JMP in loops
- **Sequential Memory Access: Optimized memory access patterns
- **Fastest Addressing Modes: Immediate, zero page, indexed addressing

## Related Documentation

- [S-NES-BOY Main README](../../README.md) - S-NES-BOY project overview
- [S-NES-BOY Documentation](../../../nes-docs/README.md) - Comprehensive development guide
- [PPU Fundamentals](../../../nes-docs/01-fundamentals/1.4-ppu-fundamentals.md) - Name table and rendering details
- [Rendering Architecture](../../../nes-docs/03-core-concepts/3.3-rendering-architecture.md) - PPU update patterns
- [Hello World Project](../hello-world/README.md) - Complete text rendering example

## Notes

- Uses tile indices to display text
- Text is positioned using name table addresses
- All character tiles are included in CHR ROM (shared with hello-world)
- Code follows S-NES-BOY documentation best practices
- Zero page variables used for efficiency
- Proper NMI handler with register saving
- Hardware-accurate implementation

## Troubleshooting

### Build Issues

- **"ca65: comm and not found": Install cc65 package
- **"ld65: comm and not found": Install cc65 package
- **Linker errors: Check `nes.cfg` matches segment definitions

### Runtime Issues

- **Blank screen: Check PPU initialization in `reset:`
- **Text not displaying: Verify CHR ROM contains character tiles
- **Wrong characters: Check character-to-tile mapping in `char_to_tile`
- **Text not centered: Verify centering calculation matches text length

## References

This code follows patterns from:
- S-NES-BOY documentation
- Official NES hardware documentation
- Best practices for 6502 assembly on NES

## License

This project is part of S-NES-BOY and is licensed under the MIT License.

---

**Note: This program follows hardware-accurate NES programming practices. All code is designed to work on real NES hardware, not just emulators.
