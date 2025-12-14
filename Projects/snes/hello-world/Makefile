# ============================================================================
# SNES Hello World Build System
# ============================================================================
# Build system for Hello World SNES program
# Follows SNES documentation best practices
#
# Requirements:
#   - ca65 (assembler, part of cc65) with 65816 support
#   - ld65 (linker, part of cc65)
#   - Python 3 (for verify target only)
#   - bsnes or higan (SNES emulator)
#
# Usage:
#   make run              - Run with default emulator (bsnes)
#   make run EMULATOR=bsnes - Run with bsnes
#   make run EMULATOR=higan - Run with higan
# ============================================================================

# Toolchain
AS = ca65
LD = ld65
CFG = snes.cfg

# Emulator selection (default: bsnes)
# Options: bsnes, higan
EMULATOR ?= bsnes

# Source files
SOURCES = main.asm
OBJECTS = $(SOURCES:.asm=.o)
TARGET = hello-world.sfc

# Phony targets
.PHONY: all clean distclean run verify help

# ============================================================================
# Build Targets
# ============================================================================

# Default target: build ROM
all: $(TARGET)

# Build object files from assembly source
# Dependencies: main.asm requires chars_data.asm (included via .include)
# Uses 65816 CPU mode and force_range feature for 16-bit immediates
%.o: %.asm chars_data.asm
	@echo "Assembling $<..."
	$(AS) --cpu 65816 --feature force_range $< -o $@

# Link ROM from object files
# Dependencies: object files, linker config, and CHR data
# Post-process to fix LoROM file structure (header at 0x7FB0, code at 0x8000)
$(TARGET): $(OBJECTS) $(CFG) chars_data.asm fix_rom.py
	@echo "Linking $(TARGET)..."
	$(LD) -C $(CFG) -o $(TARGET).tmp $(OBJECTS)
	@echo "Fixing LoROM file structure..."
	@python3 fix_rom.py $(TARGET).tmp $(TARGET) || (echo "ROM fix failed" && exit 1)
	@rm -f $(TARGET).tmp
	@if [ -f $(TARGET) ]; then \
		SIZE=$$(stat -c%s $(TARGET) 2>/dev/null || echo "unknown"); \
		echo "✓ ROM built: $(TARGET) ($$SIZE bytes)"; \
	else \
		echo "✗ ROM build failed"; \
		exit 1; \
	fi

# ============================================================================
# Clean Targets
# ============================================================================

# Clean build artifacts (object files and ROM)
clean:
	@echo "Cleaning build files..."
	rm -f $(OBJECTS) $(TARGET)
	@echo "✓ Clean complete"

# Deep clean (same as clean for this project)
distclean: clean
	@echo "Deep cleaning..."
	@echo "✓ Deep clean complete"

# ============================================================================
# Run Targets
# ============================================================================

# Run ROM in selected emulator (bsnes or higan)
# Automatically detects and installs emulator if not found
# Usage: make run EMULATOR=bsnes  or  make run EMULATOR=higan
run: $(TARGET)
	@if [ "$(EMULATOR)" != "bsnes" ] && [ "$(EMULATOR)" != "higan" ]; then \
		echo "Error: Invalid EMULATOR value '$(EMULATOR)'. Use 'bsnes' or 'higan'."; \
		echo "Usage: make run EMULATOR=bsnes  # or make run EMULATOR=higan"; \
		exit 1; \
	fi
	@echo "Running $(TARGET) in $(EMULATOR)..."
	@echo "ROM file: $(TARGET) ($(shell stat -c%s $(TARGET)) bytes, modified $(shell stat -c%y $(TARGET) | cut -d' ' -f1-2))"
	@EMU_NAME=$(EMULATOR); \
	EMU_CMD=$$EMU_NAME; \
	if [ "$$EMU_NAME" = "bsnes" ]; then \
		PKG_NAME=bsnes; \
	elif [ "$$EMU_NAME" = "higan" ]; then \
		PKG_NAME=higan-git; \
	fi; \
	if ! command -v $$EMU_CMD >/dev/null 2>&1; then \
		echo "$$EMU_NAME not found. Attempting to install..."; \
		if command -v yay >/dev/null 2>&1; then \
			echo "Detected yay (AUR helper). Installing $$PKG_NAME from AUR..."; \
			echo "Note: This requires sudo privileges."; \
			yay -S --noconfirm $$PKG_NAME || (echo "Installation failed. Try manually: yay -S $$PKG_NAME" && exit 1); \
		elif command -v paru >/dev/null 2>&1; then \
			echo "Detected paru (AUR helper). Installing $$PKG_NAME from AUR..."; \
			echo "Note: This requires sudo privileges."; \
			paru -S --noconfirm $$PKG_NAME || (echo "Installation failed. Try manually: paru -S $$PKG_NAME" && exit 1); \
		elif command -v pacman >/dev/null 2>&1; then \
			echo "Detected pacman (Arch Linux). Checking if $$PKG_NAME is available..."; \
			if pacman -Si $$PKG_NAME >/dev/null 2>&1; then \
				echo "Installing $$PKG_NAME from official repositories..."; \
				sudo pacman -S --noconfirm $$PKG_NAME || (echo "Installation failed. Try manually: sudo pacman -S $$PKG_NAME" && exit 1); \
			else \
				echo "$$PKG_NAME not in official repos. Please install an AUR helper (yay/paru) or install manually:"; \
				echo "  yay -S $$PKG_NAME  # or paru -S $$PKG_NAME"; \
				if [ "$$PKG_NAME" = "higan-git" ]; then \
					echo "  AUR: https://aur.archlinux.org/packages/higan-git"; \
				fi; \
				exit 1; \
			fi; \
		elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
			echo "Detected apt (Debian/Ubuntu). Installing $$PKG_NAME..."; \
			sudo apt-get update && sudo apt-get install -y $$PKG_NAME || (echo "Installation failed. $$PKG_NAME may not be in repositories." && echo "Try: sudo apt-get install $$PKG_NAME" && exit 1); \
		elif command -v dnf >/dev/null 2>&1; then \
			echo "Detected dnf (Fedora). Installing $$PKG_NAME..."; \
			sudo dnf install -y $$PKG_NAME || (echo "Installation failed. Try manually: sudo dnf install $$PKG_NAME" && exit 1); \
		elif command -v yum >/dev/null 2>&1; then \
			echo "Detected yum (RHEL/CentOS). Installing $$PKG_NAME..."; \
			sudo yum install -y $$PKG_NAME || (echo "Installation failed. Try manually: sudo yum install $$PKG_NAME" && exit 1); \
		elif command -v zypper >/dev/null 2>&1; then \
			echo "Detected zypper (openSUSE). Installing $$PKG_NAME..."; \
			sudo zypper install -y $$PKG_NAME || (echo "Installation failed. Try manually: sudo zypper install $$PKG_NAME" && exit 1); \
		else \
			echo "Error: Could not detect package manager."; \
			echo "Please install $$PKG_NAME manually:"; \
			echo "  Arch Linux (AUR): yay -S $$PKG_NAME  # or paru -S $$PKG_NAME"; \
			echo "  Debian/Ubuntu: sudo apt-get install $$PKG_NAME"; \
			echo "  Fedora: sudo dnf install $$PKG_NAME"; \
			if [ "$$PKG_NAME" = "higan-git" ]; then \
				echo "  AUR: https://aur.archlinux.org/packages/higan-git"; \
			fi; \
			exit 1; \
		fi; \
		if ! command -v $$EMU_CMD >/dev/null 2>&1; then \
			echo "Error: $$EMU_NAME installation completed but command still not found."; \
			echo "Please restart your terminal or check your PATH."; \
			exit 1; \
		fi; \
	fi; \
	if [ -n "$$WAYLAND_DISPLAY" ] && [ -n "$$DISPLAY" ]; then \
		echo "Wayland detected with XWayland - using XCB platform for better compatibility"; \
		QT_QPA_PLATFORM=xcb QT_LOGGING_RULES="qt.qpa.*=false" $$EMU_CMD "$(TARGET)" 2>&1 | grep -v "paintEngine" || exit $$?; \
	elif [ -n "$$WAYLAND_DISPLAY" ]; then \
		echo "Wayland detected - using XCB platform (more compatible)"; \
		QT_QPA_PLATFORM=xcb QT_LOGGING_RULES="qt.qpa.*=false" $$EMU_CMD "$(TARGET)" 2>&1 | grep -v "paintEngine" || exit $$?; \
	elif [ -n "$$DISPLAY" ]; then \
		echo "X11 detected - using XCB platform"; \
		QT_QPA_PLATFORM=xcb QT_LOGGING_RULES="qt.qpa.*=false" $$EMU_CMD "$(TARGET)" 2>&1 | grep -v "paintEngine" || exit $$?; \
	else \
		echo "Error: No display server detected (X11 or Wayland)"; \
		exit 1; \
	fi

# ============================================================================
# Verify Targets
# ============================================================================

# Verify ROM structure (size and header)
# Per SNES documentation: LoROM format, header at $7FB0, vectors at $7FE4/$7FFC
verify: $(TARGET)
	@echo "Verifying ROM structure..."
	@python3 -c "import sys; rom = open('$(TARGET)', 'rb').read(); \
		print(f'ROM size: {len(rom)} bytes'); \
		print(f'  Header: 80 bytes (at offset 0x7FB0)'); \
		print(f'  PRG ROM: 32768 bytes'); \
		print(f'  CHR ROM: 8192 bytes'); \
		print(f'  Expected: 41040 bytes'); \
		print('✓ Size correct' if len(rom) == 41040 else '✗ Size incorrect'); \
		header = rom[0x7FB0:0x7FB0+21] if len(rom) > 0x7FB0+21 else b''; \
		print(f'Header title: {header.decode(\"ascii\", errors=\"ignore\")}'); \
		print('✓ Header present' if len(header) == 21 else '✗ Header missing')"

# ============================================================================
# Help Target
# ============================================================================

# Display help information
help:
	@echo "SNES Hello World Build System"
	@echo ""
	@echo "Targets:"
	@echo "  make                    - Build ROM (default)"
	@echo "  make clean              - Remove build artifacts"
	@echo "  make distclean          - Deep clean"
	@echo "  make run                - Run ROM with default emulator (bsnes)"
	@echo "  make run EMULATOR=bsnes - Run ROM with bsnes (auto-installs if missing)"
	@echo "  make run EMULATOR=higan - Run ROM with higan (auto-installs if missing)"
	@echo "  make verify              - Verify ROM structure"
	@echo "  make help               - Show this help"
	@echo ""
	@echo "Requirements:"
	@echo "  - ca65 (assembler with --cpu 65816 support)"
	@echo "  - ld65 (linker)"
	@echo "  - bsnes or higan (SNES emulator) - will be auto-installed if missing"
	@echo ""
	@echo "Emulator Selection:"
	@echo "  Default: bsnes"
	@echo "  Options: bsnes, higan"
	@echo ""
	@echo "Documentation:"
	@echo "  - bsnes: https://github.com/bsnes-emu/bsnes"
	@echo "  - higan: https://higan.readthedocs.io/ (AUR: higan-git)"
	@echo "  - SNES docs: ../../snes-docs/README.md"
