; ============================================================================
; NMI Handler
; ============================================================================
; Per NES documentation: Called every frame during VBlank (60 Hz NTSC)
; Must complete quickly (< ~2000 cycles) to avoid frame drops
; ============================================================================

.include "memory/zeropage.inc"
.include "memory/oam.inc"
.include "constants/ppu.inc"

nmi:
    ; Save CPU registers
    ; Per NES documentation: NMI can interrupt main loop, must preserve state
    PHA                 ; Save accumulator
    TXA
    PHA                 ; Save X register
    TYA
    PHA                 ; Save Y register
    
    ; Read PPUSTATUS to clear VBlank flag
    ; Per NES documentation: Required! Reading PPUSTATUS clears bit 7
    LDA PPUSTATUS
    
    ; Update OAM via DMA
    ; Per NES documentation: Fastest way to update sprites (513 cycles)
    LDA #0
    STA OAMADDR         ; OAM address = 0
    LDA #>OAM_BUFFER    ; High byte of OAM buffer address
    STA $4014           ; Start OAM DMA (513 cycles)
    
    ; Update scroll registers
    ; Per NES documentation: Must be written twice per frame to maintain position
    ; First write = X scroll, second write = Y scroll
    LDA scroll_x
    STA PPUSCROLL       ; X scroll
    LDA scroll_y
    STA PPUSCROLL       ; Y scroll
    
    ; Update PPU control register
    ; Per NES documentation: Must be done every frame
    LDA ppu_ctrl
    STA PPUCTRL
    
    ; Increment frame counter
    INC frame_counter
    
    ; Set frame ready flag
    ; Per NES documentation: Frame synchronization
    LDA #1
    STA frame_ready
    
    ; Restore CPU registers
    PLA                 ; Restore Y register
    TAY
    PLA                 ; Restore X register
    TAX
    PLA                 ; Restore accumulator
    RTI                 ; Return from interrupt
