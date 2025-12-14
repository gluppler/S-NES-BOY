; ============================================================================
; SNES Template - Main Entry Point
; ============================================================================
; Full-featured SNES project template with modular architecture
; Follows SNES documentation best practices and hardware-accurate patterns
;
; Architecture:
;   - LoROM mapping (banks $00-$7F)
;   - 32 KB PRG ROM
;   - 8 KB CHR ROM
;   - Mode 0 (4 BGs, 4 colors per BG)
;   - 256x224 screen resolution (NTSC)
;   - Frame-synchronized game loop
;   - Modular architecture
; ============================================================================

.segment "HEADER"
    .org $7FB0
    .byte "SNES TEMPLATE GAME  "  ; 21-byte title
    .byte $20                    ; ROM type (LoROM + FastROM)
    .byte $00                    ; ROM size (128 KBit = 16 KB)
    .byte $00                    ; SRAM size (0 = no SRAM)
    .byte $00                    ; Region (0 = NTSC)
    .byte $33                    ; Licensee code
    .byte $00                    ; Version number
    .word $0000                  ; Checksum complement
    .word $0000                  ; Checksum
    .addr $0000, $0000           ; Unused
    .addr nmi, reset, irq        ; Interrupt vectors
    .addr $0000, $0000           ; Unused
    .byte $00                    ; Expansion RAM size
    .byte $00                    ; Special version
    .byte $00                    ; Special version complement

.segment "VECTORS"
    .org $7FE4
    .addr $0000                  ; COP
    .addr $0000                  ; BRK
    .addr $0000                  ; ABORT
    .addr nmi                    ; NMI
    .addr $0000                  ; Unused
    .addr irq                    ; IRQ
    .addr $0000, $0000           ; Unused

    .org $7FFC
    .addr reset

.segment "CODE"
    .org $8000

; ============================================================================
; Include Memory Definitions
; ============================================================================
.include "memory/zeropage.inc"
.include "memory/ram.inc"
.include "memory/oam.inc"
.include "memory/stack.inc"

; ============================================================================
; Include Constants
; ============================================================================
.include "constants/cpu.inc"
.include "constants/ppu.inc"
.include "constants/apu.inc"
.include "constants/controller.inc"
.include "constants/mapper.inc"

; ============================================================================
; Include Macros
; ============================================================================
.include "macros/registers.inc"
.include "macros/ppu.inc"
.include "macros/memory.inc"
.include "macros/math.inc"
.include "macros/sprites.inc"
.include "macros/loops.inc"
.include "macros/branches.inc"
.include "macros/controller.inc"
.include "macros/text.inc"
.include "macros/timing.inc"

; ============================================================================
; Include Sprite System (needed by reset.asm)
; ============================================================================
.include "sprites/sprite_dma.asm"
.include "sprites/sprite_utils.asm"

; ============================================================================
; Include State Management (needed by reset.asm)
; ============================================================================
.include "state/state_machine.asm"

; ============================================================================
; Include Palette System (needed by reset.asm)
; ============================================================================
.include "palette/palette_load.asm"

; ============================================================================
; Include Core Modules
; ============================================================================
.include "reset.asm"
.include "nmi.asm"
.include "irq.asm"

; ============================================================================
; Include Input System
; ============================================================================
.include "input/controller.asm"
.include "input/debounce.asm"

; ============================================================================
; Include PPU System
; ============================================================================
.include "ppu/ppu_init.asm"
.include "ppu/ppu_write.asm"
.include "ppu/scrolling.asm"
.include "ppu/attributes.asm"

; ============================================================================
; Include Text System
; ============================================================================
.include "text/print.asm"
.include "text/print_centered.asm"

; ============================================================================
; Include Tilemap System
; ============================================================================
.include "tilemap/tilemap_loader.asm"

; ============================================================================
; Include Game Logic
; ============================================================================
.include "game/entities.asm"

; ============================================================================
; Include Screen Modules
; ============================================================================
.include "screens/welcome.asm"
.include "screens/game.asm"

; ============================================================================
; Main Loop
; ============================================================================
; Per SNES documentation: Game loop pattern with frame synchronization
; ============================================================================
main_loop:
    ; Wait for frame
    ; Per SNES documentation: Frame synchronization via NMI
    WAI                 ; Wait for interrupt (NMI)
    
    ; Read controllers
    ; Per SNES documentation: Input polling
    JSR read_controllers
    
    ; Update game state
    ; Per SNES documentation: Game logic runs in main loop, not NMI
    JSR update_game_state
    
    ; Update game logic
    JSR update_game
    
    ; Update rendering data
    ; Per SNES documentation: Prepare rendering data before NMI
    JSR update_rendering
    
    ; Loop back
    JMP main_loop

; ============================================================================
; Update Game
; ============================================================================
; Per SNES documentation: Game logic runs in main loop, not NMI
; ============================================================================
update_game:
    ; ADD CODE HERE: Game logic goes here
    ; This is called once per frame (60 Hz NTSC)
    RTS

; ============================================================================
; Update Rendering
; ============================================================================
; Per SNES documentation: Prepare rendering data before NMI
; ============================================================================
update_rendering:
    ; Update OAM buffer from sprite state
    ; Per SNES documentation: OAM buffer is updated via DMA in NMI
    JSR update_oam_buffer
    
    ; ADD CODE HERE: Additional rendering preparation
    RTS

; ============================================================================
; Data Section
; ============================================================================
; Per SNES documentation: Constants and data in ROM
; ============================================================================

; ============================================================================
; CHR ROM Data
; ============================================================================
; Per SNES documentation: Pattern table data, 8 KB (512 tiles × 16 bytes)
; ============================================================================
.segment "CHARS"
    .incbin "graphics/chr/font.chr"
