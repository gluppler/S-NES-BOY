; ============================================================================
; SNES Template - Main Entry Point
; ============================================================================
; Full-featured SNES project template with modular architecture
; Follows SNES documentation best practices and hardware-accurate patterns
; Based on snes-hello canonical patterns
;
; Architecture:
;   - LoROM mapping (banks $00-$7F)
;   - Native 65816 mode
;   - Mode 0 (4 BGs, 4 colors per BG)
;   - 256x224 screen resolution (NTSC)
;   - Frame-synchronized game loop
; ============================================================================

.p816   ; 65816 processor
.i16    ; X/Y are 16 bits
.a8     ; A is 8 bits

.include "../headers/charmap.inc"

.segment "HEADER"    ; +$7FE0 in file
.byte "SNES TEMPLATE GAME  "  ; ROM name (21 bytes)

.segment "ROMINFO"   ; +$7FD5 in file
.byte $30            ; LoROM, fast-capable
.byte 0              ; no battery RAM
.byte $07            ; 128K ROM
.byte 0,0,0,0
.word $AAAA,$5555    ; dummy checksum and complement

.import start

.segment "CODE"
   jmp start

; VRAM address constants
; Note: These are absolute addresses
; ca65 treats = constants as zeropage, but we need them as absolute
; Keep as = constants and use .exportzp/.importzp to match ca65's type system
VRAM_CHARSET = $0000 ; must be at $1000 boundary
VRAM_BG1     = $1000 ; must be at $0400 boundary
.exportzp VRAM_CHARSET, VRAM_BG1
VRAM_BG2       = $1400 ; must be at $0400 boundary
VRAM_BG3       = $1800 ; must be at $0400 boundary
VRAM_BG4       = $1C00 ; must be at $0400 boundary
START_X        = 9
START_Y        = 14
START_TM_ADDR  = VRAM_BG1 + 32*START_Y + START_X

hello_str: .asciiz "Hello, World!"

; Include character set data (NESfont used by reset.asm)
.include "../assets/data/charset.asm"

; Note: reset.asm is compiled separately and linked
; It imports game_loop, NESfont, VRAM_CHARSET, VRAM_BG1 from this file

; Main game loop (called from reset.asm)
.export game_loop
game_loop:
   wai ; Pause until next interrupt complete (i.e. V-blank processing is done)
   ; Do something
   jmp game_loop

; Include NMI handler
.include "nmi.asm"

.segment "VECTORS"
.word 0, 0        ;Native mode vectors
.word return_int  ;COP
.word return_int  ;BRK
.word return_int  ;ABORT
.word nmi         ;NMI
.word start       ;RST
.word return_int  ;IRQ

.word 0, 0        ;Emulation mode vectors
.word return_int  ;COP
.word 0
.word return_int  ;ABORT
.word nmi         ;NMI
.word start       ;RST
.word return_int  ;IRQ
