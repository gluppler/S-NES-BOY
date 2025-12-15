; ============================================================================
; CPU Constants
; ============================================================================
; Per NES documentation: 6502 CPU constants
; ============================================================================

.ifndef CPU_CONSTANTS_INC
CPU_CONSTANTS_INC = 1

; CPU flags
FLAG_CARRY = %00000001
FLAG_ZERO = %00000010
FLAG_INTERRUPT = %00000100
FLAG_DECIMAL = %00001000
FLAG_BREAK = %00010000
FLAG_UNUSED = %00100000
FLAG_OVERFLOW = %01000000
FLAG_NEGATIVE = %10000000

; CPU timing (NTSC)
CPU_FREQ_NTSC = 1789773  ; 1.79 MHz (approximate)
CYCLES_PER_FRAME = 29780 ; Cycles per frame (NTSC 60 Hz)

; Stack
STACK_INIT = $FF        ; Initial stack pointer value

.endif ; CPU_CONSTANTS_INC
