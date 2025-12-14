; ============================================================================
; NES Template - Main Entry Point
; ============================================================================
; Full-featured NES project template with modular architecture
; Follows NES documentation best practices and hardware-accurate patterns
;
; This template applies to:
;   - ✅ NES (Nintendo Entertainment System): Primary focus
;   - ✅ : Fully compatible (same hardware)
;   - ❌ SNES: Does not apply (see ../snes/ for SNES template)
;
; Architecture:
;   - 32 KB PRG ROM (Mapper 0, NROM)
;   - 8 KB CHR ROM (512 tiles)
;   - Frame-synchronized game loop
;   - Modular architecture
; ============================================================================

.segment "HEADER"
    .byte "NES", $1A    ; iNES header identifier
    .byte 2             ; 32 KB PRG ROM (2 * 16 KB)
    .byte 1             ; 8 KB CHR ROM (1 * 8 KB)
    .byte %00000000     ; Mapper 0, horizontal mirroring, no battery
    .byte %00000000     ; Mapper 0 (high), NES format
    .byte 0             ; PRG RAM size
    .byte 0             ; NTSC
    .byte 0, 0, 0, 0, 0, 0  ; Unused

; Include interrupt vectors
.include "vectors.asm"

.segment "CODE"

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
; Per NES documentation: Game loop pattern with frame synchronization
; ============================================================================
main_loop:
    ; Wait for frame
    ; Per NES documentation: Frame synchronization
    LDA frame_ready
    BEQ main_loop       ; Wait until frame ready flag is set
    
    ; Clear frame flag
    LDA #0
    STA frame_ready
    
    ; Read controllers
    ; Per NES documentation: Input polling
    JSR read_controllers
    
    ; Update game state
    ; Per NES documentation: Game logic runs in main loop, not NMI
    JSR update_game_state
    
    ; Update game logic
    JSR update_game
    
    ; Update rendering data
    ; Per NES documentation: Prepare rendering data before NMI
    JSR update_rendering
    
    ; Loop back
    JMP main_loop

; ============================================================================
; Update Game
; ============================================================================
; Per NES documentation: Game logic runs in main loop, not NMI
; ============================================================================
update_game:
    ; ADD CODE HERE: Game logic goes here
    ; This is called once per frame (60 Hz NTSC)
    RTS

; ============================================================================
; Update Rendering
; ============================================================================
; Per NES documentation: Prepare rendering data before NMI
; ============================================================================
update_rendering:
    ; Update OAM buffer from sprite state
    ; Per NES documentation: OAM buffer is updated via DMA in NMI
    JSR update_oam_buffer
    
    ; ADD CODE HERE: Additional rendering preparation
    RTS

; ============================================================================
; Data Section
; ============================================================================
; Per NES documentation: Constants and data in ROM
; ============================================================================

; ============================================================================
; CHR ROM Data
; ============================================================================
; Per NES documentation: Pattern table data, 8 KB (512 tiles × 16 bytes)
; ============================================================================
.segment "CHARS"
    .incbin "graphics/chr/font.chr"
