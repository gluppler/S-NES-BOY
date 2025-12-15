; ============================================================================
; Timing Macros
; ============================================================================
; Macros for timing and delays
; SNES hardware behavior: Timing patterns
; ============================================================================

; ============================================================================
; NOP Delay
; ============================================================================
; Creates a delay using NOP instructions
; Parameters: cycles (number of cycles, must be multiple of 2)
; Note: Each NOP is 2 cycles
; ============================================================================
.macro nop_delay cycles
    .repeat cycles / 2
        NOP
    .endrepeat
.endmacro

; ============================================================================
; Wait for Frame
; ============================================================================
; Waits for frame_ready flag to be set
; Parameters: label (loop label)
; ============================================================================
.macro wait_for_frame label
label:
    LDA frame_ready
    BEQ label
    LDA #0
    STA frame_ready
.endmacro

; ============================================================================
; Frame Delay
; ============================================================================
; Delays for a specified number of frames
; Parameters: frames (number of frames to wait)
; Note: Requires frame_counter variable
; ============================================================================
.macro frame_delay frames
    ; Store target frame
    LDA frame_counter
    CLC
    ADC #frames
    STA zp_temp           ; Store target in temporary variable
    
frame_delay_loop:
    LDA frame_counter
    CMP zp_temp
    BCC frame_delay_loop
.endmacro
