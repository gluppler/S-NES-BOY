; ============================================================================
; PPU Macros
; ============================================================================
; Macros for PPU operations
; SNES hardware behavior: PPU register access patterns
; ============================================================================

.include "constants/ppu.inc"

; ============================================================================
; Set PPU Address
; ============================================================================
; Sets PPU address for reading/writing
; Parameters: addr (16-bit address)
; ============================================================================
.macro set_ppu_addr addr
    LDA PPUSTATUS       ; Reset latch
    LDA #>(addr)        ; High byte
    STA PPUADDR
    LDA #<(addr)        ; Low byte
    STA PPUADDR
.endmacro

; ============================================================================
; Write PPU Data
; ============================================================================
; Writes a byte to PPU data register
; Parameters: value (immediate value or memory address)
; ============================================================================
.macro write_ppu_data value
    .if .match(.left(1, {value}), #)
        ; Immediate value
        LDA value
        STA PPUDATA
    .else
        ; Memory address
        LDA value
        STA PPUDATA
    .endif
.endmacro

; ============================================================================
; Write PPU Data Immediate
; ============================================================================
; Writes an immediate byte value to PPU
; Parameters: value (8-bit immediate)
; ============================================================================
.macro write_ppu_immediate value
    LDA #value
    STA PPUDATA
.endmacro

; ============================================================================
; Wait for VBlank
; ============================================================================
; Waits for VBlank flag to be set
; ============================================================================
.macro wait_vblank
    BIT PPUSTATUS
    BPL *-3             ; Wait for bit 7 to be set
.endmacro

; ============================================================================
; Clear VBlank Flag
; ============================================================================
; Reads PPUSTATUS to clear VBlank flag
; ============================================================================
.macro clear_vblank
    LDA PPUSTATUS
.endmacro

; ============================================================================
; Disable Rendering
; ============================================================================
; Disables PPU rendering (NMI and display)
; ============================================================================
.macro disable_rendering
    LDA #0
    STA PPUCTRL
    STA PPUMASK
.endmacro

; ============================================================================
; Enable Rendering
; ============================================================================
; Enables PPU rendering with standard settings
; Parameters: ctrl (PPUCTRL value), mask (PPUMASK value)
; ============================================================================
.macro enable_rendering ctrl, mask
    LDA #ctrl
    STA PPUCTRL
    LDA #mask
    STA PPUMASK
.endmacro
