; ============================================================================
; RAM Memory Definitions
; ============================================================================
; Per NES documentation: RAM usage patterns
; Recommended locations: $0300-$07FF (avoid $0000-$02FF which are used)
; ============================================================================

.ifndef RAM_INC
RAM_INC = 1

; Game state variables
game_state = $0300      ; Current game state (0=title, 1=playing, 2=paused, etc.)
level_number = $0301     ; Current level number
lives = $0302           ; Player lives
score = $0303           ; Score (low byte)
score_high = $0304      ; Score (high byte)
score_mid = $0305       ; Score (middle byte)
score_highest = $0306   ; Score (highest byte)

; ADD CODE HERE: Your RAM variables
; Example:
;   level_data = $0400   ; Level data buffer (256 bytes)
;   enemy_data = $0500   ; Enemy data buffer (256 bytes)

.endif ; RAM_INC
