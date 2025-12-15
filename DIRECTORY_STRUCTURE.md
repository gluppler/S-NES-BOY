# S-NES-BOY Directory Structure

This document describes the purpose and contents of each directory in the S-NES-BOY Learning & Development Framework.

## Root

- `README.md` – Framework overview
- `CHANGELOG.md` – Framework history
- `CONTRIBUTING.md` – Contribution guidelines
- `CODE_OF_CONDUCT.md` – Community standards
- `LICENSE` – License
- `GETTINGSTARTED.md` – Environment setup and first steps
- `DIRECTORY_STRUCTURE.md` – This document
- `.github/` – GitHub configuration
- `.ci/` – Template validation documents

## docs/

Comprehensive learning documentation, organized as one subtree per system. Each system provides a complete learning path from fundamentals to advanced topics.

### docs/nes/

- `README.md` – NES documentation index
- `fundamentals/` – Core hardware and system fundamentals
- `advanced_fundamentals/` – Timing, constraints, and detailed behavior
- `concepts/` – Game loop, rendering, data design, and related concepts
- `techniques/` – Applied patterns and reusable approaches
- `cheatsheets/` – Tables and quick references
- `schematics/` – Reserved for verified diagrams
- `references/REFERENCES.md` – NES-specific external references
- `gold_standard/` – Reserved for NES gold-standard examples

### docs/snes/

- `README.md` – SNES documentation index
- `fundamentals/` – Core hardware and system fundamentals
- `advanced_fundamentals/` – Timing, constraints, and detailed behavior
- `concepts/` – Game loop, rendering, data design, and related concepts
- `techniques/` – Applied patterns and reusable approaches
- `cheatsheets/` – Tables and quick references
- `schematics/` – Reserved for verified diagrams
- `references/REFERENCES.md` – SNES-specific external references
- `gold_standard/` – Reserved for SNES gold-standard examples

### docs/gameboy/

- `README.md` – Game Boy documentation index
- `fundamentals/` – Core hardware and system fundamentals
- `advanced_fundamentals/` – Timing, constraints, and detailed behavior
- `concepts/` – Game loop, rendering, data design, and related concepts
- `cheatsheets/` – Tables and quick references
- `schematics/` – Reserved for verified diagrams
- `references/` – Game Boy external references and sources
- `gold_standard/` – Game Boy gold-standard examples

Each system tree is isolated and does not describe other systems.

## templates/

Production-ready development templates for each system. These templates provide complete, hardware-accurate starting points for new projects.

### templates/nes/

- `README.md` – NES template overview and layout
- `build/` – Build scripts and notes
- `src/` – NES source code (reset, main loop, subsystems)
- `assets/` – Tile, tilemap, and palette data
- `linker/` – Linker scripts and memory maps
- `headers/` – Register and memory layout includes
- `macros/` – Assembly macros and reusable patterns
- `tools/` – Helper tools and scripts
- `config/` – Mapper and build configuration
- `rom/` – Output `.nes` ROM images

### templates/snes/

- `README.md` – SNES template overview and layout
- `build/` – Build scripts and notes
- `src/` – SNES source code (reset, main loop, subsystems)
- `assets/` – Tile, tilemap, and palette data
- `linker/` – Linker scripts and memory maps
- `headers/` – Register and memory layout includes
- `macros/` – Assembly macros and reusable patterns
- `tools/` – Helper tools and scripts
- `config/` – Mapping and build configuration
- `rom/` – Output `.sfc` ROM images

### templates/gb/

- `README.md` – Game Boy template overview and layout
- `build/` – Build scripts and notes
- `src/` – Game Boy source code (reset, main loop, subsystems)
- `assets/` – Tile and tilemap data
- `linker/` – Linker configuration
- `headers/` – Register and memory layout includes
- `macros/` – Assembly macros and reusable patterns
- `tools/` – Helper tools and scripts
- `config/` – ROM configuration
- `rom/` – Output `.gb` ROM images

## examples/

Working learning examples organized by system. These examples demonstrate correct hardware usage patterns and serve as reference implementations.

### examples/nes/

- `hello_world/` – NES text rendering example

### examples/snes/

- `hello_world/` – SNES text rendering example

### examples/gameboy/

- `hello_world/` – Game Boy text rendering example

## Isolation Principle

- NES-specific content lives under `docs/nes`, `templates/nes`, and `examples/nes`.
- SNES-specific content lives under `docs/snes`, `templates/snes`, and `examples/snes`.
- Game Boy-specific content lives under `docs/gameboy`, `templates/gb`, and `examples/gameboy`.

Each system tree is intended to be self-contained and described in hardware terms without cross-system comparisons.
