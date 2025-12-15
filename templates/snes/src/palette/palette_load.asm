; ============================================================================
; Palette Loading
; ============================================================================
; SNES hardware behavior: Load palette to PPU
; ============================================================================

.include "constants/ppu.inc"
.include "palette/palette_data.asm"

; ============================================================================
; Load Palette
; ============================================================================
load_palette:
    LDA PPUSTATUS
    LDA #$3F
    STA PPUADDR
    LDA #$00
    STA PPUADDR
    
    LDY #0
palette_loop:
    LDA palette_data,Y
    STA PPUDATA
    INY
    CPY #32
    BNE palette_loop
    
    LDA PPUSTATUS
    LDA #$3F
    STA PPUADDR
    LDA #$00
    STA PPUADDR
    LDA #$0F
    STA PPUDATA
    
    RTS
