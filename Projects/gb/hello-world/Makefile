# ============================================================================
# Game Boy Hello World Build System
# ============================================================================
# Build system for Hello World Game Boy program
# Follows Game Boy documentation best practices
#
# Requirements:
#   - rgbasm (assembler, part of RGBDS)
#   - rgblink (linker, part of RGBDS)
#   - rgbfix (ROM fixer, part of RGBDS)
#   - Game Boy emulator (BGB, SameBoy, etc.)
# ============================================================================

# Toolchain
AS = rgbasm
LD = rgblink
FIX = rgbfix

# Emulator selection (default: emulicious)
# Options: emulicious, bgb, sameboy, mgba
EMULATOR ?= emulicious


# Source files
SOURCES = main.asm
OBJECTS = $(SOURCES:.asm=.o)
TARGET = hello-world.gb

# Phony targets
.PHONY: all clean distclean run verify help check-toolchain check-python

# Deep clean (same as clean for this project)
distclean: clean
	@echo "Deep cleaning..."
	@echo "✓ Deep clean complete"

# ============================================================================
# Toolchain Detection and Installation
# ============================================================================

# Check and install RGBDS toolchain
check-toolchain:
	@MISSING_TOOLS=""; \
	if ! command -v $(AS) >/dev/null 2>&1; then \
		MISSING_TOOLS="$$MISSING_TOOLS rgbasm"; \
	fi; \
	if ! command -v $(LD) >/dev/null 2>&1; then \
		MISSING_TOOLS="$$MISSING_TOOLS rgblink"; \
	fi; \
	if ! command -v $(FIX) >/dev/null 2>&1; then \
		MISSING_TOOLS="$$MISSING_TOOLS rgbfix"; \
	fi; \
	if [ -n "$$MISSING_TOOLS" ]; then \
		echo "RGBDS toolchain missing. Missing tools:$$MISSING_TOOLS"; \
		echo "Attempting to install RGBDS..."; \
		if command -v yay >/dev/null 2>&1; then \
			echo "Detected yay (AUR helper). Installing rgbds from AUR..."; \
			echo "Note: This requires sudo privileges."; \
			yay -S --noconfirm rgbds || (echo "Installation failed. Try manually: yay -S rgbds" && exit 1); \
		elif command -v paru >/dev/null 2>&1; then \
			echo "Detected paru (AUR helper). Installing rgbds from AUR..."; \
			echo "Note: This requires sudo privileges."; \
			paru -S --noconfirm rgbds || (echo "Installation failed. Try manually: paru -S rgbds" && exit 1); \
		elif command -v pacman >/dev/null 2>&1; then \
			echo "Detected pacman (Arch Linux). Checking if rgbds is available..."; \
			if pacman -Si rgbds >/dev/null 2>&1; then \
				echo "Installing rgbds from official repositories..."; \
				sudo pacman -S --noconfirm rgbds || (echo "Installation failed. Try manually: sudo pacman -S rgbds" && exit 1); \
			else \
				echo "rgbds not in official repos. Please install an AUR helper (yay/paru) or install manually:"; \
				echo "  yay -S rgbds  # or paru -S rgbds"; \
				exit 1; \
			fi; \
		elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
			echo "Detected apt (Debian/Ubuntu). Installing rgbds..."; \
			sudo apt-get update && sudo apt-get install -y rgbds || (echo "Installation failed. rgbds may not be in repositories." && echo "Try: sudo apt-get install rgbds" && exit 1); \
		elif command -v dnf >/dev/null 2>&1; then \
			echo "Detected dnf (Fedora). Installing rgbds..."; \
			sudo dnf install -y rgbds || (echo "Installation failed. Try manually: sudo dnf install rgbds" && exit 1); \
		elif command -v yum >/dev/null 2>&1; then \
			echo "Detected yum (RHEL/CentOS). Installing rgbds..."; \
			sudo yum install -y rgbds || (echo "Installation failed. Try manually: sudo yum install rgbds" && exit 1); \
		elif command -v zypper >/dev/null 2>&1; then \
			echo "Detected zypper (openSUSE). Installing rgbds..."; \
			sudo zypper install -y rgbds || (echo "Installation failed. Try manually: sudo zypper install rgbds" && exit 1); \
		else \
			echo "Error: Could not detect package manager."; \
			echo "Please install rgbds manually:"; \
			echo "  Arch Linux: sudo pacman -S rgbds  # or yay -S rgbds"; \
			echo "  Debian/Ubuntu: sudo apt-get install rgbds"; \
			echo "  Fedora: sudo dnf install rgbds"; \
			exit 1; \
		fi; \
		if ! command -v $(AS) >/dev/null 2>&1 || ! command -v $(LD) >/dev/null 2>&1 || ! command -v $(FIX) >/dev/null 2>&1; then \
			echo "Error: RGBDS installation completed but tools still not found."; \
			echo "Please restart your terminal or check your PATH."; \
			exit 1; \
		fi; \
		echo "✓ RGBDS toolchain installed successfully"; \
	fi

# Check and install Python 3 (for verify target)
check-python:
	@if ! command -v python3 >/dev/null 2>&1; then \
		echo "Python 3 not found. Attempting to install..."; \
		if command -v yay >/dev/null 2>&1; then \
			echo "Detected yay (AUR helper). Installing python from AUR..."; \
			echo "Note: This requires sudo privileges."; \
			yay -S --noconfirm python || (echo "Installation failed. Try manually: yay -S python" && exit 1); \
		elif command -v paru >/dev/null 2>&1; then \
			echo "Detected paru (AUR helper). Installing python from AUR..."; \
			echo "Note: This requires sudo privileges."; \
			paru -S --noconfirm python || (echo "Installation failed. Try manually: paru -S python" && exit 1); \
		elif command -v pacman >/dev/null 2>&1; then \
			echo "Detected pacman (Arch Linux). Installing python..."; \
			sudo pacman -S --noconfirm python || (echo "Installation failed. Try manually: sudo pacman -S python" && exit 1); \
		elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
			echo "Detected apt (Debian/Ubuntu). Installing python3..."; \
			sudo apt-get update && sudo apt-get install -y python3 || (echo "Installation failed. Try manually: sudo apt-get install python3" && exit 1); \
		elif command -v dnf >/dev/null 2>&1; then \
			echo "Detected dnf (Fedora). Installing python3..."; \
			sudo dnf install -y python3 || (echo "Installation failed. Try manually: sudo dnf install python3" && exit 1); \
		elif command -v yum >/dev/null 2>&1; then \
			echo "Detected yum (RHEL/CentOS). Installing python3..."; \
			sudo yum install -y python3 || (echo "Installation failed. Try manually: sudo yum install python3" && exit 1); \
		elif command -v zypper >/dev/null 2>&1; then \
			echo "Detected zypper (openSUSE). Installing python3..."; \
			sudo zypper install -y python3 || (echo "Installation failed. Try manually: sudo zypper install python3" && exit 1); \
		else \
			echo "Error: Could not detect package manager."; \
			echo "Please install Python 3 manually:"; \
			echo "  Arch Linux: sudo pacman -S python"; \
			echo "  Debian/Ubuntu: sudo apt-get install python3"; \
			echo "  Fedora: sudo dnf install python3"; \
			exit 1; \
		fi; \
		if ! command -v python3 >/dev/null 2>&1; then \
			echo "Error: Python 3 installation completed but command still not found."; \
			echo "Please restart your terminal or check your PATH."; \
			exit 1; \
		fi; \
		echo "✓ Python 3 installed successfully"; \
	fi

# ============================================================================
# Build Targets
# ============================================================================

# Default target: build ROM
all: check-toolchain $(TARGET)

# Build object files from assembly source
%.o: %.asm hardware.inc
	@echo "Assembling $<..."
	$(AS) -o $@ $<

# Link ROM from object files
$(TARGET): $(OBJECTS)
	@echo "Linking $(TARGET)..."
	$(LD) -o $(TARGET) $(OBJECTS)
	@echo "Fixing ROM header..."
	$(FIX) -v -p 0 $(TARGET)
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

clean:
	@echo "Cleaning build files..."
	rm -f $(OBJECTS) $(TARGET)
	@echo "✓ Clean complete"

# ============================================================================
# Run Targets
# ============================================================================

# Run ROM in selected emulator
# Automatically detects and installs emulator if not found
# Usage: make run EMULATOR=bgb
run: $(TARGET)
	@if [ "$(EMULATOR)" != "emulicious" ] && [ "$(EMULATOR)" != "bgb" ] && [ "$(EMULATOR)" != "sameboy" ] && [ "$(EMULATOR)" != "mgba" ]; then \
		echo "Error: Invalid EMULATOR value '$(EMULATOR)'. Use 'emulicious', 'bgb', 'sameboy', or 'mgba'."; \
		echo "Usage: make run EMULATOR=emulicious"; \
		exit 1; \
	fi
	@echo "Running $(TARGET) in $(EMULATOR)..."
	@EMU_NAME=$(EMULATOR); \
	EMU_CMD=$$EMU_NAME; \
	PKG_NAME=$$EMU_NAME; \
	if [ "$$EMU_NAME" = "emulicious" ]; then \
		PKG_NAME="emulicious"; \
		EMU_CMD="emulicious"; \
	elif [ "$$EMU_NAME" = "bgb" ]; then \
		PKG_NAME="bgb"; \
	elif [ "$$EMU_NAME" = "sameboy" ]; then \
		PKG_NAME="sameboy"; \
	elif [ "$$EMU_NAME" = "mgba" ]; then \
		PKG_NAME="mgba-qt"; \
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
	if [ "$$EMU_NAME" = "emulicious" ]; then \
		export JAVA_TOOL_OPTIONS="--enable-native-access=ALL-UNNAMED"; \
		export _JAVA_AWT_WM_NONREPARENTING=1; \
		if [ -n "$$WAYLAND_DISPLAY" ] && [ -n "$$DISPLAY" ]; then \
			echo "Wayland detected with XWayland - launching emulicious"; \
			$$EMU_CMD "$(TARGET)"; \
		elif [ -n "$$WAYLAND_DISPLAY" ]; then \
			echo "Wayland detected - launching emulicious"; \
			$$EMU_CMD "$(TARGET)"; \
		elif [ -n "$$DISPLAY" ]; then \
			echo "X11 detected - launching emulicious"; \
			$$EMU_CMD "$(TARGET)"; \
		else \
			echo "Error: No display server detected (X11 or Wayland)"; \
			exit 1; \
		fi; \
	elif [ -n "$$WAYLAND_DISPLAY" ] && [ -n "$$DISPLAY" ]; then \
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
verify: check-python $(TARGET)
	@echo "Verifying ROM structure..."
	@python3 -c "import sys; rom = open('$(TARGET)', 'rb').read(); \
		print(f'ROM size: {len(rom)} bytes'); \
		print(f'  Header: 48 bytes (0x0100-0x014F)'); \
		print(f'  Code: {len(rom) - 48} bytes'); \
		print(f'  Expected: 32 KB (32768 bytes) minimum'); \
		print('✓ Size correct' if len(rom) >= 32768 else '✗ Size incorrect'); \
		header = rom[0x0100:0x0104]; \
		print(f'Entry point: {header.hex()}'); \
		print('✓ Entry point correct' if header[0] == 0x00 and header[1] == 0xC3 else '✗ Entry point incorrect'); \
		logo = rom[0x0104:0x0134]; \
		expected_logo = bytes([0xCE, 0xED, 0x66, 0x66, 0xCC, 0x0D, 0x00, 0x0B, 0x03, 0x73, 0x00, 0x83, 0x00, 0x0C, 0x00, 0x0D, 0x00, 0x08, 0x11, 0x1F, 0x88, 0x89, 0x00, 0x0E, 0xDC, 0xCC, 0x6E, 0xE6, 0xDD, 0xDD, 0xD9, 0x99, 0xBB, 0xBB, 0x67, 0x63, 0x6E, 0x0E, 0xEC, 0xCC, 0xDD, 0xDC, 0x99, 0x9F, 0xBB, 0xB9, 0x33, 0x3E]); \
		print('✓ Nintendo logo correct' if logo == expected_logo else '✗ Nintendo logo incorrect')"

# ============================================================================
# Help Target
# ============================================================================

help:
	@echo "Game Boy Hello World Build System"
	@echo ""
	@echo "Targets:"
	@echo "  make                    - Build ROM (default)"
	@echo "  make clean              - Remove build artifacts"
	@echo "  make distclean          - Deep clean"
	@echo "  make run                - Run ROM with default emulator (emulicious)"
	@echo "  make run EMULATOR=emulicious - Run ROM with emulicious (auto-installs if missing)"
	@echo "  make run EMULATOR=bgb  - Run ROM with bgb (auto-installs if missing)"
	@echo "  make run EMULATOR=sameboy - Run ROM with sameboy (auto-installs if missing)"
	@echo "  make run EMULATOR=mgba  - Run ROM with mgba (auto-installs if missing)"
	@echo "  make verify              - Verify ROM structure"
	@echo "  make help               - Show this help"
	@echo ""
	@echo "Requirements:"
	@echo "  - rgbasm (RGBDS assembler) - will be auto-installed if missing"
	@echo "  - rgblink (RGBDS linker) - will be auto-installed if missing"
	@echo "  - rgbfix (RGBDS ROM fixer) - will be auto-installed if missing"
	@echo "  - Game Boy emulator (emulicious, bgb, sameboy, mgba) - will be auto-installed if missing"
	@echo ""
	@echo "Emulator Selection:"
	@echo "  Default: emulicious"
	@echo "  Options: emulicious, bgb, sameboy, mgba"
