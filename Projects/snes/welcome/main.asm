; ============================================================================
; Welcome SNES Program - Centered Text Display
; ============================================================================
; Displays "WELCOME TO S-NES-BOY" centered on screen
; Follows SNES documentation best practices and hardware-accurate patterns
;
; Architecture:
;   - LoROM mapping (banks $00-$7F)
;   - Mode 0 (4 BGs, 4 colors per BG)
;   - 256x224 screen resolution (NTSC)
; ============================================================================


.segment "HEADER"
    .org $7FB0
    .byte "WELCOME TO S-NES-BOY"  ; 21-byte title
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

; Direct Page Variables
zp_temp = $00
text_ptr = $02

; ============================================================================
; Reset Handler
; ============================================================================
reset:
    SEI                          ; Disable interrupts
    CLD                          ; Clear decimal mode
    REP #$38                     ; Native mode, clear decimal, clear accumulator
    XCE                          ; Switch from emulation to native mode
    
    ; Initialize stack (16-bit mode)
    REP #$20                     ; 16-bit accumulator
    LDA #$01FF
    TCS                          ; Stack pointer = $01FF
    
    ; Initialize direct page
    LDA #$0000
    TCD                          ; Direct page = $0000
    SEP #$20                     ; 8-bit accumulator for PPU registers
    
    ; Force blank (8-bit mode)
    SEP #$20                     ; 8-bit accumulator
    LDA #$8F                     ; Force blank, brightness = 0
    STA $2100                    ; INIDISP
    
    ; Initialize PPU registers
    STZ $2101                    ; OBSEL
    STZ $2102                    ; OAMADDL
    STZ $2103                    ; OAMADDH
    STZ $2105                    ; BGMODE (Mode 0)
    STZ $2106                    ; MOSAIC
    STZ $2107                    ; BG1SC
    STZ $2108                    ; BG2SC
    STZ $2109                    ; BG3SC
    STZ $210A                    ; BG4SC
    LDA #$10                     ; BG12NBA: BG1 tiles at VRAM $1000 (bit 0-3 = 1), BG2 at $0000
    STA $210B                    ; BG12NBA
    STZ $210C                    ; BG34NBA
    STZ $210D                    ; BG1HOFS (low)
    STZ $210D                    ; BG1HOFS (high)
    STZ $210E                    ; BG1VOFS (low)
    STZ $210E                    ; BG1VOFS (high)
    STZ $210F                    ; BG2HOFS (low)
    STZ $210F                    ; BG2HOFS (high)
    STZ $2110                    ; BG2VOFS (low)
    STZ $2110                    ; BG2VOFS (high)
    STZ $2111                    ; BG3HOFS (low)
    STZ $2111                    ; BG3HOFS (high)
    STZ $2112                    ; BG3VOFS (low)
    STZ $2112                    ; BG3VOFS (high)
    STZ $2113                    ; BG4HOFS (low)
    STZ $2113                    ; BG4HOFS (high)
    STZ $2114                    ; BG4VOFS (low)
    STZ $2114                    ; BG4VOFS (high)
    STZ $2115                    ; VMAIN
    STZ $2116                    ; VMADDL
    STZ $2117                    ; VMADDH
    STZ $2121                    ; CGADD
    STZ $2122                    ; CGDATA
    STZ $2123                    ; W12SEL
    STZ $2124                    ; W34SEL
    STZ $2125                    ; WOBJSEL
    STZ $2126                    ; WH0
    STZ $2127                    ; WH1
    STZ $2128                    ; WH2
    STZ $2129                    ; WH3
    STZ $212A                    ; WBGLOG
    STZ $212B                    ; WOBJLOG
    STZ $212C                    ; TM
    STZ $212D                    ; TS
    STZ $212E                    ; TMW
    STZ $212F                    ; TSW
    LDA #$30
    STA $2130                    ; CGWSEL
    STZ $2131                    ; CGADSUB
    LDA #$E0
    STA $2132                    ; COLDATA
    STZ $2133                    ; SETINI
    
    ; Clear WRAM using DMA
    REP #$20                     ; 16-bit accumulator
    STZ $2181                    ; WRAM address = $0000
    STZ $2183                    ; WRAM bank = $00
    LDA #$8008                   ; DMA: fixed source, write to WRAM, 1 byte transfer
    STA $4300                    ; DMA parameters
    LDA #$0000                   ; Source address = $0000
    STA $4302
    STZ $4304                    ; Source bank = $00
    LDA #$FFFF                   ; Transfer size = 65536 bytes
    STA $4305
    SEP #$20                     ; 8-bit accumulator
    LDA #$01                     ; Enable DMA channel 0
    STA $420B
    
    ; Wait for VBlank
    LDA $4210                    ; Read RDNMI
vblank_wait1:
    BIT $4210                    ; Check VBlank flag
    BPL vblank_wait1
    
    ; Clear VRAM using DMA
    REP #$20                     ; 16-bit accumulator
    LDA #$80                     ; VRAM increment = 1 word
    STA $2115                    ; VMAIN
    STZ $2116                    ; VRAM address = $0000
    LDA #$1809                   ; DMA: fixed source, write to VRAM, 1 word transfer
    STA $4300                    ; DMA parameters
    LDA #$0000                   ; Source address = $0000
    STA $4302
    STZ $4304                    ; Source bank = $00
    LDA #$FFFF                   ; Transfer size = 65536 bytes
    STA $4305
    SEP #$20                     ; 8-bit accumulator
    LDA #$01                     ; Enable DMA channel 0
    STA $420B
    
    ; Wait for VBlank
    LDA $4210                    ; Read RDNMI
vblank_wait2:
    BIT $4210                    ; Check VBlank flag
    BPL vblank_wait2
    
    ; Clear CGRAM
    STZ $2121                    ; CGRAM address = $00
    REP #$20                     ; 16-bit accumulator
    LDA #$2002                   ; DMA: fixed source, write to CGRAM, 1 byte transfer
    STA $4300                    ; DMA parameters
    LDA #$0000                   ; Source address = $0000
    STA $4302
    STZ $4304                    ; Source bank = $00
    LDA #$0200                   ; Transfer size = 512 bytes
    STA $4305
    SEP #$20                     ; 8-bit accumulator
    LDA #$01                     ; Enable DMA channel 0
    STA $420B
    
    ; Clear OAM
    STZ $2102                    ; OAM address = $00
    STZ $2103                    ; OAM address high = $00
    REP #$20                     ; 16-bit accumulator
    LDA #$0402                   ; DMA: fixed source, write to OAM, 1 byte transfer
    STA $4300                    ; DMA parameters
    LDA #$0000                   ; Source address = $0000
    STA $4302
    STZ $4304                    ; Source bank = $00
    LDA #$0220                   ; Transfer size = 544 bytes
    STA $4305
    SEP #$20                     ; 8-bit accumulator
    LDA #$01                     ; Enable DMA channel 0
    STA $420B
    
    ; Load tiles, palette, and background
    JSR load_tiles
    JSR load_palette
    JSR load_background
    
    ; Enable screen
    LDA #$0F                     ; Screen on, brightness = 15
    STA $2100                    ; INIDISP
    LDA #$01                     ; Enable BG1
    STA $212C                    ; TM
    
    ; Enable NMI
    LDA #$81                     ; Enable NMI, auto-joypad read
    STA $4200                    ; NMITIMEN
    
    CLI                          ; Enable interrupts
    
    ; Enter main loop
main_loop:
    WAI                          ; Wait for interrupt
    JMP main_loop

; ============================================================================
; NMI Handler
; ============================================================================
nmi:
    PHA                          ; Save accumulator
    PHX                          ; Save X register
    PHY                          ; Save Y register
    
    ; Read $4210 to acknowledge NMI
    LDA $4210                    ; Read RDNMI (acknowledge NMI)
    
    ; Restore CPU registers
    PLY                          ; Restore Y register
    PLX                          ; Restore X register
    PLA                          ; Restore accumulator
    RTI                          ; Return from interrupt

; ============================================================================
; IRQ Handler
; ============================================================================
irq:
    RTI                          ; Return from interrupt

; ============================================================================
; Load Tiles
; ============================================================================
; Load tile graphics from ROM to VRAM using DMA
; Tiles are loaded to VRAM $1000 (BG1 tile base)
; ============================================================================
load_tiles:
    ; Set VRAM address increment mode
    LDA #$80                     ; Increment by 1 word
    STA $2115                    ; VMAIN
    
    ; Set VRAM address to $1000 (BG1 tile base)
    REP #$20                     ; 16-bit accumulator
    LDA #$1000                   ; VRAM address for tiles
    STA $2116                    ; VMADDL/VMADDH
    SEP #$20                     ; 8-bit accumulator
    
    ; Setup DMA to copy tiles from ROM to VRAM
    REP #$20                     ; 16-bit accumulator
    LDA #$1801                   ; DMA: increment source, write to VRAM, 1 word transfer
    STA $4300                    ; DMA parameters
    LDA #chr_data                ; Source address (tile data in ROM)
    STA $4302
    SEP #$20                     ; 8-bit accumulator
    LDA #^chr_data               ; Source bank
    STA $4304
    REP #$20                     ; 16-bit accumulator
    LDA #$2000                   ; Transfer size: 512 tiles × 16 bytes = 8192 bytes
    STA $4305
    SEP #$20                     ; 8-bit accumulator
    LDA #$01                     ; Enable DMA channel 0
    STA $420B
    
    RTS

; ============================================================================
; Load Palette
; ============================================================================
load_palette:
    STZ $2121                    ; CGADD = $00
    
    ; Write palette data (16 colors for BG1 subpalette 0)
    LDX #$00
palette_loop:
    LDA palette_data_low,X
    STA $2122                    ; CGDATA low byte
    LDA palette_data_high,X
    STA $2122                    ; CGDATA high byte
    INX
    CPX #$10                     ; 16 colors
    BNE palette_loop
    
    RTS

; ============================================================================
; Load Background
; ============================================================================
load_background:
    ; Set VRAM address increment mode
    LDA #$80                     ; Increment by 1 word
    STA $2115                    ; VMAIN
    
    ; Set VRAM address to BG1 tilemap ($0000)
    REP #$20                     ; 16-bit accumulator
    STZ $2116                    ; VMADDL/VMADDH = $0000
    SEP #$20                     ; 8-bit accumulator
    
    ; Clear tilemap (32x32 = 1024 tiles, 2 bytes per tile = 2048 bytes)
    REP #$30                     ; 16-bit accumulator and index registers
    LDA #$0000                   ; Empty tile
    LDX #$0000
clear_tilemap_loop:
    STA $2118                    ; VMDATAL (tile number and attributes)
    INX
    CPX #$0400                   ; 1024 tiles
    BNE clear_tilemap_loop
    SEP #$30                     ; 8-bit accumulator and index registers
    
    ; Write centered "WELCOME TO S-NES-BOY" text
    ; Text is 20 characters, screen is 32 tiles wide
    ; Center: (32 - 20) / 2 = 6 columns from left
    ; Vertical center: Row 14 (perfect visual center: 14 rows above, 15 rows below)
    ; Address = (14 * 32 + 7) * 2 = (448 + 7) * 2 = 910 = $038E
    REP #$20                     ; 16-bit accumulator
    LDA #$038E                   ; VRAM address
    STA $2116                    ; VMADDL/VMADDH
    SEP #$20                     ; 8-bit accumulator
    SEP #$10                     ; 8-bit index registers
    
    ; Write text
    LDA #<hello_text             ; Low byte
    STA text_ptr
    LDA #>hello_text             ; High byte
    STA text_ptr+1
    LDA #^hello_text             ; Bank byte
    STA text_ptr+2
    JSR write_text
    
    RTS

; ============================================================================
; Write Text String
; ============================================================================
write_text:
    LDY #$00
write_text_loop:
    LDA [text_ptr],Y             ; Load character
    BEQ write_text_done           ; Exit if null
    
    JSR char_to_tile              ; Convert character to tile index
    
    ; Write tile to VRAM
    STA $2118                    ; VMDATAL (tile number)
    STZ $2119                    ; VMDATAH (attributes = 0)
    INY
    CPY #$20                     ; Limit to 32 characters
    BCC write_text_loop
write_text_done:
    RTS

; ============================================================================
; Character to Tile Index Conversion
; ============================================================================
char_to_tile:
    CMP #$20
    BCC char_invalid             ; If < 32, invalid
    CMP #$7B
    BCS char_invalid             ; If >= 123, invalid
    
    SEC
    SBC #$20                     ; Convert to 0-90
    TAX                          ; Keep index in X
    LDA char_to_tile_table,X     ; Lookup tile index
    RTS

char_invalid:
    LDA #$00                     ; Tile 0 = space
    RTS

; ============================================================================
; Data Section
; ============================================================================

; Palette data (15-bit BGR format: 0BBBBBGG GGGRRRRR)
palette_data_low:
    .byte $00, $00, $00, $00     ; Color 0-3 low bytes
    .byte $00, $00, $00, $00     ; Color 4-7 low bytes
    .byte $00, $00, $00, $00     ; Color 8-11 low bytes
    .byte $00, $00, $00, $00     ; Color 12-15 low bytes
palette_data_high:
    .byte $00, $7F, $1F, $00     ; Color 0-3 high bytes
    .byte $00, $00, $00, $00     ; Color 4-7 high bytes
    .byte $00, $00, $00, $00     ; Color 8-11 high bytes
    .byte $00, $00, $00, $00     ; Color 12-15 high bytes

; Text string (null-terminated)
hello_text:
    .byte "WELCOME TO S-NES-BOY", 0

; Character to Tile Index Lookup Table
char_to_tile_table:
    .byte 0, 39, 0, 0, 0, 0, 0, 44, 0, 0, 0, 0, 0, 43, 38, 0  ; ASCII 32-47
    .byte 1, 2, 3, 4, 5, 6, 7, 8, 9, 10                    ; ASCII 48-57: '0'-'9'
    .byte 41, 42, 0, 0, 0, 40, 0                          ; ASCII 58-64
    .byte 11, 12, 13, 14, 15, 16, 17, 18, 19, 20          ; ASCII 65-74: 'A'-'J'
    .byte 21, 22, 23, 24, 25, 26, 27, 28, 29, 30          ; ASCII 75-84: 'K'-'T'
    .byte 31, 32, 33, 34, 35, 36                          ; ASCII 85-90: 'U'-'Z'
    .byte 0, 0, 0, 0, 0, 0, 0                              ; ASCII 91-96
    .byte 11, 12, 13, 14, 15, 16, 17, 18, 19, 20          ; ASCII 97-106: 'a'-'j'
    .byte 21, 22, 23, 24, 25, 26, 27, 28, 29, 30          ; ASCII 107-116: 'k'-'t'
    .byte 31, 32, 33, 34, 35, 36                          ; ASCII 117-122: 'u'-'z'

; ============================================================================
; CHR ROM Data
; ============================================================================
.segment "CHARS"
    .include "chars_data.asm"
