# SNES Hello World Learning Example

Minimal SNES "Hello World" example from the S-NES-BOY Learning & Development Framework, based on the canonical snes-hello implementation.

## Overview

This example is part of the S-NES-BOY framework and demonstrates correct SNES hardware initialization and basic text rendering. It is based on the snes-hello repository (https://github.com/SlithyMatt/snes-hello), which serves as the canonical reference for SNES development.

## Features

- Correct 65816 native mode entry (`clc; xce`)
- Proper register size configuration (`.p816`, `.i16`, `.a8`)
- DMA-based VRAM clearing
- Hardware-accurate PPU initialization
- LoROM mapping with correct header structure
- Minimal, working SNES ROM

## Building

```bash
make
```

This produces `hello.smc`, which can be loaded in any SNES emulator.

## Requirements

- cc65 toolchain (cl65)
- SNES emulator (bsnes, higan, etc.)

## Files

- `main.asm` - Main source file with initialization and rendering
- `snes.cfg` - Linker configuration for LoROM mapping
- `Makefile` - Build system (integrated snes-hello build process)
- `headers/` - Header files (snes.inc, charmap.inc)
- `assets/data/` - Character data (charset.asm)

## Reference

This example is based on [snes-hello](https://github.com/SlithyMatt/snes-hello), which serves as the canonical minimal SNES example.

The code patterns from snes-hello have been integrated into the S-NES-BOY templates at `templates/snes/`.

## Related Documentation

- [SNES Documentation Index](../../../docs/snes/README.md) – SNES documentation index
- [SNES Fundamentals](../../../docs/snes/fundamentals/) – Core SNES hardware concepts
- [SNES Gold Standard Examples](../../../docs/snes/gold_standard/) – Reference implementations
- [SNES Template](../../../templates/snes/) – Complete SNES template with full structure
- [Framework Overview](../../../README.md) – Main framework README
