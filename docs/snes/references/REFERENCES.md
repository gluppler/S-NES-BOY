# SNES References

Authoritative documentation and resources for SNES hardware and programming.

## Primary Hardware Documentation

### SNES Dev Wiki
- URL: https://wiki.super.org/
- Description: Comprehensive SNES development resources and documentation.

### SNES Programming Resources
- SNES Programming Guide
  - URL: https://en.wikibooks.org/wiki/Super_NES_Programming
  - Description: SNES programming tutorials and guides.

## CPU Documentation

### 65816 CPU
- 65816.org
  - URL: http://www.65816.org/
  - Description: Complete 65816 processor documentation (SNES CPU).
- 65816 Programming Reference
  - URL: https://wiki.super.org/65816-reference
  - Description: SNES CPU programming reference.
- 65816 Instruction Set
  - URL: http://www.65816.org/
  - Description: Complete 65816 processor instruction set documentation.

## Memory Documentation

### Memory Map
- SNES Memory Map
  - URL: https://wiki.super.org/Memory_Map
  - Description: Complete SNES memory map including WRAM, VRAM, CGRAM, OAM.
- WRAM Documentation
  - URL: https://wiki.super.org/WRAM
  - Description: Work RAM (128 KB) documentation.

## PPU Documentation

### PPU Fundamentals
- SNES PPU Overview
  - URL: https://wiki.super.org/PPU
  - Description: SNES PPU architecture and capabilities.
- Background Modes
  - URL: https://wiki.super.org/BG_Mode
  - Description: Background rendering modes (Mode 0-7).
- Mode 7
  - URL: https://wiki.super.org/Mode_7
  - Description: Mode 7 affine transformation and effects.
- VRAM Documentation
  - URL: https://wiki.super.org/VRAM
  - Description: Video RAM (64 KB) organization and access.
- CGRAM Documentation
  - URL: https://wiki.super.org/CGRAM
  - Description: Color palette RAM (512 bytes, 256 colors).

## Sprite Documentation

### OAM and Sprites
- OAM Documentation
  - URL: https://wiki.super.org/OAM
  - Description: Object Attribute Memory (544 bytes, 128 sprites).
- Sprite System
  - URL: https://wiki.super.org/Sprites
  - Description: Sprite rendering, limits, and organization.

## Audio Documentation

### SPC700 Audio Processor
- SPC700 Documentation
  - URL: https://wiki.super.org/SPC700
  - Description: SPC700 audio processor architecture.
- Audio Registers
  - URL: https://wiki.super.org/Audio_Registers
  - Description: SPC700 register documentation.
- Audio Programming
  - URL: https://wiki.super.org/Audio_Programming
  - Description: SNES audio programming guide.

## Input Documentation

### Controller
- SNES Controller
  - URL: https://wiki.super.org/Controller
  - Description: SNES controller protocol and reading.
- Controller Ports
  - URL: https://wiki.super.org/Controller_Port
  - Description: Hardware controller port behavior.

## Timing Documentation

### System Timing
- VBlank and Interrupts
  - URL: https://wiki.super.org/VBlank
  - Description: VBlank timing and interrupt behavior.
- Frame Timing
  - URL: https://wiki.super.org/Frame_Timing
  - Description: Frame rate and timing specifications.

## DMA Documentation

### DMA and HDMA
- DMA Overview
  - URL: https://wiki.super.org/DMA
  - Description: Direct Memory Access channels and usage.
- HDMA Documentation
  - URL: https://wiki.super.org/HDMA
  - Description: H-Blank DMA for per-scanline effects.

## ROM Format Documentation

### File Formats
- SNES ROM Format
  - URL: https://wiki.super.org/ROM_Format
  - Description: SNES ROM header and format specification.
- LoROM Mapping
  - URL: https://wiki.super.org/LoROM
  - Description: LoROM memory mapping mode.
- HiROM Mapping
  - URL: https://wiki.super.org/HiROM
  - Description: HiROM memory mapping mode.

## Toolchain Documentation

### Assemblers and Compilers
- cc65 with 65816 Support
  - URL: https://cc65.github.io/
  - Repository: https://github.com/cc65/cc65
  - Description: C compiler and 65816 assembler toolchain.
- ca65 65816 Documentation
  - URL: https://cc65.github.io/doc/ca65.html
  - Description: ca65 assembler with 65816 CPU support.
- ld65 Linker Documentation
  - URL: https://cc65.github.io/doc/ld65.html
  - Description: ld65 linker for SNES projects.

## Emulator Documentation

### Development Emulators
- higan
  - URL: https://higan.readthedocs.io/en/stable/
  - Repository: https://github.com/higan-emu/higan
  - Description: Highly accurate multi-system emulator, recommended for SNES development.
- bsnes
  - URL: https://github.com/bsnes-emu/bsnes
  - Description: Highly accurate SNES emulator (higan's SNES core).

## Audio Tools

### Music and Sound
- SNES Audio Tools
  - URL: https://wiki.super.org/Audio_Tools
  - Description: Tools for SNES audio development.

## Graphics Tools

### Tile and Sprite Editors
- Aseprite
  - URL: https://www.aseprite.org/
  - Description: Professional sprite editor (supports SNES palettes).
- SNES Graphics Tools
  - URL: https://wiki.super.org/Graphics_Tools
  - Description: Tools for SNES graphics development.

## Testing and Validation

### Test ROMs
- SNES Test ROMs
  - URL: https://wiki.super.org/Test_ROMs
  - Description: SNES test ROM collection.

## Educational Resources

### Tutorials
- SNES Programming Tutorials
  - URL: https://wiki.super.org/Tutorials
  - Description: SNES programming tutorial collection.

## Codebases and Examples

### Example Projects
- SNES Example Projects
  - URL: https://wiki.super.org/Example_Projects
  - Description: SNES example codebases and projects.

### Canonical Reference Implementation
- snes-hello
  - URL: https://github.com/SlithyMatt/snes-hello
  - Description: Minimal SNES "Hello World" example demonstrating correct hardware initialization, native 65816 mode entry (`clc; xce`), DMA-based VRAM operations, and LoROM mapping. This repository serves as the canonical reference implementation for SNES initialization patterns and has been merged into the S-NES-BOY templates and examples. The code patterns from snes-hello are now integrated into `templates/snes/` and `examples/snes/hello_world/`.
  - Key Features:
    - Correct 65816 native mode entry sequence
    - Hardware-accurate DMA VRAM clearing
    - Proper SNES header structure (HEADER at +$7FE0, ROMINFO at +$7FD5)
    - Minimal, working SNES ROM structure
  - Note: This reference implementation has been fully integrated into S-NES-BOY templates and examples. The original repository remains available as an authoritative external reference.

## Community Resources

### Forums and Communities
- SNES Development Forums
  - URL: https://wiki.super.org/Forums
  - Description: SNES development community forums.

## Historical and Archival Documentation

### Primary Sources
- Nintendo Patent Documents
  - URL: https://patents.google.com/
  - Description: Official hardware patent documentation for SNES components.
