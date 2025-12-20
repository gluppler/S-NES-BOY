# Makefile for hex_string_example

CA65 = ca65
LD65 = ld65

SOURCES = src/main.asm
OBJECTS = build/main.o
ROM = build/hex_string_example.nes

.PHONY: all clean run

all: $(ROM)

$(ROM): $(OBJECTS)
	$(LD65) -C nes.cfg -o $(ROM) $(OBJECTS)

build/%.o: src/%.asm | build
	$(CA65) -g -I src -o $@ $<

build:
	@mkdir -p build

clean:
	rm -rf build

run: $(ROM)
	@echo "Run $(ROM) in your NES emulator"
