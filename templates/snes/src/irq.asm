; ============================================================================
; IRQ Handler
; ============================================================================
; Per NES documentation: IRQ is rarely used on NES, but handler is required
; ============================================================================

irq:
    RTI                 ; Return from interrupt (no-op for this program)
