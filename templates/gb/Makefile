# ============================================================================
# Game Boy Template Build System
# ============================================================================
# Build system for Game Boy template with modular architecture
# Follows Game Boy documentation best practices
# Auto-installs missing dependencies
# ============================================================================

# Toolchain
AS = rgbasm
LD = rgblink
FIX = rgbfix

# Emulator selection (default: emulicious)
EMULATOR ?= emulicious

# Source files
MAIN_SOURCE = src/main.asm
SOURCES = $(shell find src -name "*.asm" -o -name "*.inc" | sort)
OBJECTS = $(patsubst src/%.asm,build/obj/%.o,$(shell find src -name "*.asm"))

# Target ROM
TARGET = build/rom/game.gb

# Phony targets
.PHONY: all clean distclean run verify help check-toolchain check-emu check-python

# ============================================================================
# Dependency Installation
# ============================================================================

# Install package using detected package manager
define install-package
	@if command -v yay >/dev/null 2>&1; then \
		echo "Installing $(1) via yay..."; \
		yay -S --noconfirm $(1) || (echo "Installation failed. Try: yay -S $(1)" && exit 1); \
	elif command -v paru >/dev/null 2>&1; then \
		echo "Installing $(1) via paru..."; \
		paru -S --noconfirm $(1) || (echo "Installation failed. Try: paru -S $(1)" && exit 1); \
	elif command -v pacman >/dev/null 2>&1; then \
		if pacman -Si $(1) >/dev/null 2>&1; then \
			echo "Installing $(1) via pacman..."; \
			sudo pacman -S --noconfirm $(1) || (echo "Installation failed. Try: sudo pacman -S $(1)" && exit 1); \
		else \
			echo "$(1) not in official repos. Install AUR helper (yay/paru) or: yay -S $(1)"; \
			exit 1; \
		fi; \
	elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
		echo "Installing $(1) via apt..."; \
		sudo apt-get update && sudo apt-get install -y $(1) || (echo "Installation failed. Try: sudo apt-get install $(1)" && exit 1); \
	elif command -v dnf >/dev/null 2>&1; then \
		echo "Installing $(1) via dnf..."; \
		sudo dnf install -y $(1) || (echo "Installation failed. Try: sudo dnf install $(1)" && exit 1); \
	elif command -v yum >/dev/null 2>&1; then \
		echo "Installing $(1) via yum..."; \
		sudo yum install -y $(1) || (echo "Installation failed. Try: sudo yum install $(1)" && exit 1); \
	elif command -v zypper >/dev/null 2>&1; then \
		echo "Installing $(1) via zypper..."; \
		sudo zypper install -y $(1) || (echo "Installation failed. Try: sudo zypper install $(1)" && exit 1); \
	else \
		echo "Error: Could not detect package manager."; \
		echo "Please install $(1) manually for your distribution."; \
		exit 1; \
	fi
endef

# Check and install RGBDS toolchain
check-toolchain:
	@echo "Checking for RGBDS toolchain..."; \
	MISSING_TOOLS=""; \
	if ! command -v $(AS) >/dev/null 2>&1; then \
		MISSING_TOOLS="$$MISSING_TOOLS rgbasm"; \
	fi; \
	if ! command -v $(LD) >/dev/null 2>&1; then \
		MISSING_TOOLS="$$MISSING_TOOLS rgblink"; \
	fi; \
	if ! command -v $(FIX) >/dev/null 2>&1; then \
		MISSING_TOOLS="$$MISSING_TOOLS rgbfix"; \
	fi; \
	if [ -z "$$MISSING_TOOLS" ]; then \
		echo "✓ RGBDS already installed"; \
	else \
		echo "RGBDS toolchain missing. Missing tools:$$MISSING_TOOLS"; \
		PKG_INSTALLED=0; \
		if command -v yay >/dev/null 2>&1; then \
			if yay -Qi rgbds >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "rgbds package is installed but tools not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v paru >/dev/null 2>&1; then \
			if paru -Qi rgbds >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "rgbds package is installed but tools not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v pacman >/dev/null 2>&1; then \
			if pacman -Qi rgbds >/dev/null 2>&1 2>/dev/null || pacman -Si rgbds >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "rgbds package is installed but tools not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
			if dpkg -l | grep -q "^ii.*rgbds "; then \
				PKG_INSTALLED=1; \
				echo "rgbds package is installed but tools not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v dnf >/dev/null 2>&1; then \
			if dnf list installed rgbds >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "rgbds package is installed but tools not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v yum >/dev/null 2>&1; then \
			if yum list installed rgbds >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "rgbds package is installed but tools not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v zypper >/dev/null 2>&1; then \
			if zypper search -i rgbds >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "rgbds package is installed but tools not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		fi; \
		if [ $$PKG_INSTALLED -eq 0 ]; then \
			echo "rgbds package not installed. Installing..."; \
			if command -v yay >/dev/null 2>&1; then \
				echo "Using yay (AUR helper)..."; \
				yay -S --noconfirm rgbds || (echo "Installation failed. Try: yay -S rgbds" && exit 1); \
			elif command -v paru >/dev/null 2>&1; then \
				echo "Using paru (AUR helper)..."; \
				paru -S --noconfirm rgbds || (echo "Installation failed. Try: paru -S rgbds" && exit 1); \
			elif command -v pacman >/dev/null 2>&1; then \
				if pacman -Si rgbds >/dev/null 2>&1; then \
					echo "Using pacman (official repos)..."; \
					sudo pacman -S --noconfirm rgbds || (echo "Installation failed. Try: sudo pacman -S rgbds" && exit 1); \
				else \
					echo "rgbds not in official repos. Install AUR helper (yay/paru) or: yay -S rgbds"; \
					exit 1; \
				fi; \
			elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
				echo "Using apt..."; \
				sudo apt-get update && sudo apt-get install -y rgbds || (echo "Installation failed. Try: sudo apt-get install rgbds" && exit 1); \
			elif command -v dnf >/dev/null 2>&1; then \
				echo "Using dnf..."; \
				sudo dnf install -y rgbds || (echo "Installation failed. Try: sudo dnf install rgbds" && exit 1); \
			elif command -v yum >/dev/null 2>&1; then \
				echo "Using yum..."; \
				sudo yum install -y rgbds || (echo "Installation failed. Try: sudo yum install rgbds" && exit 1); \
			elif command -v zypper >/dev/null 2>&1; then \
				echo "Using zypper..."; \
				sudo zypper install -y rgbds || (echo "Installation failed. Try: sudo zypper install rgbds" && exit 1); \
			else \
				echo "Error: Could not detect package manager."; \
				echo "Please install rgbds manually for your distribution."; \
				exit 1; \
			fi; \
			if ! command -v $(AS) >/dev/null 2>&1 || ! command -v $(LD) >/dev/null 2>&1 || ! command -v $(FIX) >/dev/null 2>&1; then \
				echo "Error: RGBDS installation completed but tools still not found. Restart terminal or check PATH."; \
				exit 1; \
			fi; \
			echo "✓ RGBDS installed successfully"; \
		fi; \
	fi

# Check and install emulator
check-emu:
	@echo "Checking for $(EMULATOR)..."; \
	if command -v $(EMULATOR) >/dev/null 2>&1; then \
		echo "✓ $(EMULATOR) already installed"; \
	else \
		echo "$(EMULATOR) not found in PATH."; \
		EMU_NAME=$(EMULATOR); \
		if [ "$$EMU_NAME" = "mgba" ]; then \
			PKG_NAME="mgba-qt"; \
		else \
			PKG_NAME="$$EMU_NAME"; \
		fi; \
		PKG_INSTALLED=0; \
		if command -v yay >/dev/null 2>&1; then \
			if yay -Qi $$PKG_NAME >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "$$PKG_NAME package is installed but command not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v paru >/dev/null 2>&1; then \
			if paru -Qi $$PKG_NAME >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "$$PKG_NAME package is installed but command not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v pacman >/dev/null 2>&1; then \
			if pacman -Qi $$PKG_NAME >/dev/null 2>&1 2>/dev/null || pacman -Si $$PKG_NAME >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "$$PKG_NAME package is installed but command not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
			if dpkg -l | grep -q "^ii.*$$PKG_NAME "; then \
				PKG_INSTALLED=1; \
				echo "$$PKG_NAME package is installed but command not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v dnf >/dev/null 2>&1; then \
			if dnf list installed $$PKG_NAME >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "$$PKG_NAME package is installed but command not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v yum >/dev/null 2>&1; then \
			if yum list installed $$PKG_NAME >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "$$PKG_NAME package is installed but command not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v zypper >/dev/null 2>&1; then \
			if zypper search -i $$PKG_NAME >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "$$PKG_NAME package is installed but command not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		fi; \
		if [ $$PKG_INSTALLED -eq 0 ]; then \
			echo "$$PKG_NAME package not installed. Installing..."; \
			if command -v yay >/dev/null 2>&1; then \
				echo "Using yay (AUR helper)..."; \
				yay -S --noconfirm $$PKG_NAME || (echo "Installation failed. Try: yay -S $$PKG_NAME" && exit 1); \
			elif command -v paru >/dev/null 2>&1; then \
				echo "Using paru (AUR helper)..."; \
				paru -S --noconfirm $$PKG_NAME || (echo "Installation failed. Try: paru -S $$PKG_NAME" && exit 1); \
			elif command -v pacman >/dev/null 2>&1; then \
				if pacman -Si $$PKG_NAME >/dev/null 2>&1; then \
					echo "Using pacman (official repos)..."; \
					sudo pacman -S --noconfirm $$PKG_NAME || (echo "Installation failed. Try: sudo pacman -S $$PKG_NAME" && exit 1); \
				else \
					echo "$$PKG_NAME not in official repos. Install AUR helper (yay/paru) or: yay -S $$PKG_NAME"; \
					exit 1; \
				fi; \
			elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
				echo "Using apt..."; \
				sudo apt-get update && sudo apt-get install -y $$PKG_NAME || (echo "Installation failed. Try: sudo apt-get install $$PKG_NAME" && exit 1); \
			elif command -v dnf >/dev/null 2>&1; then \
				echo "Using dnf..."; \
				sudo dnf install -y $$PKG_NAME || (echo "Installation failed. Try: sudo dnf install $$PKG_NAME" && exit 1); \
			elif command -v yum >/dev/null 2>&1; then \
				echo "Using yum..."; \
				sudo yum install -y $$PKG_NAME || (echo "Installation failed. Try: sudo yum install $$PKG_NAME" && exit 1); \
			elif command -v zypper >/dev/null 2>&1; then \
				echo "Using zypper..."; \
				sudo zypper install -y $$PKG_NAME || (echo "Installation failed. Try: sudo zypper install $$PKG_NAME" && exit 1); \
			else \
				echo "Error: Could not detect package manager."; \
				echo "Please install $$PKG_NAME manually for your distribution."; \
				exit 1; \
			fi; \
			if ! command -v $(EMULATOR) >/dev/null 2>&1; then \
				echo "Error: $(EMULATOR) installation completed but command not found. Restart terminal or check PATH."; \
				exit 1; \
			fi; \
			echo "✓ $(EMULATOR) installed successfully"; \
		fi; \
	fi

# Check and install Python 3
check-python:
	@echo "Checking for python3..."; \
	if command -v python3 >/dev/null 2>&1; then \
		echo "✓ python3 already installed"; \
	else \
		echo "python3 not found in PATH."; \
		PKG_INSTALLED=0; \
		if command -v yay >/dev/null 2>&1; then \
			if yay -Qi python >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "python package is installed but python3 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v paru >/dev/null 2>&1; then \
			if paru -Qi python >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "python package is installed but python3 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v pacman >/dev/null 2>&1; then \
			if pacman -Qi python >/dev/null 2>&1 2>/dev/null || pacman -Si python >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "python package is installed but python3 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
			if dpkg -l | grep -q "^ii.*python3 "; then \
				PKG_INSTALLED=1; \
				echo "python3 package is installed but python3 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v dnf >/dev/null 2>&1; then \
			if dnf list installed python3 >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "python3 package is installed but python3 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v yum >/dev/null 2>&1; then \
			if yum list installed python3 >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "python3 package is installed but python3 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v zypper >/dev/null 2>&1; then \
			if zypper search -i python3 >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "python3 package is installed but python3 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		fi; \
		if [ $$PKG_INSTALLED -eq 0 ]; then \
			echo "python3 package not installed. Installing..."; \
			if command -v yay >/dev/null 2>&1; then \
				echo "Using yay (AUR helper)..."; \
				yay -S --noconfirm python || (echo "Installation failed. Try: yay -S python" && exit 1); \
			elif command -v paru >/dev/null 2>&1; then \
				echo "Using paru (AUR helper)..."; \
				paru -S --noconfirm python || (echo "Installation failed. Try: paru -S python" && exit 1); \
			elif command -v pacman >/dev/null 2>&1; then \
				if pacman -Si python >/dev/null 2>&1; then \
					echo "Using pacman (official repos)..."; \
					sudo pacman -S --noconfirm python || (echo "Installation failed. Try: sudo pacman -S python" && exit 1); \
				else \
					echo "python not in official repos. Install AUR helper (yay/paru) or: yay -S python"; \
					exit 1; \
				fi; \
			elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
				echo "Using apt..."; \
				sudo apt-get update && sudo apt-get install -y python3 || (echo "Installation failed. Try: sudo apt-get install python3" && exit 1); \
			elif command -v dnf >/dev/null 2>&1; then \
				echo "Using dnf..."; \
				sudo dnf install -y python3 || (echo "Installation failed. Try: sudo dnf install python3" && exit 1); \
			elif command -v yum >/dev/null 2>&1; then \
				echo "Using yum..."; \
				sudo yum install -y python3 || (echo "Installation failed. Try: sudo yum install python3" && exit 1); \
			elif command -v zypper >/dev/null 2>&1; then \
				echo "Using zypper..."; \
				sudo zypper install -y python3 || (echo "Installation failed. Try: sudo zypper install python3" && exit 1); \
			else \
				echo "Error: Could not detect package manager."; \
				echo "Please install python3 manually for your distribution."; \
				exit 1; \
			fi; \
			if ! command -v python3 >/dev/null 2>&1; then \
				echo "Error: python3 installation completed but python3 not found. Restart terminal or check PATH."; \
				exit 1; \
			fi; \
			echo "✓ python3 installed successfully"; \
		fi; \
	fi

# ============================================================================
# Build Targets
# ============================================================================

# Default target: build ROM
all: check-toolchain $(TARGET)

# Create build directories
build/obj build/rom build/map:
	@mkdir -p $@

# Build object files from assembly source
build/obj/%.o: src/%.asm | build/obj check-toolchain
	@echo "Assembling $<..."
	@mkdir -p $(dir $@)
	$(AS) -i src $< -o $@

# Link ROM from object files
$(TARGET): $(OBJECTS) | build/rom build/map
	@echo "Linking $(TARGET)..."
	$(LD) -o $(TARGET) $(OBJECTS) -m build/map/game.map
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

# Run ROM in selected emulator
# Auto-installs emulator if not found
run: $(TARGET) check-emu
	@echo "Running $(TARGET) in $(EMULATOR)..."
	@EMU_NAME=$(EMULATOR); \
	EMU_CMD=$$EMU_NAME; \
	if [ "$$EMU_NAME" = "emulicious" ]; then \
		export JAVA_TOOL_OPTIONS="--enable-native-access=ALL-UNNAMED"; \
		export _JAVA_AWT_WM_NONREPARENTING=1; \
		if [ -n "$$WAYLAND_DISPLAY" ] || [ -n "$$DISPLAY" ]; then \
			$$EMU_CMD "$(TARGET)"; \
		else \
			echo "Error: No display server detected"; \
			exit 1; \
		fi; \
	elif [ -n "$$WAYLAND_DISPLAY" ] && [ -n "$$DISPLAY" ]; then \
		echo "Wayland+XWayland - using XCB platform"; \
		QT_QPA_PLATFORM=xcb QT_LOGGING_RULES="qt.qpa.*=false" $$EMU_CMD "$(TARGET)" 2>&1 | grep -v "paintEngine\|qt.qpa" || true; \
	elif [ -n "$$WAYLAND_DISPLAY" ]; then \
		echo "Wayland - using XCB platform (more compatible)"; \
		QT_QPA_PLATFORM=xcb QT_LOGGING_RULES="qt.qpa.*=false" $$EMU_CMD "$(TARGET)" 2>&1 | grep -v "paintEngine\|qt.qpa" || true; \
	elif [ -n "$$DISPLAY" ]; then \
		echo "X11 - using XCB platform"; \
		QT_QPA_PLATFORM=xcb QT_LOGGING_RULES="qt.qpa.*=false" $$EMU_CMD "$(TARGET)" 2>&1 | grep -v "paintEngine\|qt.qpa" || true; \
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
	@echo "Game Boy Template Build System"
	@echo ""
	@echo "Targets:"
	@echo "  make                    - Build ROM (default)"
	@echo "  make clean              - Remove build artifacts"
	@echo "  make distclean          - Deep clean"
	@echo "  make run                - Run ROM with default emulator (emulicious)"
	@echo "  make run EMULATOR=<name> - Run with specified emulator"
	@echo "  make verify              - Verify ROM structure"
	@echo "  make help               - Show this help"
	@echo ""
	@echo "Requirements (auto-installed if missing):"
	@echo "  - RGBDS (rgbasm, rgblink, rgbfix)"
	@echo "  - emulicious (Game Boy emulator, default) or bgb, sameboy, mgba"
	@echo "  - python3 (for verify target)"
