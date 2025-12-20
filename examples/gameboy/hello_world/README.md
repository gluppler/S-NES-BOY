# Game Boy Hello World Learning Example

A simple Game Boy program from the S-NES-BOY Learning & Development Framework that displays "HELLO WORLD!" and the alphabet/lexicon.

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

## Related Documentation

- [Game Boy Documentation Index](../../../docs/gameboy/README.md) – Game Boy documentation index
- [Game Boy Fundamentals](../../../docs/gameboy/fundamentals/) – Core Game Boy hardware concepts
- [Game Boy Advanced Fundamentals](../../../docs/gameboy/advanced_fundamentals/) – Timing and constraints
- [Game Boy References](../../../docs/gameboy/references/REFERENCES.md) – External resources and authoritative links
- [Game Boy Template](../../../templates/gb/) – Complete Game Boy template with full structure
- [Game Boy Test ROMs](../../../tests/gb/) – Game Boy test ROMs (when available)
- [Framework Overview](../../../README.md) – Main framework README

## External References

- [Pan Docs](https://gbdev.io/pandocs/) – Final authority on Game Boy hardware behavior
- [RGBDS](https://rgbds.gbdev.io) – Assembler and linker documentation
- [GB ASM Tutorial](https://gbdev.io/gb-asm-tutorial/index.html) – Assembly syntax and idioms
