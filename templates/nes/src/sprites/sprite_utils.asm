; ============================================================================
; Sprite Utilities
; ============================================================================
; Per NES documentation: Sprite management utilities
; ============================================================================

.include "memory/oam.inc"
.include "memory/zeropage.inc"

; ============================================================================
; Initialize Sprites
; ============================================================================
.export init_sprites, update_oam_buffer
init_sprites:
    LDX #0
    LDA #$FF
clear_oam:
    STA OAM_BUFFER,X
    INX
    BNE clear_oam
    
    LDX #0
    LDA #0
clear_sprite_state:
    STA sprite_x,X
    STA sprite_y,X
    STA sprite_tile,X
    STA sprite_attr,X
    STA sprite_active,X
    INX
    CPX #MAX_SPRITES
    BNE clear_sprite_state
    RTS

; ============================================================================
; Update OAM Buffer
; ============================================================================
update_oam_buffer:
    LDX #0
update_oam_loop:
    LDA sprite_active,X
    BEQ sprite_inactive
    
    TXA
    ASL
    ASL
    TAY
    
    LDA sprite_y,X
    STA OAM_BUFFER,Y
    INY
    LDA sprite_tile,X
    STA OAM_BUFFER,Y
    INY
    LDA sprite_attr,X
    STA OAM_BUFFER,Y
    INY
    LDA sprite_x,X
    STA OAM_BUFFER,Y
    
    JMP sprite_next
    
sprite_inactive:
    TXA
    ASL
    ASL
    TAY
    LDA #$FF
    STA OAM_BUFFER,Y
    
sprite_next:
    INX
    CPX #MAX_SPRITES
    BNE update_oam_loop
    RTS
