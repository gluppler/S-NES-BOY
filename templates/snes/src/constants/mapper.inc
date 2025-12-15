; ============================================================================
; Mapper Constants
; ============================================================================
; SNES hardware behavior: Mapper constants for iNES header
; ============================================================================

.ifndef SNES_MAPPER_CONSTANTS_INC
SNES_MAPPER_CONSTANTS_INC = 1

; Mapper IDs
MAPPER_NROM = 0         ; NROM (Mapper 0) - No mapper
MAPPER_MMC1 = 1         ; MMC1 (Mapper 1)
MAPPER_MMC3 = 4         ; MMC3 (Mapper 4)

; Mirroring constants
MIRRORING_HORIZONTAL = %00000000
MIRRORING_VERTICAL = %00000001
MIRRORING_FOUR_SCREEN = %00001000

; Battery-backed save RAM
BATTERY_NONE = %00000000
BATTERY_PRESENT = %00000010

; TV system
TV_NTSC = 0
TV_PAL = 1

.endif ; SNES_MAPPER_CONSTANTS_INC
