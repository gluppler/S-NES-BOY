; Hex String to Bytes Macro
; Converts a hexadecimal string literal into byte values
; Supports underscores and single quotes for readability
;
; Usage:
;   hex "11223344"        ; Outputs: $11, $22, $33, $44
;   hex "11_22_33_44"     ; Same, with underscores for readability
;   hex "112''''23_34"    ; Supports single quotes and underscores
;   hex "09F9_1102"       ; Works with any hex string
;
; The macro parses the string character by character, ignoring
; underscores and single quotes, and outputs bytes in order.
; Number of hex digits must be even (each byte requires 2 hex digits).

.macro hex str
    .local char, value, byteValue, digitPlace
    digitPlace .set 0
    byteValue .set 0
    .repeat .strlen( str ), i
        char .set .strat( str, i )
        .if char <> '_' .and char <> '''
            .if char >= 'a' && char <= 'f'
                value .set char - 'a' + 10
            .elseif char >= 'A' && char <= 'F'
                value .set char - 'A' + 10
            .elseif char >= '0' && char <= '9'
                value .set char - '0'
            .else
                .fatal .sprintf( "hex: Invalid character '%c' encountered", char )
            .endif
            byteValue .set byteValue | ( value << ( 4 * ( 1 - digitPlace ) ) )
            digitPlace .set digitPlace ^ 1
            .if digitPlace = 0
                .byte byteValue
                byteValue .set 0
            .endif
        .endif
    .endrepeat
    .if digitPlace = 1
        .fatal .sprintf( "hex: Number of digits must be a multiple of two" )
    .endif
.endmacro
