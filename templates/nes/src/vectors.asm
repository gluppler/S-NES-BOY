; ============================================================================
; Interrupt Vectors
; ============================================================================
; Per NES documentation: Interrupt vectors at $FFFA-$FFFF
; ============================================================================

.import reset, nmi, irq

.segment "VECTORS"
    .addr nmi, reset, irq
