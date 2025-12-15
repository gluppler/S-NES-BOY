; ============================================================================
; Text Macros
; ============================================================================
; Macros for text operations
; SNES hardware behavior: Text rendering patterns
; ============================================================================

.include "memory/zeropage.inc"
.include "constants/ppu.inc"

; ============================================================================
; Set Text Pointer
; ============================================================================
; Sets text pointer to a string address
; Parameters: string (string label)
; ============================================================================
.macro set_text_ptr string
    LDA #<string
    STA text_ptr
    LDA #>string
    STA text_ptr+1
.endmacro

; ============================================================================
; Print Text at Position
; ============================================================================
; Prints text at a specific row/column position
; Parameters: row (0-29), col (0-31), string (string label)
; ============================================================================
.macro print_at row, col, string
    set_text_ptr string
    LDA #row
    LDX #col
    JSR write_text_at
.endmacro

; ============================================================================
; Print Text Centered
; ============================================================================
; Prints text centered on a row
; Parameters: row (0-29), string (string label)
; Note: Assumes string length is known - adjust column calculation as needed
; ============================================================================
.macro print_centered row, string
    set_text_ptr string
    ; Calculate center: (32 - string_length) / 2
    ; This is a placeholder - implement based on your string length
    LDA #row
    LDX #16              ; Approximate center - adjust as needed
    JSR write_text_at
.endmacro
