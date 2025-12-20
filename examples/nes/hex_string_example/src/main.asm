; Hex String Macro Example
; Demonstrates using the hex macro to define multibyte constants

.include "macros/hex_string.inc"

.segment "HEADER"
    .byte "NES", $1A
    .byte $01 ; 16k PRG
    .byte $01 ; 8k CHR
    .byte $00 ; mapper 0, vertical mirroring
    .byte $00, $00, $00, $00, $00, $00, $00, $00

.segment "VECTORS"
    .word nmi
    .word reset
    .word irq

.segment "CODE"

reset:
    SEI
    CLD
    LDX #$FF
    TXS
    
    ; Initialize PPU
    LDA #0
    STA $2000
    STA $2001
    
    ; Wait for VBlank
    BIT $2002
vblank_wait1:
    BIT $2002
    BPL vblank_wait1
    
    ; Wait for second VBlank
vblank_wait2:
    BIT $2002
    BPL vblank_wait2
    
    ; Example: Use hex macro to define lookup table
    ; This demonstrates readable multibyte constant definition
    LDX #0
    LDY #0
display_loop:
    LDA lookup_table,X
    STA $2007
    INX
    CPX #lookup_table_end - lookup_table
    BNE display_loop
    
    ; Enable rendering
    LDA #%10000000
    STA $2000
    LDA #%00011110
    STA $2001
    
    ; Infinite loop
forever:
    JMP forever

nmi:
    RTI

irq:
    RTI

; Example lookup table using hex string macro
; The hex macro converts readable hex strings into byte values
lookup_table:
    hex "09F9_1102_9D74"      ; Bytes: $09, $F9, $11, $02, $9D, $74
    hex "E35B_D841_56C5"      ; Underscores ignored for readability
    hex "6356_88C0"           ; Must have even number of hex digits
lookup_table_end:

; Example: Magic number using hex string
magic_signature:
    hex "4E4553"              ; "NES" in ASCII hex: $4E, $45, $53

; Example: Single hex string with separators
example_data:
    hex "112''''23_34_4f'f"   ; Demonstrates single quotes and underscores
                              ; Result: $11, $22, $33, $44, $4F, $FF
