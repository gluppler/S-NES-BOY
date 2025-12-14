; ============================================================================
; Math Macros
; ============================================================================
; Macros for common math operations
; Per NES documentation: 6502 math operations
; ============================================================================

; ============================================================================
; Multiply by 2 (Left Shift)
; ============================================================================
; Multiplies accumulator by 2
; Parameters: reg (register: A, X, or Y)
; ============================================================================
.macro mul2 reg
    .if .match({reg}, A)
        ASL
    .elseif .match({reg}, X)
        TXA
        ASL
        TAX
    .elseif .match({reg}, Y)
        TYA
        ASL
        TAY
    .else
        .error "mul2: Invalid register (use A, X, or Y)"
    .endif
.endmacro

; ============================================================================
; Divide by 2 (Right Shift)
; ============================================================================
; Divides accumulator by 2
; Parameters: reg (register: A, X, or Y)
; ============================================================================
.macro div2 reg
    .if .match({reg}, A)
        LSR
    .elseif .match({reg}, X)
        TXA
        LSR
        TAX
    .elseif .match({reg}, Y)
        TYA
        LSR
        TAY
    .else
        .error "div2: Invalid register (use A, X, or Y)"
    .endif
.endmacro

; ============================================================================
; Multiply by 4 (Left Shift Twice)
; ============================================================================
; Multiplies accumulator by 4
; Parameters: reg (register: A, X, or Y)
; ============================================================================
.macro mul4 reg
    mul2 reg
    mul2 reg
.endmacro

; ============================================================================
; Multiply by 8 (Left Shift Three Times)
; ============================================================================
; Multiplies accumulator by 8
; Parameters: reg (register: A, X, or Y)
; ============================================================================
.macro mul8 reg
    mul2 reg
    mul2 reg
    mul2 reg
.endmacro

; ============================================================================
; Multiply by 16 (Left Shift Four Times)
; ============================================================================
; Multiplies accumulator by 16
; Parameters: reg (register: A, X, or Y)
; ============================================================================
.macro mul16 reg
    mul4 reg
    mul4 reg
.endmacro

; ============================================================================
; Multiply by 32 (Left Shift Five Times)
; ============================================================================
; Multiplies accumulator by 32 (useful for name table row calculation)
; Parameters: reg (register: A, X, or Y)
; ============================================================================
.macro mul32 reg
    mul16 reg
    mul2 reg
.endmacro

; ============================================================================
; Add with Carry
; ============================================================================
; Adds a value to accumulator with carry handling
; Parameters: value (immediate value or memory address)
; ============================================================================
.macro add_carry value
    CLC
    ADC value
.endmacro

; ============================================================================
; Subtract with Borrow
; ============================================================================
; Subtracts a value from accumulator with borrow handling
; Parameters: value (immediate value or memory address)
; ============================================================================
.macro sub_borrow value
    SEC
    SBC value
.endmacro

; ============================================================================
; Compare and Branch if Greater or Equal
; ============================================================================
; Compares accumulator and branches if >= value
; Parameters: value (compare value), label (branch target)
; ============================================================================
.macro cmp_bge value, label
    CMP #value
    BCS label
.endmacro

; ============================================================================
; Compare and Branch if Less
; ============================================================================
; Compares accumulator and branches if < value
; Parameters: value (compare value), label (branch target)
; ============================================================================
.macro cmp_blt value, label
    CMP #value
    BCC label
.endmacro
