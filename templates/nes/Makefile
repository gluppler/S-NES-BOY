# ============================================================================
# NES Template Build System
# ============================================================================
# Build system for NES template with modular architecture
# Follows NES documentation best practices
#
# Requirements:
#   - ca65 (assembler, part of cc65)
#   - ld65 (linker, part of cc65)
#   - Python 3 (for verify target only)
#   - FCEUX (NES emulator)
#
# Usage:
#   make run              - Run with default emulator (fceux)
#   make run EMULATOR=fceux - Run with fceux
# ============================================================================

# Toolchain
AS = ca65
LD = ld65
CFG = linker/nrom.cfg

# Emulator selection (default: fceux)
# Options: fceux
EMULATOR ?= fceux

# Source files
MAIN_SOURCE = src/main.asm
SOURCES = $(shell find src -name "*.asm" -o -name "*.inc" | sort)
OBJECTS = $(patsubst src/%.asm,build/obj/%.o,$(shell find src -name "*.asm"))

# Target ROM
TARGET = build/rom/game.nes

# Phony targets
.PHONY: all clean distclean run verify help

# ============================================================================
# Build Targets
# ============================================================================

# Default target: build ROM
all: $(TARGET)

# Create build directories
build/obj build/rom build/map:
	@mkdir -p $@

# Build object files from assembly source
build/obj/%.o: src/%.asm | build/obj
	@echo "Assembling $<..."
	@mkdir -p $(dir $@)
	$(AS) -I src $< -o $@

# Link ROM from object files
$(TARGET): $(OBJECTS) $(CFG) graphics/chr/font.chr | build/rom
	@echo "Linking $(TARGET)..."
	$(LD) -C $(CFG) -o $(TARGET) $(OBJECTS) -m build/map/game.map
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

# Clean build artifacts
clean:
	@echo "Cleaning build files..."
	@rm -rf build/obj build/rom build/map
	@echo "✓ Clean complete"

# Deep clean
distclean: clean
	@echo "Deep cleaning..."
	@echo "✓ Deep clean complete"

# ============================================================================
# Run Targets
# ============================================================================

# Run ROM in selected emulator (fceux)
# Automatically detects and installs emulator if not found
# Usage: make run EMULATOR=fceux
run: $(TARGET)
	@if [ "$(EMULATOR)" != "fceux" ]; then \
		echo "Error: Invalid EMULATOR value '$(EMULATOR)'. Use 'fceux'."; \
		echo "Usage: make run EMULATOR=fceux"; \
		exit 1; \
	fi
	@echo "Running $(TARGET) in $(EMULATOR)..."
	@EMU_NAME=$(EMULATOR); \
	EMU_CMD=$$EMU_NAME; \
	PKG_NAME=$$EMU_NAME; \
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
			echo "  Arch Linux: sudo pacman -S $$PKG_NAME  # or yay -S $$PKG_NAME"; \
			echo "  Debian/Ubuntu: sudo apt-get install $$PKG_NAME"; \
			echo "  Fedora: sudo dnf install $$PKG_NAME"; \
			exit 1; \
		fi; \
		if ! command -v $$EMU_CMD >/dev/null 2>&1; then \
			echo "Error: $$EMU_NAME installation completed but command still not found."; \
			echo "Please restart your terminal or check your PATH."; \
			exit 1; \
		fi; \
	fi; \
	if [ -n "$$WAYLAND_DISPLAY" ] && [ -n "$$DISPLAY" ]; then \
		echo "Wayland detected with XWayland - using XCB platform"; \
		QT_QPA_PLATFORM=xcb $$EMU_CMD "$(TARGET)"; \
	elif [ -n "$$WAYLAND_DISPLAY" ]; then \
		echo "Wayland detected - using Wayland platform"; \
		QT_QPA_PLATFORM=wayland $$EMU_CMD "$(TARGET)"; \
	elif [ -n "$$DISPLAY" ]; then \
		echo "X11 detected - using XCB platform"; \
		QT_QPA_PLATFORM=xcb $$EMU_CMD "$(TARGET)"; \
	else \
		echo "Error: No display server detected (X11 or Wayland)"; \
		exit 1; \
	fi

# ============================================================================
# Verify Targets
# ============================================================================

# Verify ROM structure
verify: $(TARGET)
	@echo "Verifying ROM structure..."
	@python3 -c "import sys; rom = open('$(TARGET)', 'rb').read(); \
		print(f'ROM size: {len(rom)} bytes'); \
		print(f'  Header: 16 bytes'); \
		print(f'  PRG ROM: 32768 bytes'); \
		print(f'  CHR ROM: 8192 bytes'); \
		print(f'  Expected: 40976 bytes'); \
		print('✓ Size correct' if len(rom) == 40976 else '✗ Size incorrect'); \
		header = rom[0:4]; \
		print(f'Header magic: {header}'); \
		print('✓ Header correct' if header == b'NES\x1a' else '✗ Header incorrect')"

# ============================================================================
# Help Target
# ============================================================================

help:
	@echo "NES Template Build System"
	@echo ""
	@echo "Targets:"
	@echo "  make                    - Build ROM (default)"
	@echo "  make clean              - Remove build artifacts"
	@echo "  make distclean          - Deep clean"
	@echo "  make run                - Run ROM with default emulator (fceux)"
	@echo "  make run EMULATOR=fceux - Run ROM with fceux (auto-installs if missing)"
	@echo "  make verify              - Verify ROM structure"
	@echo "  make help               - Show this help"
	@echo ""
	@echo "Requirements:"
	@echo "  - ca65 (assembler)"
	@echo "  - ld65 (linker)"
	@echo "  - fceux (NES emulator) - will be auto-installed if missing"
	@echo ""
	@echo "Emulator Selection:"
	@echo "  Default: fceux"
	@echo "  Options: fceux"
