#!/usr/bin/env python3
"""
Post-process SNES ROM to fix LoROM file structure.
ld65 creates a flat ROM starting at offset 0, but LoROM needs:
- File offset 0x0000-0x7FAF: padding (all zeros)
- File offset 0x7FB0-0x7FFF: header and vectors (80 bytes)
- File offset 0x8000+: PRG ROM (32KB) + CHR ROM (8KB)
"""

import sys

def fix_rom(input_file, output_file):
    with open(input_file, 'rb') as f:
        flat_rom = f.read()
    
    # Create LoROM structure: 0x7FB0 (header area) + 0x8000 (PRG, includes tile_data) = 65568 bytes
    # Note: tile_data is now in PRG ROM (CODE segment), not separate CHR ROM
    lorom_size = 0x7FB0 + 0x8000  # 65568 bytes (32768 bytes PRG max)
    lorom_rom = bytearray(lorom_size)
    
    # Extract header area (0x7FB0-0x7FFF = 80 bytes)
    # The flat ROM from ld65 has header at offset 0, vectors after header, then code
    header_area_size = 0x50  # 80 bytes (0x7FB0 to 0x7FFF)
    
    # Find where code starts
    # SNES reset handler: SEI (0x78), CLD (0xD8), REP #$38 (0xC2 0x38), XCE (0xFB)
    # Look for SEI CLD pattern (0x78 0xD8) which is common in reset handlers
    code_start_flat = None
    for i in range(len(flat_rom) - 3):
        if flat_rom[i] == 0x78 and flat_rom[i+1] == 0xD8:  # SEI CLD
            code_start_flat = i
            break
    
    if code_start_flat is None:
        # Fallback: look for REP #$38 XCE pattern (0xC2 0x38 0xFB)
        for i in range(len(flat_rom) - 3):
            if flat_rom[i] == 0xC2 and flat_rom[i+1] == 0x38 and flat_rom[i+2] == 0xFB:
                code_start_flat = i
                break
    
    if code_start_flat is None:
        # Final fallback: assume header is first 0x50 bytes, code starts after
        code_start_flat = header_area_size
    
    # Extract header and vectors
    # ld65 places segments sequentially in the flat ROM, not at their load addresses
    # HEADER segment is at offset 0 (46 bytes: 0x7FB0-0x7FDD in SNES space)
    # VECTORS segment follows HEADER (28 bytes: 0x7FE4-0x7FFF in SNES space)
    # CODE segment follows VECTORS (starts at $8000 in SNES space)
    
    # Copy HEADER segment (0x7FB0-0x7FDD, 0x2E bytes = 46 bytes)
    header_size = 0x2E
    if len(flat_rom) >= header_size:
        header_data = flat_rom[0:header_size]
        lorom_rom[0x7FB0:0x7FB0 + header_size] = header_data
    
    # Extract vectors from VECTORS segment (0x7FE4-0x7FFF in SNES space)
    # VECTORS segment should be right after HEADER in the flat ROM
    vectors_start_flat = header_size  # VECTORS follows HEADER
    vectors_size = 0x1C  # 28 bytes
    
    # Check if VECTORS segment has actual data (not all zeros)
    if len(flat_rom) >= vectors_start_flat + vectors_size:
        vectors_data = flat_rom[vectors_start_flat:vectors_start_flat + vectors_size]
        # If VECTORS segment is all zeros, extract vectors from HEADER instead
        # (HEADER segment contains .addr nmi, reset, irq)
        # The vectors are at offset 0x0021 in HEADER (after .addr $0000, $0000)
        if all(b == 0 for b in vectors_data):
            # Extract vectors from HEADER segment
            # .addr outputs little-endian: low byte first, then high byte
            if len(header_data) >= 0x0027:
                # HEADER has vectors starting at offset 0x0021: nmi, reset, irq (6 bytes)
                # Little-endian: low byte | (high byte << 8)
                nmi_vec = header_data[0x0021] | (header_data[0x0022] << 8)
                reset_vec = header_data[0x0023] | (header_data[0x0024] << 8)
                irq_vec = header_data[0x0025] | (header_data[0x0026] << 8)
                
                # Place vectors in correct SNES locations (little-endian format)
                lorom_rom[0x7FEA:0x7FEA+2] = nmi_vec.to_bytes(2, 'little')
                lorom_rom[0x7FFC:0x7FFC+2] = reset_vec.to_bytes(2, 'little')
                lorom_rom[0x7FEE:0x7FEE+2] = irq_vec.to_bytes(2, 'little')
                # COP, BRK, ABORT remain zero (already zero in lorom_rom)
        else:
            # VECTORS segment has data, use it
            lorom_rom[0x7FE4:0x7FE4 + vectors_size] = vectors_data
    
    # Extract code (everything from code_start, up to 32KB)
    # Note: tile_data is now in CODE segment (PRG ROM), not CHR ROM
    # So all data is in the CODE segment and will be placed at 0x8000
    code_size = min(0x8000, len(flat_rom) - code_start_flat)
    if code_size > 0:
        code_data = flat_rom[code_start_flat:code_start_flat + code_size]
        lorom_rom[0x8000:0x8000 + code_size] = code_data
    
    # Note: CHR ROM extraction removed - tile_data is now in CODE segment (PRG ROM)
    # This allows DMA access to tile data from CPU
    
    # Write output
    with open(output_file, 'wb') as f:
        f.write(lorom_rom)
    
    print(f"Fixed ROM structure:")
    print(f"  Size: {len(lorom_rom)} bytes")
    header_title = lorom_rom[0x7FB0:0x7FB0+21].decode('ascii', errors='ignore')
    print(f"  Header at 0x7FB0: {header_title}")
    reset_vec = (lorom_rom[0x7FFD] << 8) | lorom_rom[0x7FFC]
    print(f"  Reset vector at 0x7FFC: 0x{reset_vec:04X}")
    print(f"  Code at 0x8000: {lorom_rom[0x8000:0x8010].hex()}")
    return True

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: fix_rom.py <input.rom> <output.rom>")
        sys.exit(1)
    
    fix_rom(sys.argv[1], sys.argv[2])
