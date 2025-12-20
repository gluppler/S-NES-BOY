# PRNG 6502 Example

Complete working example demonstrating all three PRNG widths from the prng_6502 library.

## Overview

This example demonstrates how to use the `galois16`, `galois24`, and `galois32` LFSR-based random number generators for NES development. The example creates a simple NES ROM that:

- Generates random numbers using all three PRNG widths (16, 24, and 32-bit)
- Displays the random values on screen in hexadecimal
- Updates every frame
- Shows both simple and overlapped implementations

## Source

Based on [prng_6502](https://github.com/bbbradsmith/prng_6502) by Brad Smith (rainwarrior).

## Features

### PRNG Implementations

- **16-bit LFSR PRNG**: 
  - Simple version: 133-141 cycles, 19 bytes
  - Overlapped version: 69 cycles fixed, 35 bytes
  - Period: 65,535 numbers

- **24-bit LFSR PRNG**:
  - Simple version: 173-181 cycles, 21 bytes
  - Overlapped version: 73 cycles fixed, 38 bytes
  - Period: 16,777,215 numbers

- **32-bit LFSR PRNG**:
  - Simple version: 213-221 cycles, 23 bytes
  - Overlapped version: 83 cycles fixed, 44 bytes
  - Period: 4,294,967,295 numbers

### Visual Display

The example displays three hexadecimal values on screen at different rows:
- Row 10: Random value from 16-bit PRNG (2 hex digits)
- Row 12: Random value from 24-bit PRNG (2 hex digits)
- Row 14: Random value from 32-bit PRNG (2 hex digits)

Values update every frame (60 FPS on NTSC, 50 FPS on PAL). The hex digits use tiles $A0-$AF which should be present in the CHR file.

## Building

### Prerequisites

- `ca65` and `ld65` (cc65 toolchain)
- NES emulator (fceux, Mesen2, etc.)

### Build Commands

```bash
cd examples/nes/prng_6502_example
make
make run
```

### Build Targets

- `make` or `make all` - Build the ROM
- `make run` - Build and run in emulator
- `make clean` - Remove build artifacts
- `make help` - Show help message

## Usage

1. **Build the ROM**: `make`
2. **Run in emulator**: `make run`
3. **Observe**: Random hexadecimal values displayed on screen, updating each frame

The example uses the overlapped versions of each PRNG for optimal performance (fixed cycle counts, faster execution).

## Implementation Details

### Seed Initialization

Each PRNG has its own separate seed storage to avoid interference:
- 16-bit uses `seed16` (2 bytes)
- 24-bit uses `seed24` (3 bytes)
- 32-bit uses `seed32` (4 bytes)

Each seed is initialized to a non-zero value in the reset handler. This ensures that each PRNG generates independent random sequences.

### Code Structure

```
src/
├── main.asm      - Main program loop and NES initialization
├── common.asm    - Shared seed storage and variables
├── galois16.asm  - 16-bit PRNG implementations
├── galois24.asm  - 24-bit PRNG implementations
└── galois32.asm  - 32-bit PRNG implementations
```

### Performance Notes

The example uses overlapped versions for all three PRNGs because:
- Fixed cycle counts (important for frame timing)
- Faster execution (~2x speedup)
- Better for real-time applications

If code size is more important than speed, you can switch to the simple versions by changing the function calls in `main.asm`.

## Requirements

- `ca65` and `ld65` (cc65 toolchain)
- NES emulator (fceux, Mesen2, etc.)

## Related Documentation

- [prng_6502 Repository](https://github.com/bbbradsmith/prng_6502) - Original PRNG implementation
- [NES References](../../../../docs/nes/REFERENCES.md) - Authoritative NES development resources

## License

This example code may be used, reused, and modified for any purpose, commercial or non-commercial.

Attribution in released binaries or documentation is appreciated but not required.
