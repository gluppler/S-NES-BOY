; ============================================================================
; PPU Write Utilities
; ============================================================================
; Per NES documentation: PPU write utilities
; ============================================================================

.include "constants/ppu.inc"
.include "memory/zeropage.inc"

; ============================================================================
; Set PPU Address
; ============================================================================
; Input: A = high byte, X = low byte
; ============================================================================
set_ppu_address:
    PHA
    LDA PPUSTATUS       ; Reset latch
    PLA
    STA PPUADDR         ; Write high byte first
    TXA
    STA PPUADDR         ; Write low byte second
    RTS

; ============================================================================
; Write Tile to PPU
; ============================================================================
; Input: A = tile index
; ============================================================================
write_tile:
    STA PPUDATA         ; Write tile, auto-increments address
    RTS
