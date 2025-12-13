; ============================================================================
; Hello World NES Program
; ============================================================================
; Displays text using complete alphabet/lexicon (A-Z, 0-9, punctuation)
; Follows NES documentation best practices and hardware-accurate patterns
;
; Architecture:
;   - 16 KB PRG ROM (Mapper 0, NROM)
;   - 8 KB CHR ROM (512 tiles)
;   - Name table rendering with text system
; ============================================================================

.segment "HEADER"
    .byte "NES", $1A    ; iNES header identifier
    .byte 1             ; 16 KB PRG ROM (1 * 16 KB)
    .byte 1             ; 8 KB CHR ROM (1 * 8 KB)
    .byte %00000000     ; Mapper 0, horizontal mirroring, no battery
    .byte %00000000     ; Mapper 0 (high), NES format
    .byte 0             ; PRG RAM size
    .byte 0             ; NTSC
    .byte 0, 0, 0, 0, 0, 0  ; Unused

.segment "VECTORS"
    .addr nmi, reset, irq

.segment "CODE"

; ============================================================================
; Zero Page Variables
; ============================================================================
; Per NES documentation: Zero page ($0000-$00FF) for frequently accessed data
; Zero page access is faster (3 cycles vs 4 cycles for absolute addressing)
; ============================================================================
zp_temp = $00           ; Temporary variable
text_ptr = $02          ; 16-bit pointer for text data (low byte at $02, high byte at $03)

; ============================================================================
; Reset Handler
; ============================================================================
; Per NES documentation: Initialize system, clear RAM, setup PPU
; Must follow exact sequence for hardware compatibility
; ============================================================================
reset:
    ; Disable interrupts and initialize CPU
    SEI                 ; Disable interrupts (per NES documentation: required first)
    CLD                 ; Clear decimal mode (6502 specific: NES doesn't use BCD)
    LDX #$FF
    TXS                 ; Initialize stack pointer to $01FF
    INX                 ; X = 0 (for clearing RAM)
    
    ; Disable PPU rendering
    ; Per NES documentation: Must disable before VRAM access to prevent corruption
    STX $2000           ; Disable NMI (PPUCTRL = 0)
    STX $2001           ; Disable rendering (PPUMASK = 0)
    STX $4010           ; Disable DMC IRQ
    
    ; Wait for PPU to stabilize
    ; Per NES documentation: Wait 2 VBlanks to ensure PPU is ready
    BIT $2002           ; Clear VBlank flag
vblank_wait1:
    BIT $2002
    BPL vblank_wait1    ; Wait for VBlank flag to be set (bit 7)
    
    ; Clear RAM
    ; Per NES documentation: Initialize all RAM to known state ($0000-$07FF)
    LDA #0
clear_ram:
    STA $0000,X         ; Zero page
    STA $0100,X         ; Stack
    STA $0200,X         ; OAM buffer
    STA $0300,X         ; RAM
    STA $0400,X         ; RAM
    STA $0500,X         ; RAM
    STA $0600,X         ; RAM
    STA $0700,X         ; RAM
    INX
    BNE clear_ram       ; Loop until X wraps to 0 (256 iterations)
    
    ; Wait for second VBlank
    ; Per NES documentation: Ensures PPU is fully stabilized
vblank_wait2:
    BIT $2002
    BPL vblank_wait2
    
    ; Load palette and background BEFORE enabling rendering
    ; Per NES documentation: VRAM writes must happen during VBlank or forced blanking
    JSR load_palette
    JSR load_background
    
    ; Wait for VBlank before enabling rendering
    ; Per NES documentation: Ensures first frame renders correctly
vblank_wait3:
    BIT $2002
    BPL vblank_wait3
    
    ; Set scroll registers
    ; Per NES documentation: Must be set before enabling rendering
    LDA $2002           ; Reset scroll latch (read $2002)
    LDA #0
    STA $2005           ; X scroll = 0
    STA $2005           ; Y scroll = 0
    
    ; Enable rendering
    ; Per NES documentation: Enable during VBlank
    ; PPUCTRL ($2000): Bit 7=1 (NMI enable), Bit 3=0 (pattern table $0000 for background)
    ;                   Bit 0-1=00 (name table $2000), Bit 2=0 (increment by 1)
    LDA #%10000000      ; Enable NMI, pattern table 0, name table 0, increment by 1
    STA $2000
    ; PPUMASK ($2001): Bit 3=1 (show background), Bit 4=1 (show sprites)
    ;                   Bit 1=1 (show background in left 8px), Bit 0=0 (no grayscale)
    LDA #%00011110      ; Enable background and sprites, show left 8px
    STA $2001
    
    ; Enter main loop
    ; Per NES documentation: Simple loop, all work done in NMI
main_loop:
    JMP main_loop

; ============================================================================
; NMI Handler
; ============================================================================
; Per NES documentation: Called every frame during VBlank (60 Hz NTSC)
; Must complete quickly (< ~2000 cycles) to avoid frame drops
; ============================================================================
nmi:
    ; Save CPU registers
    ; Per NES documentation: NMI can interrupt main loop, must preserve state
    PHA                 ; Save accumulator
    TXA
    PHA                 ; Save X register
    TYA
    PHA                 ; Save Y register
    
    ; Read $2002 to clear VBlank flag
    ; Per NES documentation: Required! Reading $2002 clears bit 7
    LDA $2002
    
    ; Update scroll registers
    ; Per NES documentation: Must be written twice per frame to maintain position
    ; First write = X scroll, second write = Y scroll
    LDA #0
    STA $2005           ; X scroll = 0
    STA $2005           ; Y scroll = 0
    
    ; Update PPU control register
    ; Per NES documentation: Must be done every frame
    LDA #%10000000      ; Enable NMI, pattern table 0, name table 0
    STA $2000
    
    ; Restore CPU registers
    PLA                 ; Restore Y register
    TAY
    PLA                 ; Restore X register
    TAX
    PLA                 ; Restore accumulator
    RTI                 ; Return from interrupt

; ============================================================================
; IRQ Handler
; ============================================================================
; Per NES documentation: IRQ is rarely used on NES, but handler is required
; ============================================================================
irq:
    RTI                 ; Return from interrupt (no-op for this program)

; ============================================================================
; Load Palette
; ============================================================================
; Per NES documentation: Palettes are at $3F00-$3F1F (32 bytes)
; Must write during VBlank or forced blanking
; ============================================================================
load_palette:
    ; Reset PPU address latch
    ; Per NES documentation: Read $2002 first to reset latch
    LDA $2002
    LDA #$3F            ; Palette RAM high byte
    STA $2006           ; Write high byte first
    LDA #$00            ; Palette RAM low byte
    STA $2006           ; Write low byte second - address is now $3F00
    
    ; Write all 32 palette bytes
    ; Per NES documentation: 8 palettes × 4 colors = 32 bytes
    LDX #0
palette_loop:
    LDA palette_data,X
    STA $2007           ; Write palette byte, auto-increments address
    INX
    CPX #32             ; 32 palette bytes total
    BNE palette_loop
    
    ; Set universal background color
    ; Per NES documentation: $3F00 affects all backgrounds (mirrors to $3F10, $3F20, $3F30)
    LDA $2002           ; Reset latch
    LDA #$3F
    STA $2006
    LDA #$00
    STA $2006
    LDA #$0F            ; Universal background = black ($0F)
    STA $2007
    
    RTS

; ============================================================================
; Load Background
; ============================================================================
; Per NES documentation: Name table is 32×30 tiles (960 bytes) + 64 bytes attribute
; Name table: $2000-$23BF (960 bytes)
; Attribute table: $23C0-$23FF (64 bytes)
; ============================================================================
load_background:
    ; Clear name table (fill with tile 0 = space)
    ; Per NES documentation: $2006 write sequence is high byte, then low byte
    LDA $2002           ; Reset PPU address latch (MUST read first)
    LDA #$20            ; Name table 0 high byte
    STA $2006           ; Write high byte first
    LDA #$00            ; Name table 0 low byte
    STA $2006           ; Write low byte second - address is now $2000
    
    ; Fill name table with tile 0 (960 bytes)
    ; Per NES documentation: Name table is 32×30 = 960 bytes
    LDX #0
    LDY #0
clear_name_table:
    LDA #0              ; Tile 0 (space)
    STA $2007           ; Write tile, auto-increments address
    INX
    BNE clear_name_table ; Loop 256 times (X wraps to 0)
    INY
    CPY #4              ; 4 iterations of 256 = 1024 bytes
    BNE clear_name_table
    ; After 960 bytes, PPU address is at $23C0 (attribute table start)
    ; After 1024 bytes, PPU address is at $2400 (next name table)
    ; This clears both name table (960 bytes) and attribute table (64 bytes)
    
    ; Clear attribute table explicitly (ensure all bytes are 0 = palette 0)
    ; Per NES documentation: Attribute table at $23C0-$23FF (64 bytes)
    LDA $2002           ; Reset latch
    LDA #$23            ; Attribute table high byte
    STA $2006
    LDA #$C0            ; Attribute table low byte
    STA $2006           ; Address is now $23C0
    
    LDX #0
clear_attribute_table:
    LDA #0              ; Attribute 0 = palette 0 for all 4 attribute groups
    STA $2007           ; Write attribute byte, auto-increments address
    INX
    CPX #64             ; 64 attribute bytes total
    BNE clear_attribute_table
    
    ; Write text to name table
    ; Per NES documentation: Must reset latch after previous operations
    
    ; Write "HELLO WORLD!" at row 5, column 5
    ; Address = $2000 + (row * 32) + column = $2000 + (5 * 32) + 5 = $20A5
    LDA $2002           ; Reset latch
    LDA #$20            ; High byte of $20A5
    STA $2006           ; Write high byte first
    LDA #$A5            ; Low byte of $20A5
    STA $2006           ; Write low byte second - address is now $20A5
    
    ; Write text using text rendering function
    LDA #<hello_text    ; Low byte of text address
    STA text_ptr
    LDA #>hello_text    ; High byte of text address
    STA text_ptr+1
    JSR write_text      ; Write text string
    
    ; Write alphabet demonstration at row 7, column 0
    ; Address = $2000 + (7 * 32) + 0 = $20E0
    LDA $2002           ; Reset latch
    LDA #$20            ; High byte of $20E0
    STA $2006
    LDA #$E0            ; Low byte of $20E0
    STA $2006
    
    LDA #<alphabet_text
    STA text_ptr
    LDA #>alphabet_text
    STA text_ptr+1
    JSR write_text
    
    ; Write numbers demonstration at row 8, column 0
    ; Address = $2000 + (8 * 32) + 0 = $2100
    LDA $2002           ; Reset latch
    LDA #$21            ; High byte of $2100
    STA $2006
    LDA #$00            ; Low byte of $2100
    STA $2006
    
    LDA #<numbers_text
    STA text_ptr
    LDA #>numbers_text
    STA text_ptr+1
    JSR write_text
    
    ; Write punctuation demonstration at row 9, column 0
    ; Address = $2000 + (9 * 32) + 0 = $2120
    LDA $2002           ; Reset latch
    LDA #$21            ; High byte of $2120
    STA $2006
    LDA #$20            ; Low byte of $2120
    STA $2006
    
    LDA #<punctuation_text
    STA text_ptr
    LDA #>punctuation_text
    STA text_ptr+1
    JSR write_text
    
    RTS

; ============================================================================
; Write Text String
; ============================================================================
; Writes a null-terminated string to name table at current PPU address
; Input: text_ptr points to string (null-terminated)
; Per NES documentation: Writes to $2007 go directly to PPU, no buffering
; ============================================================================
write_text:
    LDY #0              ; Index into string
write_text_loop:
    LDA (text_ptr),Y    ; Load character from string (indirect indexed addressing)
    BEQ write_text_done ; If null terminator (0), done
    
    ; Convert ASCII character to tile index using lookup function
    JSR char_to_tile    ; Convert character to tile index (result in A)
    STA $2007           ; Write tile index to name table, auto-increments address
    INY                 ; Next character
    CPY #32             ; Limit to 32 characters per line (name table width)
    BCS write_text_done ; If >= 32, stop (prevent wrapping to next line)
    JMP write_text_loop ; Continue
write_text_done:
    RTS

; ============================================================================
; Character to Tile Index Conversion
; ============================================================================
; Converts ASCII character to tile index using lookup logic
; Input: A = ASCII character
; Output: A = tile index
; Per NES documentation: Lookup tables in ROM for efficient conversion
; ============================================================================
char_to_tile:
    ; Check character type and convert to tile index
    ; Order: numbers first (most common), then letters, then punctuation
    
    ; Check if number: '0'-'9' (ASCII 48-57)
    CMP #'0'
    BCC char_check_letter ; If < '0', check letter
    CMP #'9'+1
    BCS char_check_letter ; If >= '9'+1, check letter
    ; Number: '0' (48) -> tile 1, '1' (49) -> tile 2, etc.
    SEC
    SBC #'0'            ; Convert to 0-9
    CLC
    ADC #1              ; Add base tile index for numbers (tile 1 = '0')
    RTS

char_check_letter:
    ; Check if uppercase letter: 'A'-'Z' (ASCII 65-90)
    CMP #'A'
    BCC char_check_lower ; If < 'A', check lowercase
    CMP #'Z'+1
    BCS char_check_lower ; If >= 'Z'+1, check lowercase
    ; Uppercase letter: 'A' (65) -> tile 11, 'B' (66) -> tile 12, etc.
    SEC
    SBC #'A'            ; Convert to 0-25
    CLC
    ADC #11             ; Add base tile index for letters (tile 11 = 'A')
    RTS

char_check_lower:
    ; Check if lowercase letter: 'a'-'z' (ASCII 97-122)
    CMP #'a'
    BCC char_check_punct ; If < 'a', check punctuation
    CMP #'z'+1
    BCS char_check_punct ; If >= 'z'+1, check punctuation
    ; Lowercase letter: convert to uppercase
    SEC
    SBC #('a' - 'A')    ; Convert 'a' to 'A', etc. (subtract 32)
    JMP char_to_tile    ; Recursively convert uppercase

char_check_punct:
    ; Check punctuation characters
    CMP #'.'
    BEQ char_period
    CMP #','
    BEQ char_comma
    CMP #'!'
    BEQ char_exclaim
    CMP #'?'
    BEQ char_question
    CMP #':'
    BEQ char_colon
    CMP #';'
    BEQ char_semicolon
    CMP #'-'
    BEQ char_dash
    CMP #$27            ; Apostrophe (ASCII 39 = $27)
    BEQ char_quote
    ; Default to space if unknown character
char_invalid:
    LDA #0              ; Tile 0 = space
    RTS

char_period:
    LDA #37              ; Tile 37 = period
    RTS
char_comma:
    LDA #38              ; Tile 38 = comma
    RTS
char_exclaim:
    LDA #39              ; Tile 39 = exclamation
    RTS
char_question:
    LDA #40              ; Tile 40 = question mark
    RTS
char_colon:
    LDA #41              ; Tile 41 = colon
    RTS
char_semicolon:
    LDA #42              ; Tile 42 = semicolon
    RTS
char_dash:
    LDA #43              ; Tile 43 = dash
    RTS
char_quote:
    LDA #44              ; Tile 44 = apostrophe
    RTS

; ============================================================================
; Data Section
; ============================================================================
; Per NES documentation: Constants and data in ROM
; ============================================================================

; Palette data
; Per NES documentation: 32 bytes, 8 palettes × 4 colors
; Format: Background color, Color 1, Color 2, Color 3
palette_data:
    .byte $0F, $30, $10, $00  ; Background palette 0: bg=$0F(black), c1=$30(white), c2=$10(grey), c3=$00(black)
    .byte $0F, $30, $10, $00  ; Background palette 1
    .byte $0F, $30, $10, $00  ; Background palette 2
    .byte $0F, $30, $10, $00  ; Background palette 3
    .byte $0F, $16, $27, $18  ; Sprite palette 0
    .byte $0F, $16, $27, $18  ; Sprite palette 1
    .byte $0F, $16, $27, $18  ; Sprite palette 2
    .byte $0F, $16, $27, $18  ; Sprite palette 3

; Text strings (null-terminated)
hello_text:
    .byte "HELLO WORLD!", 0

alphabet_text:
    .byte "ABCDEFGHIJKLMNOPQRSTUVWXYZ", 0

numbers_text:
    .byte "0123456789", 0

punctuation_text:
    .byte ".,!?:;-'", 0

; ============================================================================
; CHR ROM Data
; ============================================================================
; Per NES documentation: Pattern table data, 8 KB (512 tiles × 16 bytes)
; Each tile is 16 bytes: 8 bytes bitplane 0, 8 bytes bitplane 1
; ============================================================================
.segment "CHARS"
    .include "chars_data.s"
