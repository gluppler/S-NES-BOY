# Game Boy Hello World

A simple Game Boy program that displays "HELLO WORLD!" and the alphabet/lexicon.

## Features

- Displays "HELLO WORLD!" text
- Shows full alphabet (A-Z)
- Shows numbers (0-9)
- Shows punctuation characters
- Follows hardware-accurate Game Boy programming practices

## Building

Requires RGBDS toolchain:

```bash
make
```

This will create `hello-world.gb` ROM file.

## Running

The Makefile will automatically use emulicious (default) or you can specify another emulator:

```bash
make run                    # Run with emulicious (default)
make run EMULATOR=emulicious # Explicitly use emulicious
make run EMULATOR=bgb        # Use BGB
make run EMULATOR=sameboy    # Use SameBoy
make run EMULATOR=mgba       # Use mGBA
```

Supported emulators:
- **emulicious** (default) - Modern multi-system emulator
- BGB - Accurate Game Boy emulator
- SameBoy - Accurate Game Boy/Color emulator
- mGBA - Multi-system emulator

Emulators will be automatically installed if missing (requires package manager).

## Documentation

See `../../gb-docs/` for complete Game Boy programming documentation.

## References

- [Pan Docs](https://gbdev.io/pandocs/) - Hardware documentation
- [RGBDS](https://rgbds.gbdev.io) - Assembler and linker
- [GB ASM Tutorial](https://gbdev.io/gb-asm-tutorial/index.html) - Assembly tutorial
