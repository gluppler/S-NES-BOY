; ============================================================================
; Memory Macros
; ============================================================================
; Macros for memory operations
; Per NES documentation: Memory access patterns
; ============================================================================

; ============================================================================
; Clear Memory Page
; ============================================================================
; Clears a 256-byte page of memory
; Parameters: page (page address, e.g., $0200)
; ============================================================================
.macro clear_page page
    LDX #0
    LDA #0
clear_page_loop:
    STA page,X
    INX
    BNE clear_page_loop
.endmacro

; ============================================================================
; Clear Memory Range
; ============================================================================
; Clears a range of memory
; Parameters: start (start address), count (byte count, 0-255)
; ============================================================================
.macro clear_memory start, count
    LDX #0
    LDA #0
clear_memory_loop:
    STA start,X
    INX
    CPX #count
    BNE clear_memory_loop
.endmacro

; ============================================================================
; Copy Memory Page
; ============================================================================
; Copies a 256-byte page from source to destination
; Parameters: src (source page), dst (destination page)
; ============================================================================
.macro copy_page src, dst
    LDX #0
copy_page_loop:
    LDA src,X
    STA dst,X
    INX
    BNE copy_page_loop
.endmacro

; ============================================================================
; Copy Memory Range
; ============================================================================
; Copies a range of memory
; Parameters: src (source address), dst (destination address), count (byte count, 0-255)
; ============================================================================
.macro copy_memory src, dst, count
    LDX #0
copy_memory_loop:
    LDA src,X
    STA dst,X
    INX
    CPX #count
    BNE copy_memory_loop
.endmacro

; ============================================================================
; Fill Memory
; ============================================================================
; Fills a memory range with a value
; Parameters: addr (start address), value (fill value), count (byte count, 0-255)
; ============================================================================
.macro fill_memory addr, value, count
    LDX #0
    LDA #value
fill_memory_loop:
    STA addr,X
    INX
    CPX #count
    BNE fill_memory_loop
.endmacro

; ============================================================================
; Set Zero Page Pointer
; ============================================================================
; Sets a zero page pointer to an address
; Parameters: ptr (zero page pointer address), addr (target address)
; ============================================================================
.macro set_ptr ptr, addr
    LDA #<(addr)
    STA ptr
    LDA #>(addr)
    STA ptr+1
.endmacro
