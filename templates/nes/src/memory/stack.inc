; ============================================================================
; Stack Memory Definitions
; ============================================================================
; Per NES documentation: Stack is at $0100-$01FF
; Stack pointer initialized to $01FF (grows downward)
; ============================================================================

STACK_BASE = $01FF      ; Stack base address (top of stack)
STACK_SIZE = 256        ; Stack size (256 bytes)

; Stack usage notes:
; - Stack is used for subroutine calls (JSR/RTS)
; - Stack is used for interrupt handling (PHA, PLA, etc.)
; - Stack grows downward (decrements on push, increments on pop)
; - Stack pointer wraps around (SP=$00 after 256 pushes from $FF)
