; ============================================================================
; Reset Handler
; ============================================================================
; Per NES documentation: Initialize system, clear RAM, setup PPU
; Must follow exact sequence for hardware compatibility
; ============================================================================

.include "memory/zeropage.inc"
.include "memory/ram.inc"
.include "memory/oam.inc"
.include "constants/cpu.inc"
.include "constants/ppu.inc"

; Import symbols from other modules
.import main_loop
.import init_sprites
.import init_game_state
.import load_palette

; Export reset entry point
.export reset
reset:
    ; Disable interrupts and initialize CPU
    SEI                 ; Disable interrupts (per NES documentation: required first)
    CLD                 ; Clear decimal mode (6502 specific: NES doesn't use BCD)
    LDX #STACK_INIT
    TXS                 ; Initialize stack pointer to $01FF
    INX                 ; X = 0 (for clearing RAM)
    
    ; Disable PPU rendering
    ; Per NES documentation: Must disable before VRAM access to prevent corruption
    STX PPUCTRL         ; Disable NMI (PPUCTRL = 0)
    STX PPUMASK         ; Disable rendering (PPUMASK = 0)
    STX $4010           ; Disable DMC IRQ
    
    ; Wait for PPU to stabilize
    ; Per NES documentation: Wait 2 VBlanks to ensure PPU is ready
    BIT PPUSTATUS       ; Clear VBlank flag
vblank_wait1:
    BIT PPUSTATUS
    BPL vblank_wait1    ; Wait for VBlank flag to be set (bit 7)
    
    ; Clear RAM
    ; Per NES documentation: Initialize all RAM to known state ($0000-$07FF)
    LDA #0
clear_ram:
    STA $0000,X         ; Zero page
    STA $0100,X         ; Stack
    STA $0200,X         ; OAM buffer
    STA $0300,X         ; RAM
    STA $0400,X         ; RAM
    STA $0500,X         ; RAM
    STA $0600,X         ; RAM
    STA $0700,X         ; RAM
    INX
    BNE clear_ram       ; Loop until X wraps to 0 (256 iterations)
    
    ; Wait for second VBlank
    ; Per NES documentation: Ensures PPU is fully stabilized
vblank_wait2:
    BIT PPUSTATUS
    BPL vblank_wait2
    
    ; Initialize PPU registers
    ; Per NES documentation: Set up PPU before enabling rendering
    LDA #(PPUCTRL_NMI_ENABLE | PPUCTRL_NAMETABLE_0)
    STA PPUCTRL
    STA ppu_ctrl        ; Store for later updates
    LDA #(PPUMASK_SHOW_BG | PPUMASK_SHOW_SPRITES | PPUMASK_SHOW_BG_LEFT)
    STA PPUMASK
    
    ; Initialize game state variables
    LDA #0
    STA frame_counter
    STA frame_ready
    STA scroll_x
    STA scroll_y
    
    ; Initialize sprite system
    JSR init_sprites
    
    ; Initialize game state
    JSR init_game_state
    
    ; Load palette
    JSR load_palette
    
    ; Load background (optional)
    ; JSR load_background
    
    ; Wait for VBlank before enabling rendering
    ; Per NES documentation: Ensures first frame renders correctly
vblank_wait3:
    BIT PPUSTATUS
    BPL vblank_wait3
    
    ; Set scroll registers
    ; Per NES documentation: Must be set before enabling rendering
    LDA PPUSTATUS       ; Reset scroll latch (read PPUSTATUS)
    LDA #0              ; Scroll value
    STA PPUSCROLL       ; X scroll = 0
    STA PPUSCROLL       ; Y scroll = 0
    
    ; Enter main loop
    ; Per NES documentation: Game loop pattern with frame synchronization
    JMP main_loop
