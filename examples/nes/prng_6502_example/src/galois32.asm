;
; 6502 LFSR PRNG - 32-bit
; Brad Smith, 2019
; http://rainwarrior.ca
;

; A 32-bit Galois LFSR

; Possible feedback values that generate a full 4294967295 step sequence:
; $AF = %10101111
; $C5 = %11000101
; $F5 = %11110101

; $C5 is chosen

.importzp seed32

.code

; simple
; 213-221 cycles per call
; 23 bytes

.export galois32
galois32:
	ldy #8
	lda seed32+0
:
	asl
	rol seed32+1
	rol seed32+2
	rol seed32+3
	bcc :+
	eor #$C5
:
	dey
	bne :--
	sta seed32+0
	cmp #0
	rts

; overlapped
; 83 cycles
; 44 bytes

.export galois32o
galois32o:
	; rotate the middle bytes left
	ldy seed32+2 ; will move to seed32+3 at the end
	lda seed32+1
	sta seed32+2
	; compute seed32+1 ($C5>>1 = %1100010)
	lda seed32+3 ; original high byte
	lsr
	sta seed32+1 ; reverse: 100011
	lsr
	lsr
	lsr
	lsr
	eor seed32+1
	lsr
	eor seed32+1
	eor seed32+0 ; combine with original low byte
	sta seed32+1
	; compute seed32+0 ($C5 = %11000101)
	lda seed32+3 ; original high byte
	asl
	eor seed32+3
	asl
	asl
	asl
	asl
	eor seed32+3
	asl
	asl
	eor seed32+3
	sty seed32+3 ; finish rotating byte 2 into 3
	sta seed32+0
	rts
