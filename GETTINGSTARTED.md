# Getting Started with S-NES-BOY

This guide describes how to set up a Linux development environment for the S-NES-BOY Learning & Development Framework, including templates, examples, and documentation for NES, SNES, and Game Boy systems.

## Prerequisites

- Linux distribution (Debian/Ubuntu, Arch Linux, Fedora, or similar)
- Root or sudo access for package installation
- Terminal access
- Internet connection for downloading packages

## Toolchains by System

### NES

- `cc65` toolchain (provides `ca65` and `ld65`)
- NES emulator such as Mesen2 or FCEUX

### SNES

- `cc65` toolchain with 65816 support (`ca65 --cpu 65816`)
- SNES emulator such as bsnes or higan

### Game Boy

- RGBDS toolchain (`rgbasm`, `rgblink`, `rgbfix`)
- Game Boy emulator such as SameBoy, BGB, or mGBA

## Installing cc65 (NES and SNES)

On Debian or Ubuntu:

```bash
sudo apt-get update
sudo apt-get install -y build-essential git make cc65
ca65 --version
ld65 --version
```

On Arch Linux:

```bash
sudo pacman -Syu
sudo pacman -S --needed base-devel git cc65
ca65 --version
ld65 --version
```

## Installing RGBDS (Game Boy)

On Debian or Ubuntu (using packages when available):

```bash
sudo apt-get update
sudo apt-get install -y rgbds
rgbasm --version
rgblink --version
rgbfix --version
```

Refer to the RGBDS documentation for distributions without native packages.

## Emulator Installation (Examples)

### NES

On Debian or Ubuntu:

```bash
sudo apt-get install -y fceux
```

On Arch Linux:

```bash
sudo pacman -S fceux
```

### SNES

Install bsnes or higan following their respective documentation.

### Game Boy

Install SameBoy, BGB, or mGBA from your distribution or from upstream releases.

## Using the Development Templates

The framework provides production-ready templates for each system. These templates include complete hardware initialization, proper memory layout, and correct ROM structure.

### NES Template

```bash
cd templates/nes
make           # Build ROM into rom/
make run       # Run in configured NES emulator
make clean     # Remove build outputs
```

### SNES Template

```bash
cd templates/snes
make           # Build ROM into rom/
make run       # Run in configured SNES emulator
make clean     # Remove build outputs
```

### Game Boy Template

```bash
cd templates/gb
make           # Build ROM into rom/
make run       # Run in configured Game Boy emulator
make clean     # Remove build outputs
```

## Exploring Examples

Examples are under `examples/`:

- `examples/nes/hello_world`
- `examples/snes/hello_world`
- `examples/gameboy/hello_world`

From any example directory:

```bash
make
make run
```

## Documentation

System documentation is under `docs/`:

- `docs/nes/` – NES fundamentals, advanced topics, and concepts
- `docs/snes/` – SNES fundamentals, advanced topics, and concepts
- `docs/gameboy/` – Game Boy fundamentals, advanced topics, and concepts

Refer to each system’s `README.md` in its `docs/<system>/` directory for reading order and details.

## References

- `README.md` – Framework overview
- `DIRECTORY_STRUCTURE.md` – High-level directory layout
- `docs/nes/README.md` – NES documentation index
- `docs/snes/README.md` – SNES documentation index
- `docs/gameboy/README.md` – Game Boy documentation index
