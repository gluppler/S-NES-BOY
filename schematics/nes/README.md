# NES Hardware Schematics

Hardware schematic diagrams for the Nintendo Entertainment System console and cartridges.

## Overview

This directory contains KiCad schematic diagrams and PDF exports for NES hardware components. These schematics provide detailed circuit-level information about the NES console and various cartridge types, essential for understanding hardware behavior and developing accurate emulators or hardware projects.

**Note**: All schematics have been validated with multimeter measurements and cross-referenced with official documentation. These are accurate, hardware-verified circuit diagrams.

## Console Schematics

### NES-001 Console

The main NES console (NTSC model) schematic showing complete system architecture:

**View Schematic**: [NES-001.pdf](NES-001%20Console/NES-001.pdf) (GitHub will display PDF inline)

- **Schematic File**: [`NES-001 Console/NES-001.sch`](NES-001%20Console/NES-001.sch) - KiCad schematic (editable)
- **PCB Layout**: [`NES-001 Console/NES-001.kicad_pcb`](NES-001%20Console/NES-001.kicad_pcb) - KiCad PCB layout
- **PDF Export**: [`NES-001 Console/NES-001.pdf`](NES-001%20Console/NES-001.pdf) - Schematic PDF (viewable)

**Components Documented:**
- Ricoh 2A03 CPU (6502 variant with integrated APU)
- Ricoh 2C02 PPU (Picture Processing Unit)
- Memory mapping and bus connections
- Controller port connections ($4016, $4017)
- Power supply and clock generation
- Video output circuitry
- Expansion port connections

**Hardware Details:**
- CPU clock: 1.789773 MHz (NTSC)
- PPU clock: 5.369318 MHz (NTSC)
- 2 KB work RAM ($0000-$1FFF)
- 2 KB VRAM (internal to PPU)
- Memory-mapped I/O registers ($2000-$2007, $4000-$401F)

**Note**: RF modulator schematic not included (separate unit).

### HVC-001 Console (Famicom)

The original Famicom console schematic:

**View Schematic**: [HVC-001.pdf](HVC-001%20Console/HVC-001.pdf) (GitHub will display PDF inline)

- **Schematic File**: [`HVC-001 Console/HVC-001.sch`](HVC-001%20Console/HVC-001.sch) - KiCad schematic
- **PCB Layout**: [`HVC-001 Console/HVC-001.kicad_pcb`](HVC-001%20Console/HVC-001.kicad_pcb) - KiCad PCB layout
- **PDF Export**: [`HVC-001 Console/HVC-001.pdf`](HVC-001%20Console/HVC-001.pdf) - Schematic PDF

**Differences from NES-001:**
- Built-in RF modulator (no separate RF box)
- Different controller port design
- Audio mixing differences
- Expansion port for accessories

## Cartridge Schematics

### NROM (Mapper 0) {#nrom-mapper-0}

Simple cartridge with no mapper chip - the simplest NES cartridge design:

**View Schematic**: [NES-NROM-128-03.pdf](Cartridges/NES/NES-NROM-128-03/NES-NROM-128-03.pdf) (GitHub will display PDF inline)

- **NES-NROM-128-03**: 128 KB PRG ROM variant
  - **Schematic**: [`Cartridges/NES/NES-NROM-128-03/NES-NROM-128-03.sch`](Cartridges/NES/NES-NROM-128-03/NES-NROM-128-03.sch)
  - **PDF**: [`Cartridges/NES/NES-NROM-128-03/NES-NROM-128-03.pdf`](Cartridges/NES/NES-NROM-128-03/NES-NROM-128-03.pdf)
  - **PCB Layout**: [`Cartridges/NES/NES-NROM-128-03/NES-NROM-128-03.kicad_pcb`](Cartridges/NES/NES-NROM-128-03/NES-NROM-128-03.kicad_pcb)

**Features:**
- Direct PRG/CHR ROM connection
- No bank switching hardware
- Simplest cartridge design
- Used by many early NES games
- 16 KB or 32 KB PRG ROM
- 8 KB CHR ROM

**Related Documentation**: See [ROM Fundamentals](../../docs/nes/fundamentals/1.5-rom-fundamentals.md) for NROM details.

### CNROM (Mapper 3)

Character ROM switching cartridge using 74xx logic:

**View Schematic**: [NES-CN-ROM-256-05.pdf](Cartridges/NES/NES-CN-ROM-256-05/NES-CN-ROM-256-05.pdf) (GitHub will display PDF inline)

- **NES-CN-ROM-256-05**: 256 KB CHR ROM variant
  - **Schematic**: [`Cartridges/NES/NES-CN-ROM-256-05/NES-CN-ROM-256-05.sch`](Cartridges/NES/NES-CN-ROM-256-05/NES-CN-ROM-256-05.sch)
  - **PDF**: [`Cartridges/NES/NES-CN-ROM-256-05/NES-CN-ROM-256-05.pdf`](Cartridges/NES/NES-CN-ROM-256-05/NES-CN-ROM-256-05.pdf)

**Features:**
- CHR ROM bank switching
- 74xx logic for bank selection
- PRG ROM fixed (no switching)
- Used for games with large tile sets
- Simple address decoding

### UNROM (Mapper 2)

PRG ROM bank switching cartridge:

**View Schematic**: [NES-UNROM-09.pdf](Cartridges/NES/NES-UNROM-09/NES-UNROM-09.pdf) (GitHub will display PDF inline)

- **NES-UNROM-09**: UNROM variant
  - **Schematic**: [`Cartridges/NES/NES-UNROM-09/NES-UNROM-09.sch`](Cartridges/NES/NES-UNROM-09/NES-UNROM-09.sch)
  - **PDF**: [`Cartridges/NES/NES-UNROM-09/NES-UNROM-09.pdf`](Cartridges/NES/NES-UNROM-09/NES-UNROM-09.pdf)

**Features:**
- PRG ROM bank switching
- 74xx logic for bank selection
- Fixed last bank at $C000-$FFFF
- CHR ROM fixed (no switching)
- Used by many commercial games

### SNROM (Mapper 1 - MMC1) {#snrom-mapper-1---mmc1}

MMC1 mapper cartridge with advanced bank switching:

**View Schematic**: [NES-SNROM-02.pdf](Cartridges/NES/NES-SNROM-02/NES-SNROM-02.pdf) (GitHub will display PDF inline)

- **NES-SNROM-02**: SNROM variant
  - **Schematic**: [`Cartridges/NES/NES-SNROM-02/NES-SNROM-02.sch`](Cartridges/NES/NES-SNROM-02/NES-SNROM-02.sch)
  - **PDF**: [`Cartridges/NES/NES-SNROM-02/NES-SNROM-02.pdf`](Cartridges/NES/NES-SNROM-02/NES-SNROM-02.pdf)

**Features:**
- MMC1 mapper chip (custom ASIC)
- PRG and CHR bank switching
- Battery-backed save RAM support
- Serial register interface
- Mirroring control
- Used by many popular NES games (Super Mario Bros., The Legend of Zelda, etc.)

**Related Examples**: See [SNROM Example](../../examples/nes/snrom_example/) for MMC1 implementation.

### TLROM (Mapper 4 - MMC3)

MMC3 mapper cartridge with advanced features:

**View Schematic**: [NES-TLROM-02.pdf](Cartridges/NES/NES-TLROM-02/NES-TLROM-02.pdf) (GitHub will display PDF inline)

- **NES-TLROM-02**: TLROM variant
  - **Schematic**: [`Cartridges/NES/NES-TLROM-02/NES-TLROM-02.sch`](Cartridges/NES/NES-TLROM-02/NES-TLROM-02.sch)
  - **PDF**: [`Cartridges/NES/NES-TLROM-02/NES-TLROM-02.pdf`](Cartridges/NES/NES-TLROM-02/NES-TLROM-02.pdf)

**Features:**
- MMC3 mapper chip (custom ASIC)
- Advanced PRG/CHR bank switching
- IRQ generation for scanline effects
- Fine-grained bank control (8 KB PRG, 1 KB CHR)
- Used by many advanced NES games (Super Mario Bros. 3, Mega Man series, etc.)

### TSROM (Mapper 4 - MMC3 with SRAM)

MMC3 mapper with save RAM:

**View Schematic**: [NES-TSROM-07.pdf](Cartridges/NES/NES-TSROM-07/NES-TSROM-07.pdf) (GitHub will display PDF inline)

- **NES-TSROM-07**: TSROM variant
  - **Schematic**: [`Cartridges/NES/NES-TSROM-07/NES-TSROM-07.sch`](Cartridges/NES/NES-TSROM-07/NES-TSROM-07.sch)
  - **PDF**: [`Cartridges/NES/NES-TSROM-07/NES-TSROM-07.pdf`](Cartridges/NES/NES-TSROM-07/NES-TSROM-07.pdf)

**Features:**
- MMC3 mapper chip
- Battery-backed save RAM
- Advanced bank switching
- IRQ support for raster effects

### SEROM (Mapper 1 - MMC1 variant)

MMC1 variant cartridge:

**View Schematic**: [NES-SEROM-04.pdf](Cartridges/NES/NES-SEROM-04/NES-SEROM-04.pdf) (GitHub will display PDF inline)

- **NES-SEROM-04**: SEROM variant
  - **Schematic**: [`Cartridges/NES/NES-SEROM-04/NES-SEROM-04.sch`](Cartridges/NES/NES-SEROM-04/NES-SEROM-04.sch)
  - **PDF**: [`Cartridges/NES/NES-SEROM-04/NES-SEROM-04.pdf`](Cartridges/NES/NES-SEROM-04/NES-SEROM-04.pdf)

**Features:**
- MMC1 mapper chip
- Variant of SNROM design
- Different PRG/CHR configuration

### MH-ROM (Mapper 0 variant)

NROM variant:

**View Schematic**: [NES-MH-ROM-02.pdf](Cartridges/NES/NES-MH-ROM-02/NES-MH-ROM-02.pdf) (GitHub will display PDF inline)

- **NES-MH-ROM-02**: MH-ROM variant
  - **Schematic**: [`Cartridges/NES/NES-MH-ROM-02/NES-MH-ROM-02.sch`](Cartridges/NES/NES-MH-ROM-02/NES-MH-ROM-02.sch)
  - **PDF**: [`Cartridges/NES/NES-MH-ROM-02/NES-MH-ROM-02.pdf`](Cartridges/NES/NES-MH-ROM-02/NES-MH-ROM-02.pdf)

**Features:**
- NROM variant (Mapper 0)
- Simple design
- No bank switching

### Famicom Cartridges

Original Famicom cartridge schematics:

- **HVC-FamilyBasic**: Famicom Family Basic cartridge
  - **Schematic**: [`Cartridges/Famicom/HVC-FamilyBasic/HVC-FamilyBasic.sch`](Cartridges/Famicom/HVC-FamilyBasic/HVC-FamilyBasic.sch)
  - **PDF**: [`Cartridges/Famicom/HVC-FamilyBasic/HVC-FamilyBasic.pdf`](Cartridges/Famicom/HVC-FamilyBasic/HVC-FamilyBasic.pdf)

## Using the Schematics

### Viewing PDF Schematics

PDF files can be viewed directly in GitHub (inline display) or downloaded:

1. **GitHub Inline View**: Click any PDF link - GitHub will display the PDF inline in the browser
2. **Download**: Right-click PDF link and "Save As" to download
3. **Local Viewer**: Open downloaded PDF with viewer (Evince, Okular, Adobe Reader, etc.)

**Note**: GitHub automatically renders PDF files inline when you click the links. The schematics will be displayed as images within the GitHub interface.

### Opening KiCad Files

To view or edit KiCad schematic files (`.sch`) and PCB layouts (`.kicad_pcb`):

1. **Install KiCad**: Available for Linux, Windows, and macOS
   ```bash
   # Linux (Debian/Ubuntu)
   sudo apt-get install kicad
   
   # Linux (Arch)
   sudo pacman -S kicad
   ```

2. **Open Project**: 
   ```bash
   kicad schematics/nes/NES-001\ Console/NES-001.pro
   ```

3. **View Components**: KiCad provides component libraries and allows inspection of all connections, pin numbers, and signal routing

### Understanding Schematic Symbols

Common symbols in NES schematics:
- **CPU (2A03)**: Central processing unit with integrated APU
- **PPU (2C02)**: Picture Processing Unit for video generation
- **ROM chips**: Program and Character ROM storage
- **RAM chips**: Work RAM and save RAM
- **74xx logic**: TTL logic chips for address decoding and bank switching
- **Mapper chips**: Custom ASICs for advanced bank switching (MMC1, MMC3, etc.)
- **Connectors**: Cartridge connector, controller ports, expansion port

## Hardware Components Reference

### Console Components

**NES-001 Console:**
- Ricoh 2A03 CPU (1.789773 MHz NTSC)
- Ricoh 2C02 PPU (5.369318 MHz NTSC)
- 2 KB work RAM ($0000-$1FFF)
- 2 KB VRAM (internal to PPU)
- Controller ports (2 ports at $4016, $4017)
- Expansion port
- RF modulator (separate unit, not in schematic)

**HVC-001 Console (Famicom):**
- Same CPU/PPU as NES-001
- Built-in RF modulator
- Different controller design
- Expansion port for accessories

### Cartridge Components

**Common Components:**
- PRG ROM: Program code storage (8 KB to 1 MB+)
- CHR ROM: Character/tile graphics (8 KB to 512 KB+)
- CHR RAM: Writable character memory (some cartridges)
- Mapper chip: Bank switching logic (MMC1, MMC3, etc.)
- Save RAM: Battery-backed memory (some cartridges)
- 74xx logic: Address decoding and control
- Battery: For save RAM persistence (some cartridges)

## Schematic Accuracy

All schematics in this directory have been:
- **Validated with multimeter measurements** on real hardware
- **Cross-referenced with official documentation** where available
- **Verified against multiple sources** for accuracy
- **Checked for pin numbers and reference designators**

**Source**: These schematics were created by reverse engineering actual NES hardware and validating connections with physical measurements.

## Cross-References

### Related Documentation

- [NES System Overview](../../docs/nes/fundamentals/1.1-nes-system-overview.md) - Hardware overview
- [ROM Fundamentals](../../docs/nes/fundamentals/1.5-rom-fundamentals.md) - Cartridge and mapper details
- [CPU Fundamentals](../../docs/nes/fundamentals/1.2-6502-cpu-fundamentals.md) - 2A03 CPU details
- [PPU Fundamentals](../../docs/nes/fundamentals/1.4-ppu-fundamentals.md) - 2C02 PPU details
- [Memory Fundamentals](../../docs/nes/fundamentals/1.3-memory-fundamentals.md) - Memory mapping
- [NES References](../../docs/nes/REFERENCES.md) - External hardware resources

### Related Examples

- [NROM Example](../../examples/nes/nrom_example/) - NROM cartridge template demonstrating mapper 0
- [SNROM Example](../../examples/nes/snrom_example/) - SNROM/MMC1 cartridge template demonstrating mapper 1 with bank switching

### External Resources

- [NES Dev Wiki - Hardware](https://www.nesdev.org/wiki/Hardware) - Hardware documentation
- [NES Dev Wiki - Mappers](https://www.nesdev.org/wiki/Mapper) - Mapper documentation
- [PPU Pinout](https://www.nesdev.org/wiki/PPU_pinout) - PPU pin connections
- [Controller Port Pinout](https://www.nesdev.org/wiki/Controller_port_pinout) - Controller connections
- [Cartridge Connector](https://www.nesdev.org/wiki/Cartridge_connector) - Cartridge pinout

## File Formats

- **`.sch`**: KiCad schematic file (editable with KiCad)
- **`.kicad_pcb`**: KiCad PCB layout file (editable with KiCad)
- **`.pdf`**: PDF export of schematic (viewable in any PDF viewer, displays in GitHub)
- **`.pro`**: KiCad project file (opens entire project)
- **`.lib`**: KiCad library files (component definitions)

## License

These schematics are licensed under [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a>

## Contributing

If you have additional NES schematic diagrams or corrections:
1. Ensure schematics are accurate and verified with hardware measurements
2. Use KiCad format for consistency
3. Include PDF exports for easy viewing
4. Document any variant-specific details
5. Follow the existing directory structure
6. Include validation notes (multimeter measurements, cross-references)

## Notes

- Schematics are provided in KiCad format for editing and PDF format for viewing
- All schematics are based on real hardware reverse engineering
- Component values and connections match actual NES hardware
- Some schematics may include variant-specific details
- PDF exports are generated from KiCad and may be updated
- GitHub will display PDF files inline when viewing the repository
