# S-NES-BOY NES Template - Complete Project Suite

A full-featured NES project template with comprehensive modular architecture, ready for immediate use. This template provides a complete foundation for NES development with proper initialization, NMI handling, frame synchronization, and a comprehensive library system, following all S-NES-BOY principles and documentation.

**This template applies to:
- ✅ **NES (Nintendo Entertainment System): Primary focus
- ✅ **: Fully compatible (same hardware)
- ❌ **SNES: Does not apply (see `../snes/` for SNES template)

## Overview

This template includes:

- **Complete NES initialization: Proper reset sequence, RAM clearing, PPU setup
- **NMI handler: Frame-synchronized interrupt handler for rendering updates
- **Main loop: Frame-based game loop with proper synchronization
- **Modular architecture: Organized directory structure
- **Memory management: Zero page, RAM, OAM, and stack definitions
- **Constants system: CPU, PPU, APU, controller, and mapper constants
- **Input system: Controller input with pressed/released detection and debouncing
- **State machine: Game state management system
- **Screen modules: Welcome, menu, game, pause, and ending screens
- **PPU system: Initialization, writing, scrolling, and attributes
- **Sprite system: DMA, buffer management, and utilities
- **Text system: Font mapping, printing, and centered text
- **Palette system: Data, loading, and fading
- **Tilemap system: Definitions, loading, metatiles, and collision
- **Audio system: APU initialization, music, and sound effects
- **Game logic: Entities, collisions, and rules
- **Build system: Makefile with organized output directory
- **S-NES-BOY Compliant**: Follows all principles and laws of code established in the S-NES-BOY codebase

## Directory Structure

```
template/
├── Makefile
├── README.md
├── .gitignore
│
├── linker/              # Linker configurations
│  ├── nrom.cfg          # NROM (Mapper 0) configuration
│  ├── mmc1.cfg          # MMC1 mapper configuration (placeholder)
│  ├── mmc3.cfg          # MMC3 mapper configuration (placeholder)
│  └── custom.cfg        # Custom mapper configuration (placeholder)
│
├── src/                 # Source code
│  ├── main.asm          # Main entry point
│  ├── reset.asm         # Reset handler
│  ├── vectors.asm      # Interrupt vectors
│  ├── nmi.asm           # NMI handler
│  ├── irq.asm           # IRQ handler
│  │
│  ├── memory/           # Memory definitions
│  │  ├── zeropage.inc   # Zero page variables
│  │  ├── ram.inc        # RAM variables
│  │  ├── oam.inc        # OAM buffer definitions
│  │  └── stack.inc      # Stack definitions
│  │
│  ├── macros/           # Assembly macros
│  │  ├── registers.inc  # Register save/restore macros
│  │  ├── ppu.inc        # PPU operation macros
│  │  ├── memory.inc     # Memory operation macros
│  │  ├── math.inc        # Math operation macros
│  │  ├── sprites.inc    # Sprite operation macros
│  │  ├── loops.inc      # Loop pattern macros
│  │  ├── branches.inc   # Branch pattern macros
│  │  ├── controller.inc # Controller operation macros
│  │  ├── text.inc       # Text operation macros
│  │  └── timing.inc     # Timing and delay macros
│  │
│  ├── constants/        # Constants
│  │  ├── cpu.inc        # CPU constants
│  │  ├── ppu.inc        # PPU constants
│  │  ├── apu.inc        # APU constants
│  │  ├── controller.inc # Controller constants
│  │  └── mapper.inc     # Mapper constants
│  │
│  ├── input/            # Input system
│  │  ├── controller.asm # Controller reading
│  │  ├── debounce.asm   # Input debouncing
│  │  └── input_state.inc # Input state definitions
│  │
│  ├── state/            # State management
│  │  ├── state_machine.asm # State machine
│  │  ├── state_ids.inc  # State IDs
│  │  └── transitions.asm # State transitions
│  │
│  ├── screens/          # Screen modules
│  │  ├── welcome.asm    # Welcome screen
│  │  ├── menu.asm       # Menu screen
│  │  ├── game.asm       # Game screen
│  │  ├── pause.asm      # Pause screen
│  │  └── ending.asm     # Ending screen
│  │
│  ├── ppu/              # PPU system
│  │  ├── ppu_init.asm   # PPU initialization
│  │  ├── ppu_queue.asm  # PPU write queue
│  │  ├── ppu_write.asm  # PPU write utilities
│  │  ├── scrolling.asm  # Scrolling management
│  │  └── attributes.asm # Attribute table management
│  │
│  ├── tilemap/          # Tilemap system
│  │  ├── tilemap_defs.inc # Tilemap definitions
│  │  ├── tilemap_loader.asm # Tilemap loading
│  │  ├── metatiles.inc  # Metatile definitions
│  │  ├── metatile_decode.asm # Metatile decoding
│  │  ├── collision_map.asm # Collision detection
│  │  └── tilemap_state.inc # Tilemap state
│  │
│  ├── text/             # Text system
│  │  ├── font_map.inc   # Font mapping
│  │  ├── print.asm      # Text printing
│  │  ├── print_centered.asm # Centered text
│  │  └── strings.asm    # String data
│  │
│  ├── sprites/          # Sprite system
│  │  ├── sprite_dma.asm # Sprite DMA
│  │  ├── sprite_buffer.inc # Sprite buffer
│  │  ├── sprite_utils.asm # Sprite utilities
│  │  └── sprite_defs.inc # Sprite definitions
│  │
│  ├── palette/          # Palette system
│  │  ├── palette_data.asm # Palette data
│  │  ├── palette_load.asm # Palette loading
│  │  └── palette_fade.asm # Palette fading
│  │
│  ├── audio/            # Audio system
│  │  ├── apu_init.asm   # APU initialization
│  │  ├── music.asm      # Music system
│  │  ├── sfx.asm        # Sound effects
│  │  └── audio_state.inc # Audio state
│  │
│  └── game/             # Game logic
│     ├── entities.asm   # Entity system
│     ├── entity_update.asm # Entity updates
│     ├── collisions.asm # Collision detection
│     └── rules.asm      # Game rules
│
├── data/                # Data files
│  ├── tilemaps/         # Tilemap data
│  │  ├── welcome.tilemaps
│  │  ├── level01.tilemaps
│  │  └── level02.tilemaps
│  │
│  ├── nametables/       # Name table data
│  │  ├── title.nam
│  │  └── ending.nam
│  │
│  └── tables/           # Lookup tables
│     ├── sine.tbl
│     └── lookup.tbl
│
├── graphics/            # Graphics files
│  ├── chr/              # CHR ROM files
│  │  ├── font.chr
│  │  ├── ui.chr
│  │  ├── sprites.chr
│  │  └── background.chr
│  │
│  ├── palettes/         # Palette files
│  │  ├── default.pal
│  │  └── night.pal
│  │
│  └── source/           # Source graphics (ignored by git)
│     ├── font.png
│     ├── ui.psd
│     └── sprites.png
│
├── tests/               # Test files
│  ├── cpu_tests/
│  ├── ppu_tests/
│  └── timing_tests/
│
├── debug/               # Debug utilities
│  ├── debug_overlay.asm
│  └── breakpoints.asm
│
└── build/               # Build output (generated)
   ├── rom/              # Compiled ROM
   │  └── game.nes
   ├── obj/              # Object files
   └── map/              # Map files
```

## Quick Start

1. **Build the ROM:
   ```bash
   make
   ```
   This creates `build/rom/game.nes`

2. **Run in emulator:
   ```bash
   make run
   ```

3. **Clean build files:
   ```bash
   make clean
   ```

## Requirements

- **ca65** - 6502 assembler (part of cc65)
- **ld65** - Linker (part of cc65)
- **FCEUX** - NES emulator

### Installation

**Debian/Ubuntu:
```bash
sudo apt-get install cc65
```

**Arch Linux:
```bash
sudo pacman -S cc65
```

## Module Documentation

### Memory Definitions (`src/memory/`)

- `zeropage.inc` - Zero page variable definitions ($00-$FF)
- `ram.inc` - RAM variable definitions ($0300-$07FF)
- `oam.inc` - OAM buffer and sprite definitions
- `stack.inc` - Stack definitions

### Macros (`src/macros/`)

- `registers.inc` - Register save/restore macros
- `ppu.inc` - PPU operation macros (set address, write data, etc.)
- `memory.inc` - Memory operation macros (clear, copy, fill)
- `math.inc` - Math operation macros (multiply, divide, compare)
- `sprites.inc` - Sprite operation macros (set position, tile, attributes)
- `loops.inc` - Loop pattern macros
- `branches.inc` - Branch pattern macros
- `controller.inc` - Controller operation macros
- `text.inc` - Text operation macros
- `timing.inc` - Timing and delay macros

### Constants (`src/constants/`)

- `cpu.inc` - CPU flags and timing constants
- `ppu.inc` - PPU register addresses and constants
- `apu.inc` - APU register addresses and constants
- `controller.inc` - Controller constants and button indices
- `mapper.inc` - Mapper constants for iNES header

### Input System (`src/input/`)

- `controller.asm` - Controller reading with pressed/released detection
- `debounce.asm` - Input debouncing utilities
- `input_state.inc` - Input state variable definitions

### State Management (`src/state/`)

- `state_machine.asm` - Game state machine implementation
- `state_ids.inc` - State ID constants
- `transitions.asm` - State transition functions

### PPU System (`src/ppu/`)

- `ppu_init.asm` - PPU initialization
- `ppu_write.asm` - PPU write utilities
- `scrolling.asm` - Scroll register management
- `attributes.asm` - Attribute table utilities

### Sprite System (`src/sprites/`)

- `sprite_utils.asm` - Sprite initialization and OAM buffer updates
- `sprite_dma.asm` - Sprite DMA handling
- `sprite_buffer.inc` - Sprite buffer definitions
- `sprite_defs.inc` - Sprite constants

### Text System (`src/text/`)

- `print.asm` - Text printing to name table
- `print_centered.asm` - Centered text printing
- `font_map.inc` - Character to tile index lookup tables
- `strings.asm` - Text string data

### Palette System (`src/palette/`)

- `palette_data.asm` - Palette color data
- `palette_load.asm` - Palette loading to PPU
- `palette_fade.asm` - Palette fading utilities

### Tilemap System (`src/tilemap/`)

- `tilemap_loader.asm` - Tilemap loading to name table
- `tilemap_defs.inc` - Tilemap constants
- `metatiles.inc` - Metatile definitions
- `collision_map.asm` - Collision detection

### Audio System (`src/audio/`)

- `apu_init.asm` - APU initialization
- `music.asm` - Music playback system
- `sfx.asm` - Sound effect system
- `audio_state.inc` - Audio state variables

### Game Logic (`src/game/`)

- `entities.asm` - Entity system
- `entity_update.asm` - Entity update logic
- `collisions.asm` - Collision detection
- `rules.asm` - Game rules

### Screen Modules (`src/screens/`)

- `welcome.asm` - Welcome/title screen
- `menu.asm` - Menu screen
- `game.asm` - Main game screen
- `pause.asm` - Pause screen
- `ending.asm` - Ending screen

## Build Configuration

The default linker configuration is `linker/nrom.cfg` for Mapper 0 (NROM). To use a different mapper, modify the `CFG` variable in `Makefile`:

```makefile
CFG = linker/mmc1.cfg  # For MMC1 mapper
```

## Customization

### Adding Your Game Logic

1. Edit `src/game/entities.asm` for entity definitions
2. Edit `src/game/collisions.asm` for collision detection
3. Edit `src/game/rules.asm` for game rules
4. Modify `update_game` in `src/main.asm` to call your game logic

### Adding Graphics

1. Replace `graphics/chr/font.chr` with your CHR ROM file
2. Add additional CHR files as needed
3. Update palette in `src/palette/palette_data.asm`

### Adding Tilemaps

1. Create tilemap data files in `data/tilemaps/`
2. Use `load_tilemap` function from `src/tilemap/tilemap_loader.asm`
3. Reference tilemap data in your code

### Adding Screens

1. Implement screen logic in `src/screens/`
2. Add state transitions in `src/state/transitions.asm`
3. Update state machine in `src/state/state_machine.asm`

## Code Structure

The template follows a strict modular architecture:

- **Includes: Use `.include` for definitions and constants
- **Segments: Code in `CODE` segment, data in appropriate segments
- **Memory: Zero page for hot variables, RAM for game state
- **Patterns: Follows data-oriented design principles

## Related Documentation

- [S-NES-BOY Main README](../../README.md) - S-NES-BOY project overview
- [S-NES-BOY Documentation](../../nes-docs/README.md) - Complete development guide
- [The Game Loop](../../../nes-docs/03-core-concepts/3.1-the-game-loop.md) - Game loop patterns
- [Data-Oriented Design](../../../nes-docs/03-core-concepts/3.2-data-oriented-design.md) - Memory organization
- [NES System Overview](../../../nes-docs/01-fundamentals/1.1-nes-system-overview.md) - Hardware basics

## License

This template is part of S-NES-BOY and is licensed under the MIT License.

---

**Note: This template follows hardware-accurate NES programming practices. All code is designed to work on real NES hardware, not just emulators. The modular architecture makes it easy to extend and customize while maintaining code organization and following S-NES-BOY principles.
