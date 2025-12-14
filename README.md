# S-NES-BOY

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**S-NES-BOY** is a comprehensive codebase dedicated to the learning and development of **NES (Nintendo Entertainment System)**, **SNES (Super Nintendo Entertainment System)**, and **Game Boy** systems and programming.

## Overview

S-NES-BOY provides everything you need to understand and program for Nintendo's 8-bit and 16-bit retro gaming systems, with a focus on hardware accuracy, practical implementation, and comprehensive documentation.

### Supported Systems

- **NES (Nintendo Entertainment System)**: Complete coverage of 8-bit NES programming
- **SNES (Super Nintendo Entertainment System)**: 16-bit SNES development resources
- **Game Boy (DMG/CGB)**: Complete coverage of Game Boy and Game Boy Color programming

## What S-NES-BOY Provides

### 📚 Comprehensive Documentation

Documentation is split into system-specific directories:

- **`nes-docs/`**: Complete NES documentation
  - Fundamentals, Advanced Fundamentals, Core Concepts
  - Cheatsheets, Applied Patterns, Tooling & Debugging
  - Real Hardware Considerations
- **`snes-docs/`**: Complete SNES documentation
  - Fundamentals, Advanced Fundamentals, Core Concepts
  - Cheatsheets, Applied Patterns, Tooling & Debugging
  - Real Hardware Considerations
- **`gb-docs/`**: Complete Game Boy documentation
  - Fundamentals, Advanced Fundamentals, Core Concepts
  - Cheatsheets, Official Documentation & References
  - Gold-Standard Examples

### 🎮 Example Projects

Projects are organized by system:

- **`Projects/nes/`**: NES example projects
  - **hello-world**: Complete NES program demonstrating text rendering
  - **welcome**: Centered text display project
- **`Projects/snes/`**: SNES example projects
  - **hello-world**: Complete SNES program demonstrating text rendering
  - **welcome**: Centered text display project
- **`Projects/gb/`**: Game Boy example projects
  - **hello-world**: Complete Game Boy program demonstrating text rendering

### 🛠️ Templates

Templates are organized by system:

- **`templates/nes/`**: Complete NES project template with modular architecture
- **`templates/snes/`**: Complete SNES project template with modular architecture
- **`templates/gb/`**: Complete Game Boy project template with modular architecture

### 🛠️ Development Tools

- Complete toolchain setup guides
- Emulator and debugger recommendations
- Build systems and Makefiles with auto-installation
- Hardware testing guidelines

## Quick Start

### For NES Development

1. **Start with Fundamentals**: Read `nes-docs/01-fundamentals/` to establish correct mental models
2. **Move to Advanced Fundamentals**: Read `nes-docs/02-advanced-fundamentals/` to understand timing and constraints
3. **Learn Core Concepts**: Read `nes-docs/03-core-concepts/` to understand system interactions
4. **Use Cheatsheets**: Keep `nes-docs/04-cheatsheets/` open while coding
5. **Apply Patterns**: Reference `nes-docs/05-applied-patterns/` when implementing features
6. **Set Up Tooling**: Follow `nes-docs/06-tooling-debugging/` to set up your development environment
7. **Test on Hardware**: Read `nes-docs/07-real-hardware/` before finalizing your project
8. **Use Template**: Start with `templates/nes/` for new projects

### For SNES Development

1. **Start with Fundamentals**: Read `snes-docs/01-fundamentals/` to establish correct mental models
2. **Move to Advanced Fundamentals**: Read `snes-docs/02-advanced-fundamentals/` to understand timing and constraints
3. **Learn Core Concepts**: Read `snes-docs/03-core-concepts/` to understand system interactions
4. **Use Cheatsheets**: Keep `snes-docs/04-cheatsheets/` open while coding
5. **Apply Patterns**: Reference `snes-docs/05-applied-patterns/` when implementing features
6. **Set Up Tooling**: Follow `snes-docs/06-tooling-debugging/` to set up your development environment
7. **Test on Hardware**: Read `snes-docs/07-real-hardware/` before finalizing your project
8. **Use Template**: Start with `templates/snes/` for new projects

### For Game Boy Development

1. **Start with Fundamentals**: Read `gb-docs/01-fundamentals/` to establish correct mental models
2. **Move to Advanced Fundamentals**: Read `gb-docs/02-advanced-fundamentals/` to understand timing and constraints
3. **Learn Core Concepts**: Read `gb-docs/03-core-concepts/` to understand system interactions
4. **Use Cheatsheets**: Keep `gb-docs/04-cheatsheets/` open while coding
5. **Review Official Documentation**: Reference `gb-docs/05-official-documentation/` for authoritative sources
6. **Study Examples**: Review `gb-docs/06-gold-standard-examples/` for best practices
7. **Use Template**: Start with `templates/gb/` for new projects

## Directory Structure

```
S-NES-BOY/
├── nes-docs/                  # NES documentation
│   ├── 01-fundamentals/
│   ├── 02-advanced-fundamentals/
│   ├── 03-core-concepts/
│   ├── 04-cheatsheets/
│   ├── 05-applied-patterns/
│   ├── 06-tooling-debugging/
│   └── 07-real-hardware/
├── snes-docs/                 # SNES documentation
│   ├── 01-fundamentals/
│   ├── 02-advanced-fundamentals/
│   ├── 03-core-concepts/
│   ├── 04-cheatsheets/
│   ├── 05-applied-patterns/
│   ├── 06-tooling-debugging/
│   └── 07-real-hardware/
├── gb-docs/                   # Game Boy documentation
│   ├── 01-fundamentals/
│   ├── 02-advanced-fundamentals/
│   ├── 03-core-concepts/
│   ├── 04-cheatsheets/
│   ├── 05-official-documentation/
│   └── 06-gold-standard-examples/
├── templates/                 # Project templates
│   ├── nes/                   # NES template
│   ├── snes/                  # SNES template
│   └── gb/                    # Game Boy template
├── Projects/                  # Example projects
│   ├── nes/                   # NES projects
│   │   ├── hello-world/
│   │   └── welcome/
│   ├── snes/                  # SNES projects
│   │   ├── hello-world/
│   │   └── welcome/
│   └── gb/                    # Game Boy projects
│       └── hello-world/
├── .github/                   # GitHub templates and workflows
├── CONTRIBUTING.md            # Contribution guidelines
├── CODE_OF_CONDUCT.md         # Community standards
├── LICENSE                    # MIT License
├── CHANGELOG.md               # Project history
├── REFERENCES.md              # External resources
├── GETTINGSTARTED.md          # Quick start guide
├── DIRECTORY_STRUCTURE.md     # Directory structure documentation
└── README.md                  # This file
```

## Projects

### NES Projects (`Projects/nes/`)

- **hello-world**: Complete NES program demonstrating text rendering with full alphabet/lexicon (A-Z, 0-9, punctuation)
- **welcome**: Centered text display project showing "Welcome to S-NES-BOY"

### SNES Projects (`Projects/snes/`)

- **hello-world**: Complete SNES program demonstrating text rendering with full alphabet/lexicon (A-Z, 0-9, punctuation)
- **welcome**: Centered text display project showing "WELCOME TO S-NES-BOY"

### Game Boy Projects (`Projects/gb/`)

- **hello-world**: Complete Game Boy program demonstrating text rendering with full alphabet/lexicon (A-Z, 0-9, punctuation)

## Templates

### NES Template (`templates/nes/`)

Complete NES project template with modular architecture. Includes:
- Memory definitions, constants, macros
- Input system, state machine, screen modules
- PPU, sprite, text, palette, tilemap systems
- Audio system, game logic
- Complete build system with auto-installation

### SNES Template (`templates/snes/`)

Complete SNES project template with modular architecture. Includes:
- WRAM, VRAM, CGRAM, OAM definitions
- 65816 CPU constants, PPU constants
- SPC700 audio system
- Complete build system with auto-installation

### Game Boy Template (`templates/gb/`)

Complete Game Boy project template with modular architecture. Includes:
- Hardware definitions (official hardware.inc)
- LR35902 CPU constants
- PPU, LCD, DMA definitions
- Complete build system with auto-installation

## Philosophy

S-NES-BOY follows these core principles:

- **Hardware-first**: No abstractions until justified by hardware constraints
- **Assembly-aware**: Assembly language is the foundation; higher-level languages are convenience layers
- **Deterministic**: Cycle counts, registers, and memory maps matter
- **Cross-linked**: Concepts reference each other, not isolated chapters
- **Cheatsheet-driven**: Fast recall is a first-class feature
- **Multi-system**: Unified approach to NES, SNES, and Game Boy development

## Requirements

- Basic programming knowledge
- Understanding of assembly language (helpful but not required)
- Interest in retro game development and hardware programming
- For NES: `ca65` assembler (part of cc65), `ld65` linker (auto-installed)
- For SNES: `ca65` assembler (part of cc65) with `--cpu 65816`, `ld65` linker (auto-installed)
- For Game Boy: `rgbasm`, `rgblink`, `rgbfix` (RGBDS toolchain, auto-installed)
- Emulator for testing (FCEUX for NES; bsnes for SNES; emulicious for Game Boy - all auto-installed)

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute.

### Ways to Contribute

- Report bugs or inaccuracies
- Suggest documentation improvements
- Add new sections or expand existing content
- Improve code examples
- Enhance cheatsheets
- Share real hardware experiences
- Add system-specific content
- Document system-specific features

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Code of Conduct

This project adheres to a Code of Conduct. Please read [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) before contributing.

## Resources

- [NES Documentation](nes-docs/README.md) - Complete NES documentation index
- [SNES Documentation](snes-docs/README.md) - Complete SNES documentation index
- [Game Boy Documentation](gb-docs/README.md) - Complete Game Boy documentation index
- [References](REFERENCES.md) - External resources and links
- [Contributing Guide](CONTRIBUTING.md) - How to contribute
- [Changelog](CHANGELOG.md) - Project history
- [Getting Started](GETTINGSTARTED.md) - Quick start guide
- [Directory Structure](DIRECTORY_STRUCTURE.md) - Detailed directory documentation

## Target Audience

- **Technically competent**: Assumes programming knowledge
- **New to retro systems**: No system-specific intuition required
- **6502/65816/LR35902 literate**: Basic assembly understanding helpful but not required
- **Hardware enthusiasts**: Interest in understanding how these systems work

## Non-Goals

S-NES-BOY does **not** cover:

- General programming fundamentals
- Abstract game design theory
- High-level engines or frameworks
- Emulator-only tricks without hardware justification
- Modern game development (focus is on retro systems)

## Getting Started

For a quick start guide, see [GETTINGSTARTED.md](GETTINGSTARTED.md).

For new NES projects, use the template:

```bash
cd templates/nes
make          # Build template.nes (auto-installs toolchain if needed)
make run      # Run in FCEUX (auto-installs if needed)
make clean    # Clean build files
```

For new SNES projects, use the template:

```bash
cd templates/snes
make          # Build template.sfc (auto-installs toolchain if needed)
make run      # Run in bsnes (auto-installs if needed)
make clean    # Clean build files
```

For new Game Boy projects, use the template:

```bash
cd templates/gb
make          # Build template.gb (auto-installs RGBDS if needed)
make run      # Run in emulicious (auto-installs if needed)
make clean    # Clean build files
```

See [`templates/nes/README.md`](templates/nes/README.md) for complete NES template documentation.
See [`templates/snes/README.md`](templates/snes/README.md) for complete SNES template documentation.
See [`templates/gb/README.md`](templates/gb/README.md) for complete Game Boy template documentation.

---

**S-NES-BOY**: Dedicated to learning and development of NES, SNES, and Game Boy systems.
