; ============================================================================
; Attribute Table Management
; ============================================================================
; Per NES documentation: Attribute table utilities
; Note: set_ppu_address is defined in ppu/ppu_write.asm and must be included before this file
; ============================================================================

.include "constants/ppu.inc"
.include "memory/zeropage.inc"

; ============================================================================
; Write Attribute Byte
; ============================================================================
; Input: A = high byte of attribute address, X = low byte, Y = attribute value
; Note: Requires set_ppu_address from ppu/ppu_write.asm to be included first
; ============================================================================
write_attribute:
    PHA                 ; Save attribute value
    ; Set PPU address inline (since we can't rely on set_ppu_address being available)
    PHA                 ; Save high byte again
    LDA PPUSTATUS       ; Reset latch
    PLA                 ; Restore high byte
    STA PPUADDR         ; Write high byte first
    TXA                 ; Low byte
    STA PPUADDR         ; Write low byte second
    PLA                 ; Restore attribute value
    STA PPUDATA         ; Write attribute byte
    RTS
