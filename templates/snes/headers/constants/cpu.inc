; ============================================================================
; CPU Constants
; ============================================================================
; 65816 CPU constants for SNES
; ============================================================================

; CPU flags (65816 status register)
FLAG_CARRY = %00000001
FLAG_ZERO = %00000010
FLAG_INTERRUPT = %00000100
FLAG_DECIMAL = %00001000
FLAG_BREAK = %00010000
FLAG_UNUSED = %00100000
FLAG_OVERFLOW = %01000000
FLAG_NEGATIVE = %10000000

; CPU modes
CPU_MODE_EMULATION = %00000000
CPU_MODE_NATIVE = %00000001

; Register size flags
REG_SIZE_8BIT = %00100000
REG_SIZE_16BIT = %00000000

; CPU timing (NTSC)
CPU_FREQ_NTSC = 21477272  ; 21.477272 MHz master clock
CPU_FREQ_DIV = 8          ; CPU runs at master/8
CPU_FREQ_ACTUAL = 2684319 ; ~2.68 MHz actual CPU frequency

; Stack
STACK_INIT = $01FF        ; Initial stack pointer value (16-bit)

; Direct page
DIRECT_PAGE_INIT = $0000  ; Initial direct page value
