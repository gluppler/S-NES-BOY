; ============================================================================
; Loop Macros
; ============================================================================
; Macros for common loop patterns
; Per NES documentation: Loop optimization patterns
; ============================================================================

; ============================================================================
; Loop with X Register
; ============================================================================
; Creates a loop using X register as counter
; Parameters: count (loop count 0-255), label (loop label)
; Usage: loop_x 10, my_loop
;        ... loop body ...
;        end_loop_x my_loop
; ============================================================================
.macro loop_x count, label
    LDX #count
label:
.endmacro

.macro end_loop_x label
    DEX
    BNE label
.endmacro

; ============================================================================
; Loop with Y Register
; ============================================================================
; Creates a loop using Y register as counter
; Parameters: count (loop count 0-255), label (loop label)
; ============================================================================
.macro loop_y count, label
    LDY #count
label:
.endmacro

.macro end_loop_y label
    DEY
    BNE label
.endmacro

; ============================================================================
; Loop Until Zero
; ============================================================================
; Loops until accumulator is zero
; Parameters: label (loop label)
; ============================================================================
.macro loop_until_zero label
label:
    ; Loop body here
    ; Accumulator must be decremented/incremented in loop
.endmacro

.macro end_loop_until_zero label
    BNE label
.endmacro

; ============================================================================
; Unroll Loop
; ============================================================================
; Unrolls a small loop for performance
; Parameters: count (unroll count), code (code to repeat)
; Note: This is a placeholder - actual unrolling requires manual code
; ============================================================================
.macro unroll_loop count, code
    .repeat count
        code
    .endrepeat
.endmacro
