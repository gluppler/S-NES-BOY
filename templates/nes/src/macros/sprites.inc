; ============================================================================
; Sprite Macros
; ============================================================================
; Macros for sprite operations
; Per NES documentation: OAM buffer format
; ============================================================================

.include "memory/oam.inc"

; ============================================================================
; Set Sprite Position
; ============================================================================
; Sets sprite X and Y position in state arrays
; Parameters: index (sprite index 0-63), x (X position), y (Y position)
; ============================================================================
.macro set_sprite_pos index, xpos, ypos
    LDA #xpos
    STA sprite_x + index
    LDA #ypos
    STA sprite_y + index
.endmacro

; ============================================================================
; Set Sprite Tile
; ============================================================================
; Sets sprite tile index
; Parameters: index (sprite index 0-63), tile (tile index)
; ============================================================================
.macro set_sprite_tile index, tile
    LDA #tile
    STA sprite_tile + index
.endmacro

; ============================================================================
; Set Sprite Attributes
; ============================================================================
; Sets sprite attributes
; Parameters: index (sprite index 0-63), attr (attribute byte)
; ============================================================================
.macro set_sprite_attr index, attr
    LDA #attr
    STA sprite_attr + index
.endmacro

; ============================================================================
; Set Sprite Active
; ============================================================================
; Sets sprite active flag
; Parameters: index (sprite index 0-63), active (0=inactive, 1=active)
; ============================================================================
.macro set_sprite_active index, active
    LDA #active
    STA sprite_active + index
.endmacro

; ============================================================================
; Hide Sprite
; ============================================================================
; Hides a sprite by setting Y to 255
; Parameters: index (sprite index 0-63)
; ============================================================================
.macro hide_sprite index
    LDA #$FF
    STA sprite_y + index
    LDA #0
    STA sprite_active + index
.endmacro

; ============================================================================
; Initialize Sprite
; ============================================================================
; Initializes a sprite with position, tile, and attributes
; Parameters: index, x, y, tile, attr
; ============================================================================
.macro init_sprite index, xpos, ypos, tile, attr
    set_sprite_pos index, xpos, ypos
    set_sprite_tile index, tile
    set_sprite_attr index, attr
    set_sprite_active index, 1
.endmacro

; ============================================================================
; Write Sprite to OAM Buffer
; ============================================================================
; Writes sprite data directly to OAM buffer
; Parameters: offset (OAM buffer offset), y, tile, attr, x
; ============================================================================
.macro write_sprite_oam offset, ypos, tile, attr, xpos
    LDA #ypos
    STA OAM_BUFFER + offset
    LDA #tile
    STA OAM_BUFFER + offset + 1
    LDA #attr
    STA OAM_BUFFER + offset + 2
    LDA #xpos
    STA OAM_BUFFER + offset + 3
.endmacro
