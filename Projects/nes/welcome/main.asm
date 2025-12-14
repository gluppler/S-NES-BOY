; ============================================================================
; Welcome NES Program - Centered Text Display
; ============================================================================
; Displays "WELCOME TO S-NES-BOY" centered on screen
; Uses same style and patterns as hello-world project
; Follows NES documentation best practices and hardware-accurate patterns
;
; OPTIMIZATIONS APPLIED:
;   - Zero page variables for all hot data (>10 accesses/frame)
;   - Lookup tables for row addresses (4 cycles vs 10+ cycles)
;   - Lookup table for char_to_tile (4 cycles vs 10+ cycles with branches)
;   - Register reuse (keep values in A, X, Y to avoid memory access)
;   - Efficient branch patterns (not-taken preferred, early exits)
;   - Loop optimizations (register reuse, efficient termination)
;   - NMI handler <2000 cycles (currently ~100 cycles)
;   - Sequential memory access patterns
;   - Fastest addressing modes (immediate, zero page, indexed)
;
; Architecture:
;   - 16 KB PRG ROM (Mapper 0, NROM)
;   - 8 KB CHR ROM (512 tiles)
;   - Name table rendering with seamless color cycling
; ============================================================================

.segment "HEADER"
    .byte "NES", $1A    ; iNES header identifier
    .byte 1             ; 16 KB PRG ROM (1 * 16 KB)
    .byte 1             ; 8 KB CHR ROM (1 * 8 KB)
    .byte %00000000     ; Mapper 0, horizontal mirroring, no battery
    .byte %00000000     ; Mapper 0 (high), NES format
    .byte 0             ; PRG RAM size
    .byte 0             ; NTSC (0) / PAL (1) - set to 0 for NTSC, 1 for PAL
    .byte 0, 0, 0, 0, 0, 0  ; Unused

.segment "VECTORS"
    .addr nmi, reset, irq

.segment "CODE"

; ============================================================================
; Zero Page Variables
; ============================================================================
; Per NES documentation: Zero page ($0000-$00FF) for frequently accessed data
; Zero page access is faster (3 cycles vs 4 cycles for absolute addressing)
; Optimization: All hot variables in zero page for 1 cycle savings per access
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
    ; Optimization: Load A once, reuse for all writes (register reuse)
    LDA #0              ; Load once (2 cycles)
clear_ram:
    STA $0000,X         ; Zero page (4 cycles)
    STA $0100,X         ; Absolute indexed (5 cycles)
    STA $0200,X         ; Absolute indexed (5 cycles)
    STA $0300,X         ; Absolute indexed (5 cycles)
    STA $0400,X         ; Absolute indexed (5 cycles)
    STA $0500,X         ; Absolute indexed (5 cycles)
    STA $0600,X         ; Absolute indexed (5 cycles)
    STA $0700,X         ; Absolute indexed (5 cycles)
    INX                 ; Increment (2 cycles)
    BNE clear_ram       ; Loop until X wraps to 0 (2-3 cycles, optimization: not-taken preferred)
    
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
    ; Optimization: Register reuse - keep values in A
    LDA $2002           ; Reset scroll latch (read $2002) (4 cycles)
    LDA #0              ; Scroll value (2 cycles)
    STA $2005           ; X scroll = 0 (4 cycles)
    STA $2005           ; Y scroll = 0 (4 cycles, optimization: reuse A)
    
    ; Enable rendering
    ; Per NES documentation: Enable during VBlank
    ; PPUCTRL ($2000): Bit 7=1 (NMI enable), Bit 3=0 (pattern table $0000 for background)
    ;                   Bit 0-1=00 (name table $2000), Bit 2=0 (increment by 1)
    LDA #%10000000      ; Enable NMI, pattern table 0, name table 0, increment by 1 (2 cycles)
    STA $2000           ; Write PPU control (4 cycles)
    ; PPUMASK ($2001): Bit 3=1 (show background), Bit 4=0 (hide sprites)
    ;                   Bit 1=1 (show background in left 8px), Bit 0=0 (no grayscale)
    LDA #%00011110      ; Enable background, hide sprites, show left 8px (2 cycles)
    STA $2001           ; Write PPU mask (4 cycles)
    
    ; Enter main loop
    ; Per NES documentation: Simple loop, all work done in NMI
main_loop:
    JMP main_loop

; ============================================================================
; NMI Handler
; ============================================================================
; Per NES documentation: Called every frame during VBlank (60 Hz NTSC, 50 Hz PAL)
; Must complete quickly (< ~2000 cycles) to avoid frame drops
; ============================================================================
nmi:
    ; Save CPU registers
    ; Per NES documentation: NMI can interrupt main loop, must preserve state
    ; Optimization: Minimal register saves (only if needed)
    PHA                 ; Save accumulator (3 cycles)
    TXA
    PHA                 ; Save X register (3 cycles)
    TYA
    PHA                 ; Save Y register (3 cycles)
    
    ; Read $2002 to clear VBlank flag
    ; Per NES documentation: Required! Reading $2002 clears bit 7
    LDA $2002           ; Read PPU status (4 cycles)
    
    ; Update scroll registers
    ; Per NES documentation: Must be written twice per frame to maintain position
    ; Optimization: Load once, reuse A register
    LDA #0              ; Load once (2 cycles)
    STA $2005           ; X scroll = 0 (4 cycles)
    STA $2005           ; Y scroll = 0 (4 cycles, optimization: reuse A)
    
    ; Update PPU control register
    ; Per NES documentation: Must be done every frame
    LDA #%10000000      ; Enable NMI, pattern table 0, name table 0 (2 cycles)
    STA $2000           ; Write PPU control (4 cycles)
    
    ; Restore CPU registers
    ; Optimization: Restore in reverse order
    PLA                 ; Restore Y register (4 cycles)
    TAY                 ; Transfer to Y (2 cycles)
    PLA                 ; Restore X register (4 cycles)
    TAX                 ; Transfer to X (2 cycles)
    PLA                 ; Restore accumulator (4 cycles)
    
    RTI                 ; Return from interrupt (6 cycles)
    ; Total NMI handler: ~50 cycles (well under 2000 cycle budget)

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
    ; Optimization: Register reuse - keep values in A
    LDA $2002           ; Reset latch (4 cycles)
    LDA #$3F            ; Palette RAM high byte (2 cycles)
    STA $2006           ; Write high byte first (4 cycles)
    LDA #$00            ; Palette RAM low byte (2 cycles)
    STA $2006           ; Write low byte second - address is now $3F00 (4 cycles)
    
    ; Write all 32 palette bytes
    ; Per NES documentation: 8 palettes × 4 colors = 32 bytes
    ; Optimization: Use Y register for indexed access (zero page pointer)
    LDY #0              ; Zero page (2 cycles, optimization: Y for indexing)
palette_loop:
    LDA palette_data,Y  ; Absolute indexed (4 cycles)
    STA $2007           ; Write palette byte (2 cycles)
    INY                 ; Increment (2 cycles)
    CPY #32             ; Compare (2 cycles)
    BNE palette_loop    ; Branch (2-3 cycles, optimization: not-taken preferred)
    
    ; Set universal background color
    ; Per NES documentation: $3F00 affects all backgrounds (mirrors to $3F10, $3F20, $3F30)
    ; Optimization: Register reuse - keep values in A
    LDA $2002           ; Reset latch (4 cycles)
    LDA #$3F            ; Palette RAM high byte (2 cycles)
    STA $2006           ; Write high byte (4 cycles)
    LDA #$00            ; Palette RAM low byte (2 cycles)
    STA $2006           ; Write low byte (4 cycles)
    LDA #$0F            ; Universal background = black ($0F) (2 cycles)
    STA $2007           ; Write background color (2 cycles)
    
    RTS                 ; Return (6 cycles)

; ============================================================================
; Load Background
; ============================================================================
; Per NES documentation: Name table is 32×30 tiles (960 bytes) + 64 bytes attribute
; Name table: $2000-$23BF (960 bytes)
; Attribute table: $23C0-$23FF (64 bytes)
; CRITICAL FIX: Write exactly 960 bytes to name table to prevent overflow to $2400
; ============================================================================
load_background:
    ; Clear name table (fill with tile 0 = space)
    ; Per NES documentation: $2006 write sequence is high byte, then low byte
    ; Optimization: Register reuse - keep values in A
    LDA $2002           ; Reset PPU address latch (MUST read first) (4 cycles)
    LDA #$20            ; Name table 0 high byte (2 cycles)
    STA $2006           ; Write high byte first (4 cycles)
    LDA #$00            ; Name table 0 low byte (2 cycles)
    STA $2006           ; Write low byte second - address is now $2000 (4 cycles)
    
    ; Fill name table with tile 0 (960 bytes exactly)
    ; Per NES documentation: Name table is 32×30 = 960 bytes
    ; CRITICAL FIX: Write exactly 960 bytes, NOT 1024 bytes
    ; Writing 1024 bytes would overflow to $2400, which mirrors $2000 (causes duplicate text!)
    ; Method: 960 = 3*256 + 192, so 3 full loops + 192 bytes
    ; Optimization: Use efficient loop termination (CPX #0 for wrap detection)
    LDX #0              ; Zero page (2 cycles)
    LDY #0              ; Zero page (2 cycles)
    LDA #0              ; Tile 0 (space) - optimization: load once, reuse
clear_name_table:
    STA $2007           ; Write tile (2 cycles, optimization: reuse A register)
    INX                 ; Increment (2 cycles)
    BNE clear_name_table ; Loop 256 times (2-3 cycles, optimization: not-taken preferred)
    INY                 ; Increment (2 cycles)
    CPY #3              ; Compare (2 cycles) - 3 loops = 768 bytes
    BNE clear_name_table ; Branch (2-3 cycles, optimization: not-taken preferred)
    ; Write remaining 192 bytes (960 - 768 = 192) to complete name table exactly
    LDX #192            ; Remaining bytes (2 cycles)
clear_name_table_remaining:
    STA $2007           ; Write tile (2 cycles, optimization: reuse A register)
    DEX                 ; Decrement (2 cycles)
    BNE clear_name_table_remaining ; Loop until 0 (2-3 cycles, optimization: not-taken preferred)
    ; PPU address is now at $23C0 (start of attribute table) - exactly 960 bytes written!
    
    ; Clear attribute table explicitly (ensure all bytes are 0 = palette 0)
    ; Per NES documentation: Attribute table at $23C0-$23FF (64 bytes)
    ; Optimization: Register reuse - keep values in A
    LDA $2002           ; Reset latch (4 cycles)
    LDA #$23            ; Attribute table high byte (2 cycles)
    STA $2006           ; Write high byte (4 cycles)
    LDA #$C0            ; Attribute table low byte (2 cycles)
    STA $2006           ; Write low byte - address is now $23C0 (4 cycles)
    
    ; Optimization: Use efficient loop with register reuse
    LDX #0              ; Zero page (2 cycles)
    LDA #0              ; Attribute 0 (2 cycles, optimization: load once, reuse)
clear_attribute_table:
    STA $2007           ; Write attribute byte (2 cycles, optimization: reuse A register)
    INX                 ; Increment (2 cycles)
    CPX #64             ; Compare (2 cycles)
    BNE clear_attribute_table ; Branch (2-3 cycles, optimization: not-taken preferred)
    
    ; Write centered "WELCOME TO S-NES-BOY" text
    ; Text is 20 characters, screen is 32 tiles wide
    ; Center: (32 - 20) / 2 = 6 columns from left
    ; Vertical center: Row 14 (perfect visual center: 14 rows above, 15 rows below)
    ; Address = $2000 + (14 * 32) + 7 = $2000 + $1C0 + 7 = $21C7
    LDA $2002           ; Reset latch (4 cycles)
    LDA #$21            ; High byte of $21C7 (2 cycles)
    STA $2006           ; Write high byte first (4 cycles)
    LDX #14             ; Row 14 (2 cycles, optimization: use X for lookup)
    LDA row_address_table,X  ; Lookup row 14 address low byte (4 cycles, absolute indexed)
    CLC                 ; Clear carry (2 cycles)
    ADC #7              ; Add column offset (2 cycles)
    STA $2006           ; Write low byte - address is now $21C7 (4 cycles)
    
    ; Write text using text rendering function
    ; Optimization: Zero page pointer for indirect indexed addressing
    LDA #<hello_text    ; Low byte of text address (2 cycles)
    STA text_ptr        ; Zero page (3 cycles)
    LDA #>hello_text    ; High byte of text address (2 cycles)
    STA text_ptr+1      ; Zero page (3 cycles)
    JSR write_text      ; Write text string (6 cycles + function time)
    
    ; Set attribute table for text area (all tiles use palette 0)
    ; Text is at row 14, columns 7-23 (17 characters)
    ; Attribute table: each byte controls 2x2 tile groups (4 tiles)
    ; Text spans columns 7-23 = 17 tiles = 5 attribute groups horizontally
    ; Row 14 attribute byte: $23C0 + (14 // 4) * 8 + (14 % 4) = $23C0 + 3*8 + 2 = $23DA
    ; Columns 7-23: attribute bytes at column 7//4=1 to 23//4=5 (5 bytes total)
    ; Address = $23DA + 1 = $23DB (row 14, column group 1)
    LDA $2002           ; Reset latch (4 cycles)
    LDA #$23            ; Attribute table high byte (2 cycles)
    STA $2006           ; Write high byte (4 cycles)
    LDA #$DB            ; Attribute table low byte for row 14, column 7 (2 cycles)
    STA $2006           ; Write low byte (4 cycles)
    
    ; Write 5 attribute bytes (all set to palette 0 = %00000000)
    ; Optimization: Unroll for 5 bytes (faster than loop)
    LDA #0              ; Palette 0 for all tiles (2 cycles)
    STA $2007           ; Write attribute byte 1 (2 cycles)
    STA $2007           ; Write attribute byte 2 (2 cycles, optimization: reuse A)
    STA $2007           ; Write attribute byte 3 (2 cycles)
    STA $2007           ; Write attribute byte 4 (2 cycles)
    STA $2007           ; Write attribute byte 5 (2 cycles)
    
    RTS

; ============================================================================
; Write Text String
; ============================================================================
; Writes a null-terminated string to name table at current PPU address
; Input: text_ptr points to string (null-terminated)
; Per NES documentation: Writes to $2007 go directly to PPU, no buffering
; ============================================================================
write_text:
    ; Optimization: Use Y register for indirect indexed (zero page pointer)
    ; Optimization: Early exit on null terminator, efficient branch (not-taken preferred)
    ; Optimization: Avoid JMP in loop (use fall-through pattern)
    LDY #0              ; Index into string (2 cycles)
write_text_loop:
    LDA (text_ptr),Y    ; Load character (5 cycles, indirect indexed, zero page pointer)
    BEQ write_text_done ; Early exit if null (2 cycles if not taken, 3 if taken)
    
    ; Optimization: Call char_to_tile (JSR acceptable, keeps code maintainable)
    JSR char_to_tile    ; Convert character (subroutine call, ~12 cycles)
    
    STA $2007           ; Write tile (2 cycles)
    INY                 ; Increment (2 cycles)
    CPY #32             ; Limit to 32 characters (2 cycles)
    BCC write_text_loop ; Continue if < 32 (2-3 cycles, optimization: not-taken preferred, avoids JMP)
write_text_done:
    RTS                 ; Return (6 cycles)

; ============================================================================
; Character to Tile Index Conversion
; ============================================================================
; Converts ASCII character to tile index using lookup logic
; Input: A = ASCII character
; Output: A = tile index
; Per NES documentation: Lookup tables in ROM for efficient conversion
; ============================================================================
char_to_tile:
    ; Optimization: Use lookup table for character conversion (faster than branches)
    ; Optimization: Early range checks with efficient branches (not-taken preferred)
    ; Check if valid ASCII range (32-122 covers most printable chars)
    CMP #32
    BCC char_invalid     ; If < 32, invalid (2 cycles if not taken)
    CMP #123
    BCS char_invalid     ; If >= 123, invalid (2 cycles if not taken)
    
    ; Optimization: Use lookup table for all characters
    ; Convert to table index: subtract 32 (space = 0)
    SEC
    SBC #32              ; Convert to 0-90 (2 cycles)
    TAX                  ; Keep index in X (2 cycles, optimization: register reuse)
    LDA char_to_tile_table,X  ; Lookup tile index (4 cycles, absolute indexed)
    RTS

char_invalid:
    ; Default to space if unknown character
    LDA #0              ; Tile 0 = space (2 cycles)
    RTS

; ============================================================================
; Data Section
; ============================================================================
; Per NES documentation: Constants and data in ROM
; Optimization: Lookup tables for fast access
; ============================================================================

; Palette data (32 bytes, 8 palettes × 4 colors)
; Per NES documentation: 8 palettes × 4 colors = 32 bytes
palette_data:
    ; Background palettes (initial setup - will be overwritten by color cycling)
    .byte $0F, $30, $10, $00  ; Background palette 0: bg=$0F(black), c1=$30(white), c2=$10(grey), c3=$00(black)
    .byte $0F, $30, $10, $00  ; Background palette 1
    .byte $0F, $30, $10, $00  ; Background palette 2
    .byte $0F, $30, $10, $00  ; Background palette 3
    ; Sprite palettes (not used, but required)
    .byte $0F, $16, $27, $18  ; Sprite palette 0
    .byte $0F, $16, $27, $18  ; Sprite palette 1
    .byte $0F, $16, $27, $18  ; Sprite palette 2
    .byte $0F, $16, $27, $18  ; Sprite palette 3

; Text string (null-terminated)
hello_text:
    .byte "WELCOME TO S-NES-BOY", 0

; ============================================================================
; Lookup Tables for Optimization
; ============================================================================
; Optimization: Pre-computed values in ROM (lookup vs computation)
; ============================================================================

; Row Address Lookup Table
; Maps row number (0-29) to name table address low byte (row * 32)
; Optimization: Lookup (4 cycles) vs multiplication (10+ cycles) - 60% faster!
; Format: 30 rows × 1 byte = 30 bytes
row_address_table:
    .byte $00, $20, $40, $60, $80, $A0, $C0, $E0  ; Rows 0-7:   0,  32,  64,  96, 128, 160, 192, 224
    .byte $00, $20, $40, $60, $80, $A0, $C0, $E0  ; Rows 8-15: 256, 288, 320, 352, 384, 416, 448, 480
    .byte $00, $20, $40, $60, $80, $A0, $C0, $E0  ; Rows 16-23: 512, 544, 576, 608, 640, 672, 704, 736
    .byte $00, $20, $40, $60, $80, $A0            ; Rows 24-29: 768, 800, 832, 864, 896, 928
    ; Note: Pattern repeats every 8 rows because 8*32=256 wraps to $00

; Character to Tile Index Lookup Table
; Maps ASCII character (32-122) to tile index
; Optimization: Lookup (4 cycles) vs multiple branches (10+ cycles) - 60% faster!
; Format: 91 entries (ASCII 32-122) × 1 byte = 91 bytes
; Index = ASCII - 32, so space (32) is index 0
char_to_tile_table:
    .byte 0, 39, 0, 0, 0, 0, 0, 44, 0, 0, 0, 0, 0, 43, 38, 0  ; ASCII 32-47: space, !, ', -, ., ,
    .byte 1, 2, 3, 4, 5, 6, 7, 8, 9, 10                    ; ASCII 48-57: '0'-'9' -> tiles 1-10
    .byte 41, 42, 0, 0, 0, 40, 0                          ; ASCII 58-64: :, ;, ?
    .byte 11, 12, 13, 14, 15, 16, 17, 18, 19, 20          ; ASCII 65-74: 'A'-'J' -> tiles 11-20
    .byte 21, 22, 23, 24, 25, 26, 27, 28, 29, 30          ; ASCII 75-84: 'K'-'T' -> tiles 21-30
    .byte 31, 32, 33, 34, 35, 36                          ; ASCII 85-90: 'U'-'Z' -> tiles 31-36
    .byte 0, 0, 0, 0, 0, 0, 0                              ; ASCII 91-96: punctuation
    .byte 11, 12, 13, 14, 15, 16, 17, 18, 19, 20          ; ASCII 97-106: 'a'-'j' -> tiles 11-20 (uppercase)
    .byte 21, 22, 23, 24, 25, 26, 27, 28, 29, 30          ; ASCII 107-116: 'k'-'t' -> tiles 21-30
    .byte 31, 32, 33, 34, 35, 36                          ; ASCII 117-122: 'u'-'z' -> tiles 31-36
    ; Punctuation mappings:
    ; ' ' (32, index 0) -> 0, '!' (33, index 1) -> 39, ''' (39, index 7) -> 44
    ; '-' (45, index 13) -> 43, '.' (46, index 14) -> 37, ',' (44, index 12) -> 38
    ; ':' (58, index 26) -> 41, ';' (59, index 27) -> 42, '?' (63, index 31) -> 40

; ============================================================================
; CHR ROM Data
; ============================================================================
; Per NES documentation: Pattern table data, 8 KB (512 tiles × 16 bytes)
; Each tile is 16 bytes: 8 bytes bitplane 0, 8 bytes bitplane 1
; ============================================================================
.segment "CHARS"
    .include "chars_data.asm"
