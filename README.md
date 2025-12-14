# S-NES

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**S-NES** is a comprehensive codebase dedicated solely to the learning and development of **NES (Nintendo Entertainment System)**, **SNES (Super Nintendo Entertainment System)**, and **Famicom** systems and programming.

## Overview

S-NES provides everything you need to understand and program for Nintendo's 8-bit and 16-bit retro gaming systems, with a focus on hardware accuracy, practical implementation, and comprehensive documentation.

### Supported Systems

- **NES (Nintendo Entertainment System)**: Complete coverage of 8-bit NES programming
- **SNES (Super Nintendo Entertainment System)**: 16-bit SNES development resources
- **Famicom**: Japanese variant of NES with additional features

## What S-NES Provides

### 📚 Comprehensive Documentation

- **Fundamentals**: Core concepts and hardware understanding for all systems
- **Advanced Fundamentals**: Timing, constraints, and hardware-specific details
- **Core Concepts**: System interactions and architectural patterns
- **Cheatsheets**: Quick reference tables for active coding
- **Applied Patterns**: Reusable solutions for common problems
- **Tooling & Debugging**: Development tools and techniques
- **Real Hardware**: Considerations for actual hardware testing

### 🎮 Example Projects

- **hello-world**: Complete NES program demonstrating text rendering with full alphabet/lexicon
- **welcome**: Centered text display project showing "Welcome to S-NES"
- **template**: Minimal starter template for new projects

### 🛠️ Development Tools

- Complete toolchain setup guides
- Emulator and debugger recommendations
- Build systems and Makefiles
- Hardware testing guidelines

## Quick Start

### For NES Development

1. **Start with Fundamentals**: Read `docs/01-fundamentals/` to establish correct mental models
2. **Move to Advanced Fundamentals**: Read `docs/02-advanced-fundamentals/` to understand timing and constraints
3. **Learn Core Concepts**: Read `docs/03-core-concepts/` to understand system interactions
4. **Use Cheatsheets**: Keep `docs/04-cheatsheets/` open while coding
5. **Apply Patterns**: Reference `docs/05-applied-patterns/` when implementing features
6. **Set Up Tooling**: Follow `docs/06-tooling-debugging/` to set up your development environment
7. **Test on Hardware**: Read `docs/07-real-hardware/` before finalizing your project

### For SNES Development

SNES documentation is currently being expanded. Start with NES fundamentals as they provide the foundation for understanding SNES architecture.

### For Famicom Development

Famicom development follows NES patterns with additional considerations for Japanese hardware features. See NES documentation as the primary reference.

## Documentation Structure

```
docs/
├── 01-fundamentals/          # Core concepts and hardware basics
│   ├── 1.1-nes-system-overview.md
│   ├── 1.2-6502-cpu-fundamentals.md
│   ├── 1.3-memory-fundamentals.md
│   ├── 1.4-ppu-fundamentals.md
│   └── 1.5-rom-fundamentals.md
├── 02-advanced-fundamentals/  # Timing, constraints, advanced topics
│   ├── 2.1-cpu-timing-cycles.md
│   ├── 2.2-nmi-vblank-discipline.md
│   ├── 2.3-ppu-rendering-rules.md
│   ├── 2.4-controller-io.md
│   ├── 2.5-audio-fundamentals.md
│   ├── 2.6-optimization-techniques.md
│   └── 2.7-graphics-pixel-art.md
├── 03-core-concepts/          # System interactions and architecture
│   ├── 3.1-the-game-loop.md
│   ├── 3.2-data-oriented-design.md
│   ├── 3.3-rendering-architecture.md
│   ├── 3.4-input-state-output-pipeline.md
│   └── 3.5-map-level-systems.md
├── 04-cheatsheets/            # Quick reference tables
│   ├── 4.1-cpu-cheatsheets.md
│   ├── 4.2-ppu-cheatsheets.md
│   ├── 4.3-memory-cheatsheets.md
│   ├── 4.4-timing-cheatsheets.md
│   ├── 4.5-audio-cheatsheets.md
│   └── 4.6-optimization-cheatsheets.md
├── 05-applied-patterns/       # Reusable solutions
│   ├── 5.1-sprite-engine-patterns.md
│   ├── 5.2-scrolling-patterns.md
│   ├── 5.3-collision-systems.md
│   ├── 5.4-animation-systems.md
│   └── 5.5-audio-integration.md
├── 06-tooling-debugging/      # Development tools
│   ├── 6.1-toolchain.md
│   ├── 6.2-emulators-debuggers.md
│   └── 6.3-test-roms.md
└── 07-real-hardware/          # Hardware considerations
    └── real-hardware-considerations.md
```

## Projects

### hello-world

A complete NES program demonstrating text rendering with a full alphabet/lexicon (A-Z, 0-9, punctuation). Perfect starting point for understanding NES programming basics.

**Location**: `Projects/hello-world/`

### welcome

A centered text display project showing "Welcome to S-NES". Demonstrates proper text centering and name table rendering.

**Location**: `Projects/welcome/`

### template

Minimal starter template for new NES projects. Includes proper initialization, NMI handler, and build system.

**Location**: `template/`

## Philosophy

S-NES follows these core principles:

- **Hardware-first**: No abstractions until justified by hardware constraints
- **Assembly-aware**: Assembly language is the foundation; higher-level languages are convenience layers
- **Deterministic**: Cycle counts, registers, and memory maps matter
- **Cross-linked**: Concepts reference each other, not isolated chapters
- **Cheatsheet-driven**: Fast recall is a first-class feature
- **Multi-system**: Unified approach to NES, SNES, and Famicom development

## Requirements

- Basic programming knowledge
- Understanding of assembly language (helpful but not required)
- Interest in retro game development and hardware programming
- For NES: `ca65` assembler (part of cc65), `ld65` linker
- For SNES: SNES development tools (expanding)
- Emulator for testing (FCEUX, Mesen2, etc.)

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute.

### Ways to Contribute

- Report bugs or inaccuracies
- Suggest documentation improvements
- Add new sections or expand existing content
- Improve code examples
- Enhance cheatsheets
- Share real hardware experiences
- Add SNES-specific content
- Document Famicom-specific features

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Code of Conduct

This project adheres to a Code of Conduct. Please read [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) before contributing.

## Resources

- [Documentation](docs/README.md) - Complete documentation index
- [References](REFERENCES.md) - External resources and links
- [Contributing Guide](CONTRIBUTING.md) - How to contribute
- [Changelog](CHANGELOG.md) - Project history
- [Getting Started](GETTINGSTARTED.md) - Quick start guide

## Target Audience

- **Technically competent**: Assumes programming knowledge
- **New to retro systems**: No system-specific intuition required
- **6502/65816 literate**: Basic assembly understanding helpful but not required
- **Hardware enthusiasts**: Interest in understanding how these systems work

## Non-Goals

S-NES does **not** cover:

- General programming fundamentals
- Abstract game design theory
- High-level engines or frameworks
- Emulator-only tricks without hardware justification
- Modern game development (focus is on retro systems)

## Project Structure

```
.
├── docs/                  # Complete documentation
│   ├── 01-fundamentals/
│   ├── 02-advanced-fundamentals/
│   ├── 03-core-concepts/
│   ├── 04-cheatsheets/
│   ├── 05-applied-patterns/
│   ├── 06-tooling-debugging/
│   └── 07-real-hardware/
├── Projects/              # Example projects
│   ├── hello-world/      # Complete NES text rendering example
│   └── welcome/          # Centered text display example
├── template/              # Starter template for new projects
├── .github/               # GitHub templates and workflows
├── CONTRIBUTING.md        # Contribution guidelines
├── CODE_OF_CONDUCT.md     # Community standards
├── LICENSE                # MIT License
├── CHANGELOG.md           # Project history
├── REFERENCES.md          # External resources
├── GETTINGSTARTED.md      # Quick start guide
└── README.md              # This file
```

## Acknowledgments

S-NES follows best practices from the [Open Source Guide](https://opensource.guide/) and is built on the foundation of excellent retro development resources from the community.

## Support

- **Issues**: Use GitHub Issues for bug reports and feature requests
- **Questions**: Use the question template in `.github/ISSUE_TEMPLATE/`
- **Documentation**: Check `docs/` for comprehensive guides

## Getting Started

For a quick start guide, see [GETTINGSTARTED.md](GETTINGSTARTED.md).

For new projects, use the template:

```bash
cd template
make          # Build template.nes
make run      # Run in FCEUX
make clean    # Clean build files
```

See [`template/README.md`](template/README.md) for complete template documentation.

---

**S-NES**: Dedicated to learning and development of NES, SNES, and Famicom systems.
