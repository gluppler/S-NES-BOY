;
; 6502 LFSR PRNG - 16-bit
; Brad Smith, 2019
; http://rainwarrior.ca
;

; A 16-bit Galois LFSR

; Possible feedback values that generate a full 65535 step sequence:
; $2D = %00101101
; $39 = %00111001
; $3F = %00111111
; $53 = %01010011
; $BD = %10111101
; $D7 = %11010111

; $39 is chosen for its compact bit pattern

.importzp seed16

.code

; simplest version iterates the LFSR 8 times to generate 8 random bits
; 133-141 cycles per call
; 19 bytes

.export galois16
galois16:
	ldy #8
	lda seed16+0
:
	asl        ; shift the register
	rol seed16+1
	bcc :+
	eor #$39   ; apply XOR feedback whenever a 1 bit is shifted out
:
	dey
	bne :--
	sta seed16+0
	cmp #0     ; reload flags
	rts

; overlapped version, computes all 8 iterations in an overlapping fashion
; 69 cycles
; 35 bytes

.export galois16o
galois16o:
	lda seed16+1
	tay ; store copy of high byte
	; compute seed16+1 ($39>>1 = %11100)
	lsr ; shift to consume zeroes on left...
	lsr
	lsr
	sta seed16+1 ; now recreate the remaining bits in reverse order... %111
	lsr
	eor seed16+1
	lsr
	eor seed16+1
	eor seed16+0 ; recombine with original low byte
	sta seed16+1
	; compute seed16+0 ($39 = %111001)
	tya ; original high byte
	sta seed16+0
	asl
	eor seed16+0
	asl
	eor seed16+0
	asl
	asl
	asl
	eor seed16+0
	sta seed16+0
	rts
