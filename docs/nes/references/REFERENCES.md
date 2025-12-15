# NES References

Authoritative documentation and resources for NES hardware and programming.

## Primary Hardware Documentation

### NesDev Wiki
- URL: https://www.nesdev.org/wiki/Nesdev_Wiki
- Description: Primary source of truth for NES hardware behavior, registers, timing, PPU, APU, mappers, and quirks.

### NES Programming Guide
- URL: https://www.nesdev.org/wiki/Programming_guide
- Description: Step-by-step conceptual overview of NES programming.

## CPU Documentation

### 6502 CPU
- 6502 Instruction Set Reference
  - URL: http://www.obelisk.me.uk/6502/reference.html
  - Description: Canonical 6502 opcode documentation.
- 6502 Addressing Modes
  - URL: https://www.nesdev.org/wiki/Addressing_modes
  - Description: NES-specific behavior and quirks.
- Programming the 6502
  - URL: https://archive.org/details/Programming_the_6502
  - Description: Classic 6502 programming reference.
- 6502 Timing and Cycles
  - URL: https://www.nesdev.org/wiki/CPU_cycle_reference
  - Description: Critical for raster effects and stable code.
- 6502.org
  - URL: http://www.6502.org/
  - Description: Comprehensive 6502 processor documentation and resources.

## Memory Documentation

### Memory Map
- CPU Memory Map
  - URL: https://www.nesdev.org/wiki/CPU_memory_map
  - Description: Full CPU address map including RAM, PPU, APU, I/O.
- PPU Memory Map
  - URL: https://www.nesdev.org/wiki/PPU_memory_map
  - Description: PPU address space including pattern tables, nametables, palettes.

## PPU Documentation

### PPU Fundamentals
- PPU Overview
  - URL: https://www.nesdev.org/wiki/PPU
  - Description: Rendering, nametables, attributes, scrolling, sprite evaluation.
- PPU Registers
  - URL: https://www.nesdev.org/wiki/PPU_registers
  - Description: Complete PPU register reference ($2000-$2007).
- Nametables and Attribute Tables
  - URL: https://www.nesdev.org/wiki/Name_table
  - URL: https://www.nesdev.org/wiki/Attribute_table
  - Description: Background tile mapping and palette assignment.
- Sprites (OAM)
  - URL: https://www.nesdev.org/wiki/Sprite
  - Description: Sprite limits, priority, flipping, overflow.
- Scrolling Techniques
  - URL: https://www.nesdev.org/wiki/Scrolling
  - Description: Horizontal, vertical, four-way scrolling.
- CHR ROM vs CHR RAM
  - URL: https://www.nesdev.org/wiki/CHR_ROM_vs_CHR_RAM
  - Description: Pattern table storage options.

## APU Documentation

### Audio System
- APU Overview
  - URL: https://www.nesdev.org/wiki/APU
  - Description: Audio channels, registers, timing, envelopes.
- APU Register Reference
  - URL: https://www.nesdev.org/wiki/APU_registers
  - Description: Complete APU register documentation.
- NES Sound Hardware
  - URL: https://www.nesdev.org/wiki/Sound
  - Description: Audio channel architecture and capabilities.

## Input Documentation

### Controller
- Standard Controller
  - URL: https://www.nesdev.org/wiki/Standard_controller
  - Description: How $4016/$4017 controller reading works.
- Controller Ports
  - URL: https://www.nesdev.org/wiki/Controller_port
  - Description: Hardware controller port behavior.

## Timing Documentation

### System Timing
- NMI and VBlank
  - URL: https://www.nesdev.org/wiki/NMI
  - Description: NMI interrupt behavior and VBlank timing.
- Frame Timing
  - URL: https://www.nesdev.org/wiki/Frame_timing
  - Description: Frame rate and timing specifications (NTSC/PAL).
- Sprite DMA
  - URL: https://www.nesdev.org/wiki/OAM_DMA
  - Description: Object Attribute Memory DMA transfer ($4014).

## ROM Format Documentation

### File Formats
- iNES File Format
  - URL: https://www.nesdev.org/wiki/INES
  - Description: ROM header format used by most emulators.
- NES 2.0 Header Format
  - URL: https://www.nesdev.org/wiki/NES_2.0
  - Description: Modern replacement for iNES header.

### Mappers
- Mapper Reference
  - URL: https://www.nesdev.org/wiki/Mapper
  - Description: Bank switching hardware documentation.
- NROM (Mapper 0)
  - URL: https://www.nesdev.org/wiki/NROM
  - Description: Beginner-friendly mapper, no bank switching.

## Toolchain Documentation

### Assemblers and Compilers
- cc65 (C Compiler and ca65 Assembler)
  - URL: https://cc65.github.io/
  - Repository: https://github.com/cc65/cc65
  - Description: C compiler and 6502 assembler toolchain.
- ca65 Assembler Documentation
  - URL: https://cc65.github.io/doc/ca65.html
  - Description: Complete ca65 assembler reference.
- ld65 Linker Documentation
  - URL: https://cc65.github.io/doc/ld65.html
  - Description: Complete ld65 linker reference.
- asm6f (Lightweight Assembler)
  - URL: https://github.com/freem/asm6f
  - Description: Single-pass 6502 assembler.

## Emulator Documentation

### Development Emulators
- Mesen2
  - URL: https://github.com/SourMesen/Mesen2
  - Description: Cycle-accurate NES emulator with advanced debugging.
- FCEUX
  - URL: https://github.com/TASVideos/fceux
  - Official Website: https://fceux.com/web/home.html
  - Documentation: https://github.com/TASVideos/fceux/wiki
  - Description: NES emulator with comprehensive debugging tools.
- Nestopia UE
  - URL: https://github.com/0ldsk00l/nestopia
  - Description: Accurate NES emulator.

## Audio Tools

### Music and Sound
- FamiTracker
  - URL: https://github.com/Dn-Programming-Core-Management/0CC-FamiTracker
  - Description: Music tracker for NES.
- FamiTone2
  - URL: https://github.com/nesdoug/FamiTone2
  - Description: Standard NES sound engine for assembly projects.

## Graphics Tools

### Tile and Sprite Editors
- YY-CHR
  - URL: https://w.atwiki.jp/yychr/
  - Description: NES tile editor.
- NES Screen Tool (NESst)
  - URL: https://shiru.untergrund.net/software.shtml
  - Description: NES screen and tile editor.
- Aseprite
  - URL: https://www.aseprite.org/
  - Description: Professional sprite editor (supports NES palettes).

## Testing and Validation

### Test ROMs
- NES Test ROMs (Blargg)
  - URL: https://www.nesdev.org/wiki/Emulator_tests
  - Description: Comprehensive test ROM collection.
- PPU Test ROMs
  - URL: https://github.com/christopherpow/nes-test-roms
  - Description: PPU-specific test ROMs.
- CPU Test ROMs
  - URL: https://github.com/TASVideos/fceux/tree/master/test_roms
  - Description: CPU instruction and timing tests.

## Educational Resources

### Tutorials
- Nerdy Nights NES Tutorial
  - URL: https://www.nesdev.org/wiki/Nerdy_Nights
  - Description: Step-by-step NES programming tutorial series.
- NESDoug Tutorials
  - URL: https://nesdoug.com/
  - Description: Comprehensive NES programming tutorials (Assembly and C).
- Making Games for the NES
  - URL: https://www.manning.com/books/making-games-for-the-nes
  - Description: Book on NES game development.

## Codebases and Examples

### Example Projects
- NESLib
  - URL: https://github.com/clbr/neslib
  - Description: NES development library.
- NESDoug Example Projects
  - URL: https://github.com/nesdoug
  - Description: Collection of NES example projects.
- FamiTone2 Examples
  - URL: https://github.com/nesdoug/FamiTone2/tree/master/examples
  - Description: Audio integration examples.

## Community Resources

### Forums and Communities
- NesDev Forums
  - URL: https://forums.nesdev.org/
  - Description: Official NES development forums.
- NESDev Discord
  - URL: https://discord.gg/nesdev
  - Description: Real-time NES development community.
- r/nesdev (Reddit)
  - URL: https://www.reddit.com/r/nesdev/
  - Description: Reddit community for NES developers.

## Historical and Archival Documentation

### Primary Sources
- Nintendo Patent Documents
  - URL: https://patents.google.com/
  - Description: Official hardware patent documentation for PPU/APU behavior.
- Visual 2A03
  - URL: http://visual6502.org/JSSim/expert.html
  - Description: Transistor-level CPU simulation and analysis.
