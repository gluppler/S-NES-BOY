; ============================================================================
; Branch Macros
; ============================================================================
; Macros for common branch patterns
; Per NES documentation: Branch optimization patterns
; ============================================================================

; ============================================================================
; Branch if Zero
; ============================================================================
; Branches if accumulator is zero
; Parameters: label (branch target)
; ============================================================================
.macro branch_if_zero label
    BEQ label
.endmacro

; ============================================================================
; Branch if Not Zero
; ============================================================================
; Branches if accumulator is not zero
; Parameters: label (branch target)
; ============================================================================
.macro branch_if_not_zero label
    BNE label
.endmacro

; ============================================================================
; Branch if Positive
; ============================================================================
; Branches if accumulator is positive (bit 7 = 0)
; Parameters: label (branch target)
; ============================================================================
.macro branch_if_positive label
    BPL label
.endmacro

; ============================================================================
; Branch if Negative
; ============================================================================
; Branches if accumulator is negative (bit 7 = 1)
; Parameters: label (branch target)
; ============================================================================
.macro branch_if_negative label
    BMI label
.endmacro

; ============================================================================
; Branch if Carry Set
; ============================================================================
; Branches if carry flag is set
; Parameters: label (branch target)
; ============================================================================
.macro branch_if_carry label
    BCS label
.endmacro

; ============================================================================
; Branch if Carry Clear
; ============================================================================
; Branches if carry flag is clear
; Parameters: label (branch target)
; ============================================================================
.macro branch_if_no_carry label
    BCC label
.endmacro

; ============================================================================
; Compare and Branch if Equal
; ============================================================================
; Compares accumulator and branches if equal
; Parameters: value (compare value), label (branch target)
; ============================================================================
.macro cmp_beq value, label
    CMP #value
    BEQ label
.endmacro

; ============================================================================
; Compare and Branch if Not Equal
; ============================================================================
; Compares accumulator and branches if not equal
; Parameters: value (compare value), label (branch target)
; ============================================================================
.macro cmp_bne value, label
    CMP #value
    BNE label
.endmacro

; ============================================================================
; Compare and Branch if Greater
; ============================================================================
; Compares accumulator and branches if greater
; Parameters: value (compare value), label (branch target)
; ============================================================================
.macro cmp_bgt value, label
    CMP #value
    BCS label
.endmacro

; ============================================================================
; Compare and Branch if Less or Equal
; ============================================================================
; Compares accumulator and branches if less or equal
; Parameters: value (compare value), label (branch target)
; ============================================================================
.macro cmp_ble value, label
    CMP #value
    BCC label
.endmacro
