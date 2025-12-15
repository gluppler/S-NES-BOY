; ============================================================================
; Input State Definitions
; ============================================================================
; SNES hardware behavior: Controller state storage
; ============================================================================

; Controller state addresses (defined in constants/controller.inc)
; controller1_buttons = $0300      ; Controller 1 button states (8 bytes)
; controller1_pressed = $0308     ; Controller 1 pressed this frame (8 bytes)
; controller1_released = $0310    ; Controller 1 released this frame (8 bytes)
; controller1_prev = $0318        ; Controller 1 previous frame state (8 bytes)
