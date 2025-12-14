; ============================================================================
; Hello World SNES Program
; ============================================================================
; Displays text using complete alphabet/lexicon (A-Z, 0-9, punctuation)
; Follows SNES documentation best practices and hardware-accurate patterns
;
; Architecture:
;   - LoROM mapping (banks $00-$7F)
;   - Mode 0 (4 BGs, 4 colors per BG)
;   - 256x224 screen resolution (NTSC)
; ============================================================================


.segment "HEADER"
    .org $7FB0
    .byte "HELLO WORLD SNES   "  ; 21-byte title
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
    LDA #$01FF                   ; Stack pointer value
    TCS                          ; Stack pointer = $01FF
    
    ; Initialize direct page
    LDA #$0000                   ; Direct page value
    TCD                          ; Direct page = $0000
    SEP #$20                     ; 8-bit accumulator for PPU registers
    
    ; Force blank
    SEP #$20                     ; 8-bit accumulator
    LDA #$8F                     ; Force blank, brightness = 0
    STA $2100                    ; INIDISP
    
    ; Initialize PPU registers
    STZ $2101                    ; OBSEL
    STZ $2102                    ; OAMADDL
    STZ $2103                    ; OAMADDH
    ; BGMODE: Mode 0 = 4 backgrounds, 2bpp (4 colors per tile)
    ; Bits 0-2 = mode (0-7), bit 3 = BG3 priority, bit 4-6 = unused, bit 7 = mode 7 extbg
    STZ $2105                    ; BGMODE = Mode 0 (2bpp, 4 backgrounds)
    STZ $2106                    ; MOSAIC
    LDA #$00                     ; BG1SC: Screen base at $0000, 32x32 tiles, no wrapping
    STA $2107                    ; BG1SC
    STZ $2108                    ; BG2SC
    STZ $2109                    ; BG3SC
    STZ $210A                    ; BG4SC
    ; BG12NBA: Bits 0-3 = BG1 tile base (4KB units), Bits 4-7 = BG2 tile base (4KB units)
    ; BG1 tiles at VRAM $1000 = 4KB, so BG1 tile base = 1 (bits 0-3 = $01)
    ; BG2 tiles at VRAM $0000 = 0KB, so BG2 tile base = 0 (bits 4-7 = $00)
    LDA #$01                     ; BG12NBA: BG1 tiles at VRAM $1000 (bits 0-3 = 1), BG2 at $0000 (bits 4-7 = 0)
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
    ; Per SNES documentation: Must do this during VBlank
    ; Wait for VBlank before loading data
    LDA $4210                    ; Read RDNMI
vblank_wait_load:
    BIT $4210                    ; Check VBlank flag
    BPL vblank_wait_load
    
    JSR load_tiles
    JSR load_palette
    JSR load_background
    
    ; Wait for VBlank before enabling screen
    ; Per SNES documentation: Screen should be enabled during VBlank
    LDA $4210                    ; Read RDNMI
vblank_wait3:
    BIT $4210                    ; Check VBlank flag
    BPL vblank_wait3
    
    ; Enable screen
    ; Per SNES documentation: Enable during VBlank, set brightness to maximum
    ; INIDISP: bit 7 = force blank (0=normal, 1=blank), bits 0-3 = brightness (0-15)
    ; $0F = bit 7=0 (normal), bits 0-3=15 (maximum brightness)
    LDA #$0F                     ; Screen on (bit 7=0), brightness = 15 (bits 0-3)
    STA $2100                    ; INIDISP
    ; TM: Main Screen Designation - bit 0 = BG1, bit 1 = BG2, etc.
    LDA #$01                     ; Enable BG1 on main screen (bit 0=1)
    STA $212C                    ; TM (Main Screen Designation)
    ; TS: Sub Screen Designation (set to 0, we're not using sub screen)
    STZ $212D                    ; TS
    ; Ensure BG1 is enabled in the mode register
    ; BGMODE is already set to Mode 0 (2bpp) at initialization
    
    ; Enable NMI
    ; Per SNES documentation: Enable NMI for frame synchronization
    LDA #$81                     ; Enable NMI (bit 7=1), auto-joypad read (bit 0=1)
    STA $4200                    ; NMITIMEN
    
    CLI                          ; Enable interrupts (65816 native mode)
    
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
    ; Per SNES documentation: BG12NBA bit 0-3 = BG1 tile base in 4KB units
    ; $1000 = 4KB, so BG1 tile base = 1 (bits 0-3 of BG12NBA)
    ; VRAM address is 16-bit: bits 0-13 = address, bit 14 = high/low byte select
    REP #$20                     ; 16-bit accumulator
    LDA #$1000                   ; VRAM address for tiles ($1000 = 4096 bytes = 4KB)
    STA $2116                    ; VMADDL/VMADDH - set VRAM address
    SEP #$20                     ; 8-bit accumulator
    
    ; Setup DMA to copy tiles from ROM to VRAM
    ; Per SNES documentation: DMA Mode 1 = 1 word transfer, increment source
    REP #$20                     ; 16-bit accumulator
    LDA #$1801                   ; DMA Mode 1: increment source, write to VRAM ($2118), 1 word transfer
    STA $4300                    ; DMA parameters
    LDA #tile_data               ; Source address (tile data in PRG ROM)
    STA $4302                    ; $4302/$4303 = source address (16-bit)
    SEP #$20                     ; 8-bit accumulator
    LDA #^tile_data              ; Source bank
    STA $4304                    ; $4304 = source bank
    REP #$20                     ; 16-bit accumulator
    LDA #$2000                   ; Transfer size: 512 tiles × 16 bytes = 8192 bytes
    STA $4305                    ; $4305/$4306 = transfer size (16-bit)
    SEP #$20                     ; 8-bit accumulator
    LDA #$01                     ; Enable DMA channel 0
    STA $420B                    ; MDMAEN - start DMA
    
    ; Wait for DMA to complete
    ; Per SNES documentation: Poll MDMAEN register - bit clears when DMA completes
    ; Note: Cannot use WAI here because NMI isn't enabled yet during initialization
dma_wait_tiles:
    LDA $420B                    ; Read MDMAEN register
    AND #$01                     ; Check if channel 0 is still active
    BNE dma_wait_tiles           ; Wait until DMA completes (bit 0 clears)
    
    RTS

; ============================================================================
; Load Palette
; ============================================================================
load_palette:
    STZ $2121                    ; CGADD = $00
    
    ; Write palette data (16 colors for BG1 subpalette 0)
    ; SNES palette format: 15-bit BGR (0BBBBBGG GGGRRRRR)
    ; Write low byte first, then high byte
    LDX #$00
palette_loop:
    LDA palette_data_low,X
    STA $2122                    ; CGDATA low byte (GGGGGGRR)
    LDA palette_data_high,X
    STA $2122                    ; CGDATA high byte (0BBBBBG)
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
    ; Per SNES documentation: BG1SC bit 2-7 = screen base in 1KB units
    ; BG1SC = $00 means screen base at VRAM $0000, 32x32 tiles
    ; Note: Tiles are at VRAM $1000, tilemap is at VRAM $0000
    REP #$20                     ; 16-bit accumulator
    STZ $2116                    ; VMADDL/VMADDH = $0000 (tilemap base)
    SEP #$20                     ; 8-bit accumulator
    
    ; Clear tilemap (32x32 = 1024 tiles, 2 bytes per tile = 2048 bytes)
    ; Per SNES documentation: With VMAIN=$80, write low byte to $2118, high byte to $2119
    ; Each write auto-increments VRAM address by 2 bytes (1 word)
    ; Clear tilemap (32x32 = 1024 tiles, 2 bytes per tile = 2048 bytes)
    ; Per SNES documentation: With VMAIN=$80, write low byte to $2118, high byte to $2119
    ; Each write auto-increments VRAM address by 2 bytes (1 word)
    REP #$10                     ; 16-bit index registers
    LDX #$0400                   ; 1024 entries (32×32)
    SEP #$20                     ; 8-bit accumulator
    LDA #$00                     ; Empty tile low byte (tile 0)
clear_tilemap_loop:
    STA $2118                    ; VMDATAL - write low byte (tile number bits 0-7)
    STZ $2119                    ; VMDATAH - write high byte (tile number bits 8-9 + attributes, all 0)
    DEX
    BNE clear_tilemap_loop
    SEP #$30                     ; 8-bit accumulator and index registers
    
    ; Display layout matching NES hello-world 1:1:
    ; Row 5: "HELLO WORLD!" (at column 5, matching NES)
    ; Row 7: Alphabet A-Z (each character individually, matching NES)
    ; Row 8: Numbers 0-9 (each character individually, matching NES)
    ; Row 9: Punctuation (each character individually, matching NES)
    ; Row 10: "HELLO WORLD!" (above lexicon)
    ; Row 11: Complete lexicon (numbers + letters) - each character individually
    
    ; Write "HELLO WORLD!" at row 5, column 5 (matching NES layout)
    ; Per SNES documentation: Tilemap address = (row * 32 + column) * 2
    ; Address = (5 * 32 + 5) * 2 = 330 = $014A
    ; Ensure VMAIN is set correctly before writing
    LDA #$80                     ; Increment by 1 word
    STA $2115                    ; VMAIN
    REP #$20                     ; 16-bit accumulator
    LDA #$014A                   ; VRAM address for tilemap
    STA $2116                    ; VMADDL/VMADDH
    SEP #$20                     ; 8-bit accumulator
    LDA #<hello_text
    STA text_ptr
    LDA #>hello_text
    STA text_ptr+1
    LDA #^hello_text
    STA text_ptr+2
    JSR write_text
    
    ; Write alphabet A-Z at row 7, column 0 (matching NES layout)
    ; Each character displayed individually
    ; Address = (7 * 32 + 0) * 2 = 448 = $01C0
    LDA #$80                     ; Increment by 1 word
    STA $2115                    ; VMAIN
    REP #$20                     ; 16-bit accumulator
    LDA #$01C0                   ; VRAM address
    STA $2116                    ; VMADDL/VMADDH
    SEP #$20                     ; 8-bit accumulator
    LDA #<alphabet_text
    STA text_ptr
    LDA #>alphabet_text
    STA text_ptr+1
    LDA #^alphabet_text
    STA text_ptr+2
    JSR write_text
    
    ; Write numbers 0-9 at row 8, column 0 (matching NES layout)
    ; Each character displayed individually
    ; Address = (8 * 32 + 0) * 2 = 512 = $0200
    LDA #$80                     ; Increment by 1 word
    STA $2115                    ; VMAIN
    REP #$20                     ; 16-bit accumulator
    LDA #$0200                   ; VRAM address
    STA $2116                    ; VMADDL/VMADDH
    SEP #$20                     ; 8-bit accumulator
    LDA #<numbers_text
    STA text_ptr
    LDA #>numbers_text
    STA text_ptr+1
    LDA #^numbers_text
    STA text_ptr+2
    JSR write_text
    
    ; Write punctuation at row 9, column 0 (matching NES layout)
    ; Each character displayed individually
    ; Address = (9 * 32 + 0) * 2 = 576 = $0240
    LDA #$80                     ; Increment by 1 word
    STA $2115                    ; VMAIN
    REP #$20                     ; 16-bit accumulator
    LDA #$0240                   ; VRAM address
    STA $2116                    ; VMADDL/VMADDH
    SEP #$20                     ; 8-bit accumulator
    LDA #<punctuation_text
    STA text_ptr
    LDA #>punctuation_text
    STA text_ptr+1
    LDA #^punctuation_text
    STA text_ptr+2
    JSR write_text
    
    ; Write "HELLO WORLD!" at row 10, column 0 (above lexicon)
    ; Address = (10 * 32 + 0) * 2 = 640 = $0280
    LDA #$80                     ; Increment by 1 word
    STA $2115                    ; VMAIN
    REP #$20                     ; 16-bit accumulator
    LDA #$0280                   ; VRAM address
    STA $2116                    ; VMADDL/VMADDH
    SEP #$20                     ; 8-bit accumulator
    LDA #<hello_text
    STA text_ptr
    LDA #>hello_text
    STA text_ptr+1
    LDA #^hello_text
    STA text_ptr+2
    JSR write_text
    
    ; Write complete lexicon (numbers + letters) at row 11, column 0
    ; This displays all characters from numbers_letters_text individually
    ; Address = (11 * 32 + 0) * 2 = 704 = $02C0
    LDA #$80                     ; Increment by 1 word
    STA $2115                    ; VMAIN
    REP #$20                     ; 16-bit accumulator
    LDA #$02C0                   ; VRAM address
    STA $2116                    ; VMADDL/VMADDH
    SEP #$20                     ; 8-bit accumulator
    LDA #<numbers_letters_text
    STA text_ptr
    LDA #>numbers_letters_text
    STA text_ptr+1
    LDA #^numbers_letters_text
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
    
    JSR char_to_tile              ; Convert character to tile index (returns in A, 0-511)
    
    ; Write tile to VRAM tilemap
    ; Per SNES documentation: Tilemap entry is 16-bit word
    ; Format: VVVH PPCC CCTTTT TTTTTT (bits 15-0, little-endian in VRAM)
    ;   Bits 0-9:   Tile number (0-1023)
    ;   Bit 10:     Horizontal flip (0 = normal)
    ;   Bit 11:     Vertical flip (0 = normal)
    ;   Bits 12-14: Palette (0-7)
    ;   Bit 15:     Priority (0 = behind sprites)
    ; Tiles are at VRAM $1000, each 2bpp tile is 16 bytes
    ; Tile number = VRAM address / 16 = $1000 / 16 = $100 = 256
    ; So we add $100 to our tile index to reference correct tile
    ; Calculate tile number: tile index (0-511) + 256 = tile number (256-767)
    PHA                          ; Save tile index (0-511) in A
    REP #$20                     ; 16-bit accumulator
    PLA                          ; Get tile index (now 16-bit, high byte is 0)
    AND #$00FF                   ; Clear high byte (tile index 0-511)
    CLC
    ADC #$0100                   ; Add $100 offset (tiles at VRAM $1000)
    ; Now A = tile number (256-767) as 16-bit value
    ; For example: tile index 11 (letter 'A') + 256 = 267 = $010B
    ; Low byte = $0B (bits 0-7)
    ; High byte = $01 (bits 8-15), but only bits 8-9 ($01 & $03 = $01) are tile number
    ; Write to VRAM: low byte to $2118, high byte to $2119
    ; VMAIN is $80 (increment by 1 word), so writing both bytes auto-increments
    SEP #$20                     ; 8-bit accumulator
    XBA                          ; Exchange: high byte now in A, low byte in B accumulator
    PHA                          ; Save high byte
    XBA                          ; Get low byte back in A
    STA $2118                    ; VMDATAL - write tile number low byte (bits 0-7)
    PLA                          ; Get high byte
    ; High byte contains bits 8-15 of tile number, but only bits 8-9 are used for tile number
    ; Bits 10-15 are attributes (all 0 in our case: no flip, palette 0, priority 0)
    ; Since tile number is 256-767, high byte is $01-$02, which already has correct format
    ; No masking needed - the high byte value is correct as-is
    STA $2119                    ; VMDATAH - write tile number high bits + attributes
    INY
    CPY #$40                     ; Limit to 64 characters (allows longer strings)
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
; Per SNES documentation: 15-bit color format
; Format: Low byte = GGGGGGRR (bits 0-7), High byte = 0BBBBBG (bits 8-14)
; Color 0 = transparent/black (BGR $0000 = R0 G0 B0)
; Color 1 = white (BGR $7FFF = R31 G31 B31)
; Color 2 = light gray (BGR $4210 = R16 G16 B16) 
; Color 3 = black (BGR $0000 = R0 G0 B0)
palette_data_low:
    .byte $00, $FF, $10, $00     ; Color 0-3 low bytes
    ; Color 0: $00 = G0 R0 (black/transparent)
    ; Color 1: $FF = G31 R31 (white)
    ; Color 2: $10 = G16 R16 (light gray)
    ; Color 3: $00 = G0 R0 (black)
    .byte $00, $00, $00, $00     ; Color 4-7 low bytes
    .byte $00, $00, $00, $00     ; Color 8-11 low bytes
    .byte $00, $00, $00, $00     ; Color 12-15 low bytes
palette_data_high:
    .byte $00, $7F, $42, $00     ; Color 0-3 high bytes
    ; Color 0: $00 = B0 G0 (black/transparent)
    ; Color 1: $7F = B31 G31 (white)
    ; Color 2: $42 = B16 G16 (light gray)
    ; Color 3: $00 = B0 G0 (black)
    .byte $00, $00, $00, $00     ; Color 4-7 high bytes
    .byte $00, $00, $00, $00     ; Color 8-11 high bytes
    .byte $00, $00, $00, $00     ; Color 12-15 high bytes

; Text strings (null-terminated)
; Matching NES hello-world layout
hello_text:
    .byte "HELLO WORLD!", 0

alphabet_text:
    .byte "ABCDEFGHIJKLMNOPQRSTUVWXYZ", 0

numbers_text:
    .byte "0123456789", 0

punctuation_text:
    .byte ".,!?:;-'", 0

numbers_letters_text:
    .byte "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ", 0

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
; Tile Data (in CODE segment for DMA access)
; ============================================================================
; Note: Tile data must be in CODE segment (PRG ROM) for CPU/DMA access
; CHR ROM is PPU-only and not accessible for DMA transfers
; The tile_data label is defined in chars_data.asm
    .include "chars_data.asm"
