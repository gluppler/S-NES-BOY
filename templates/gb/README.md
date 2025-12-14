# Game Boy Template

Game Boy development template following hardware-accurate practices.

Based on the [GB ASM Tutorial](https://gbdev.io/gb-asm-tutorial/index.html) and using the official `hardware.inc` from the tutorial.

## Structure

- `src/`: Source code files
  - `main.asm` - Main program entry point
  - `hardware.inc` - Official hardware definitions (from GB ASM Tutorial)
- `linker/`: Linker configuration files
- `graphics/`: Graphics assets
- `data/`: Data files (tilemaps, tables)
- `debug/`: Debug utilities
- `tests/`: Test files
- `Makefile`: Build system with emulator auto-detection

## Usage

Copy this template to create a new Game Boy project.

## Building

```bash
make              # Build ROM (auto-installs RGBDS if missing)
make clean        # Remove build artifacts
make run          # Run ROM in emulator (default: emulicious, auto-installs if missing)
make run EMULATOR=emulicious  # Run with specific emulator
make verify       # Verify ROM structure (auto-installs Python 3 if missing)
```

## Requirements

All requirements are automatically detected and installed if missing:

- **RGBDS** (assembler and linker)
  - `rgbasm` - Assembler
  - `rgblink` - Linker
  - `rgbfix` - ROM fixer
- **Game Boy emulator** (BGB, SameBoy, mGBA)
  - Will be auto-installed if missing (requires package manager)
- **Python 3** (for verify target only)
  - Will be auto-installed if missing

## Emulator Selection

The Makefile supports multiple emulators:
- `emulicious` (default) - Modern multi-system emulator with Game Boy support
- `bgb` - Accurate Game Boy emulator
- `sameboy` - Accurate Game Boy/Color emulator
- `mgba` - Multi-system emulator

Usage: `make run EMULATOR=<emulator_name>`

### Emulicious Notes

- **Java Warnings**: The Makefile automatically suppresses Java native access warnings by setting `JAVA_TOOL_OPTIONS=--enable-native-access=ALL-UNNAMED`
- **Monitor Placement**: If emulicious opens on the wrong monitor, this is typically handled by your window manager. You can:
  - Configure your WM to remember window positions
  - Use `wmctrl` or `xdotool` to move the window after it opens
  - Set window placement rules in your WM configuration

## Code Style

This template follows the GB ASM Tutorial conventions:
- Uses official `hardware.inc` with `DEF name EQU value` syntax
- Simple, straightforward structure
- Audio shutdown on startup
- Proper VBlank handling
- Inline copy loops for efficiency

## References

- [GB ASM Tutorial](https://gbdev.io/gb-asm-tutorial/index.html) - Official assembly tutorial
- [Pan Docs](https://gbdev.io/pandocs/) - Hardware documentation
- [RGBDS](https://rgbds.gbdev.io) - Assembler and linker documentation
