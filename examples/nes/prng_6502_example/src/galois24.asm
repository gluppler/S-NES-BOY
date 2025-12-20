;
; 6502 LFSR PRNG - 24-bit
; Brad Smith, 2019
; http://rainwarrior.ca
;

; A 24-bit Galois LFSR

; Possible feedback values that generate a full 16777215 step sequence:
; $1B = %00011011
; $87 = %10000111
; $B1 = %10110001
; $DB = %11011011
; $F5 = %11110101

; $1B is chosen

.importzp seed24

.code

; simple
; 173-181 cycles per call
; 21 bytes

.export galois24
galois24:
	ldy #8
	lda seed24+0
:
	asl
	rol seed24+1
	rol seed24+2
	bcc :+
	eor #$1B
:
	dey
	bne :--
	sta seed24+0
	cmp #0
	rts

; overlapped
; 73 cycles
; 38 bytes

.export galois24o
galois24o:
	; rotate the middle byte left
	ldy seed24+1 ; will move to seed24+2 at the end
	; compute seed24+1 ($1B>>1 = %1101)
	lda seed24+2
	lsr
	lsr
	lsr
	lsr
	sta seed24+1 ; reverse: %1011
	lsr
	lsr
	eor seed24+1
	lsr
	eor seed24+1
	eor seed24+0
	sta seed24+1
	; compute seed24+0 ($1B = %00011011)
	lda seed24+2
	asl
	eor seed24+2
	asl
	asl
	eor seed24+2
	asl
	eor seed24+2
	sty seed24+2 ; finish rotating byte 1 into 2
	sta seed24+0
	rts
