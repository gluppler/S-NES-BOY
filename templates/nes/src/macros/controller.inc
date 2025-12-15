; ============================================================================
; Controller Macros
; ============================================================================
; Macros for controller operations
; Per NES documentation: Controller reading patterns
; ============================================================================

.include "constants/controller.inc"
.include "input/input_state.inc"

; ============================================================================
; Check Button Pressed
; ============================================================================
; Checks if a button was pressed this frame
; Parameters: button (BUTTON_A, BUTTON_B, etc.), label (branch target if pressed)
; ============================================================================
.macro check_button_pressed_macro button_val, branch_label
    LDA #button_val
    JSR check_button_pressed
    BNE branch_label
.endmacro

; ============================================================================
; Check Button Held
; ============================================================================
; Checks if a button is currently held
; Parameters: button (BUTTON_A, BUTTON_B, etc.), label (branch target if held)
; ============================================================================
.macro check_button_held_macro button_val, branch_label
    LDA #button_val
    JSR check_button_held
    BNE branch_label
.endmacro

; ============================================================================
; Check Button Released
; ============================================================================
; Checks if a button was released this frame
; Parameters: button (BUTTON_A, BUTTON_B, etc.), label (branch target if released)
; ============================================================================
.macro check_button_released_macro button_val, branch_label
    LDA #button_val
    JSR check_button_released
    BNE branch_label
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
