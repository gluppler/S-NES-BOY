; ============================================================================
; Attribute Table Management
; ============================================================================
; Per NES documentation: Attribute table utilities
; ============================================================================

.include "constants/ppu.inc"
.include "memory/zeropage.inc"

; ============================================================================
; Write Attribute Byte
; ============================================================================
; Input: A = high byte of attribute address, X = low byte, Y = attribute value
; ============================================================================
write_attribute:
    PHA                 ; Save attribute value
    JSR set_ppu_address ; Set PPU address (A=high, X=low)
    PLA                 ; Restore attribute value
    STA PPUDATA         ; Write attribute byte
    RTS
