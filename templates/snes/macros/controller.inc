; ============================================================================
; Controller Macros
; ============================================================================
; Macros for controller operations
; SNES hardware behavior: Controller reading patterns
; ============================================================================

.include "constants/controller.inc"
.include "input/input_state.inc"

; ============================================================================
; Check Button Pressed
; ============================================================================
; Checks if a button was pressed this frame
; Parameters: button (BUTTON_A, BUTTON_B, etc.), label (branch target if pressed)
; ============================================================================
.macro check_button_pressed button, label
    LDA #button
    JSR check_button_pressed
    BNE label
.endmacro

; ============================================================================
; Check Button Held
; ============================================================================
; Checks if a button is currently held
; Parameters: button (BUTTON_A, BUTTON_B, etc.), label (branch target if held)
; ============================================================================
.macro check_button_held button, label
    LDA #button
    JSR check_button_held
    BNE label
.endmacro

; ============================================================================
; Check Button Released
; ============================================================================
; Checks if a button was released this frame
; Parameters: button (BUTTON_A, BUTTON_B, etc.), label (branch target if released)
; ============================================================================
.macro check_button_released button, label
    LDA #button
    JSR check_button_released
    BNE label
.endmacro

; ============================================================================
; Strobe Controller
; ============================================================================
; Strobes controller to prepare for reading
; ============================================================================
.macro strobe_controller
    LDA #$01
    STA CONTROLLER1
    LDA #$00
    STA CONTROLLER1
.endmacro
