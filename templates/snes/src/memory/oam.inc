; ============================================================================
; OAM (Object Attribute Memory) Definitions
; ============================================================================
; SNES hardware behavior: OAM buffer format
; ============================================================================

.ifndef SNES_OAM_INC
SNES_OAM_INC = 1

OAM_BUFFER = $0200      ; OAM buffer (256 bytes, 64 sprites)
SPRITE_SIZE = 4         ; 4 bytes per sprite (Y, Tile, Attributes, X)
MAX_SPRITES = 64        ; Maximum number of sprites

; Sprite attribute bits
SPRITE_PALETTE_0 = %00000000
SPRITE_PALETTE_1 = %00000001
SPRITE_PALETTE_2 = %00000010
SPRITE_PALETTE_3 = %00000011
SPRITE_PRIORITY_BG = %00100000  ; Behind background
SPRITE_FLIP_H = %01000000       ; Flip horizontally
SPRITE_FLIP_V = %10000000       ; Flip vertically

; Sprite state arrays (struct-of-arrays pattern for efficiency)
sprite_x = $0400        ; Sprite X positions (64 bytes, one per sprite)
sprite_y = $0440        ; Sprite Y positions (64 bytes, one per sprite)
sprite_tile = $0480     ; Sprite tile indices (64 bytes, one per sprite)
sprite_attr = $04C0     ; Sprite attributes (64 bytes, one per sprite)
sprite_active = $0500   ; Sprite active flags (64 bytes, 0=inactive, 1=active)

.endif ; SNES_OAM_INC
