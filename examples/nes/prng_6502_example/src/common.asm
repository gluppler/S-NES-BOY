;
; Common code for PRNG example
; Based on prng_6502 by Brad Smith (rainwarrior)
; http://rainwarrior.ca
;

.zeropage
; Separate seed storage for each PRNG width to avoid interference
seed16: .res 2  ; 16-bit PRNG seed
seed24: .res 3  ; 24-bit PRNG seed
seed32: .res 4  ; 32-bit PRNG seed
.exportzp seed16, seed24, seed32

; Display values
rng_value_16: .res 1
rng_value_24: .res 1
rng_value_32: .res 1
.exportzp rng_value_16, rng_value_24, rng_value_32
