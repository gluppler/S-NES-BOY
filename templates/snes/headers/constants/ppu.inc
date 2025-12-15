; ============================================================================
; PPU Constants
; ============================================================================
; SNES PPU register addresses and constants
; ============================================================================

; Address Bus B Registers ($2100-$213F)
INIDISP     = $2100   ; Screen Display Register
OBSEL       = $2101   ; Object Size and Character Size Register
OAMADDL     = $2102   ; OAM Address Registers (Low)
OAMADDH     = $2103   ; OAM Address Registers (High)
OAMDATA     = $2104   ; OAM Data Write Register
BGMODE      = $2105   ; BG Mode and Character Size Register
MOSAIC      = $2106   ; Mosaic Register
BG1SC       = $2107   ; BG Tilemap Address Registers (BG1)
BG2SC       = $2108   ; BG Tilemap Address Registers (BG2)
BG3SC       = $2109   ; BG Tilemap Address Registers (BG3)
BG4SC       = $210A   ; BG Tilemap Address Registers (BG4)
BG12NBA     = $210B   ; BG Character Address Registers (BG1&2)
BG34NBA     = $210C   ; BG Character Address Registers (BG3&4)
BG1HOFS     = $210D   ; BG Scroll Registers (BG1) - dual write
BG1VOFS     = $210E   ; BG Scroll Registers (BG1) - dual write
BG2HOFS     = $210F   ; BG Scroll Registers (BG2) - dual write
BG2VOFS     = $2110   ; BG Scroll Registers (BG2) - dual write
BG3HOFS     = $2111   ; BG Scroll Registers (BG3) - dual write
BG3VOFS     = $2112   ; BG Scroll Registers (BG3) - dual write
BG4HOFS     = $2113   ; BG Scroll Registers (BG4) - dual write
BG4VOFS     = $2114   ; BG Scroll Registers (BG4) - dual write
VMAIN       = $2115   ; Video Port Control Register
VMADDL      = $2116   ; VRAM Address Registers (Low)
VMADDH      = $2117   ; VRAM Address Registers (High)
VMDATAL     = $2118   ; VRAM Data Write Registers (Low)
VMDATAH     = $2119   ; VRAM Data Write Registers (High)
M7SEL       = $211A   ; Mode 7 Settings Register
M7A         = $211B   ; Mode 7 Matrix Registers - dual write
M7B         = $211C   ; Mode 7 Matrix Registers - dual write
M7C         = $211D   ; Mode 7 Matrix Registers - dual write
M7D         = $211E   ; Mode 7 Matrix Registers - dual write
M7X         = $211F   ; Mode 7 Matrix Registers - dual write
M7Y         = $2120   ; Mode 7 Matrix Registers - dual write
CGADD       = $2121   ; CGRAM Address Register
CGDATA      = $2122   ; CGRAM Data Write Register - dual write
W12SEL      = $2123   ; Window Mask Settings Registers
W34SEL      = $2124   ; Window Mask Settings Registers
WOBJSEL     = $2125   ; Window Mask Settings Registers
WH0         = $2126   ; Window Position Registers (WH0)
WH1         = $2127   ; Window Position Registers (WH1)
WH2         = $2128   ; Window Position Registers (WH2)
WH3         = $2129   ; Window Position Registers (WH3)
WBGLOG      = $212A   ; Window Mask Logic registers (BG)
WOBJLOG     = $212B   ; Window Mask Logic registers (OBJ)
TM          = $212C   ; Screen Destination Registers
TS          = $212D   ; Screen Destination Registers
TMW         = $212E   ; Window Mask Destination Registers
TSW         = $212F   ; Window Mask Destination Registers
CGWSEL      = $2130   ; Color Math Registers
CGADSUB     = $2131   ; Color Math Registers
COLDATA     = $2132   ; Color Math Registers
SETINI      = $2133   ; Screen Mode Select Register
MPYL        = $2134   ; Multiplication Result Registers
MPYM        = $2135   ; Multiplication Result Registers
MPYH        = $2136   ; Multiplication Result Registers
SLHV        = $2137   ; Software Latch Register
OAMDATAREAD = $2138   ; OAM Data Read Register - dual read
VMDATALREAD = $2139   ; VRAM Data Read Register (Low)
VMDATAHREAD = $213A   ; VRAM Data Read Register (High)
CGDATAREAD  = $213B   ; CGRAM Data Read Register - dual read
OPHCT       = $213C   ; Scanline Location Registers (Horizontal) - dual read
OPVCT       = $213D   ; Scanline Location Registers (Vertical) - dual read
STAT77      = $213E   ; PPU Status Register
STAT78      = $213F   ; PPU Status Register

; Internal CPU Registers ($4200-$421F)
NMITIMEN    = $4200   ; Interrupt Enable Register
WRIO        = $4201   ; IO Port Write Register
WRMPYA      = $4202   ; Multiplicand Registers
WRMPYB      = $4203   ; Multiplicand Registers
WRDIVL      = $4204   ; Divisor & Dividend Registers
WRDIVH      = $4205   ; Divisor & Dividend Registers
WRDIVB      = $4206   ; Divisor & Dividend Registers
HTIMEL      = $4207   ; IRQ Timer Registers (Horizontal - Low)
HTIMEH      = $4208   ; IRQ Timer Registers (Horizontal - High)
VTIMEL      = $4209   ; IRQ Timer Registers (Vertical - Low)
VTIMEH      = $420A   ; IRQ Timer Registers (Vertical - High)
MDMAEN      = $420B   ; DMA Enable Register
HDMAEN      = $420C   ; HDMA Enable Register
MEMSEL      = $420D   ; ROM Speed Register
RDNMI       = $4210   ; Interrupt Flag Registers
TIMEUP      = $4211   ; Interrupt Flag Registers
HVBJOY      = $4212   ; PPU Status Register
RDIO        = $4213   ; IO Port Read Register
RDDIVL      = $4214   ; Multiplication Or Divide Result Registers (Low)
RDDIVH      = $4215   ; Multiplication Or Divide Result Registers (High)
RDMPYL      = $4216   ; Multiplication Or Divide Result Registers (Low)
RDMPYH      = $4217   ; Multiplication Or Divide Result Registers (High)
JOY1L       = $4218   ; Controller Port Data Registers (Pad 1 - Low)
JOY1H       = $4219   ; Controller Port Data Registers (Pad 1 - High)
JOY2L       = $421A   ; Controller Port Data Registers (Pad 2 - Low)
JOY2H       = $421B   ; Controller Port Data Registers (Pad 2 - High)
JOY3L       = $421C   ; Controller Port Data Registers (Pad 3 - Low)
JOY3H       = $421D   ; Controller Port Data Registers (Pad 3 - High)
JOY4L       = $421E   ; Controller Port Data Registers (Pad 4 - Low)
JOY4H       = $421F   ; Controller Port Data Registers (Pad 4 - High)

; WRAM Registers ($2180-$2183)
WMDATA      = $2180   ; WRAM Data Register
WMADDL      = $2181   ; WRAM Address Registers
WMADDM      = $2182   ; WRAM Address Registers
WMADDH      = $2183   ; WRAM Address Registers

; DMA/HDMA Registers ($4300-$43FF)
DMAPx       = $4300   ; (H)DMA Control Register
BBADx       = $4301   ; (H)DMA Destination Register
A1TxL       = $4302   ; (H)DMA Source Address Registers
A1TxH       = $4303   ; (H)DMA Source Address Registers
A1Bx        = $4304   ; (H)DMA Source Address Registers
DASxL       = $4305   ; (H)DMA Size Registers (Low)
DASxH       = $4306   ; (H)DMA Size Registers (High)
DASBx       = $4307   ; HDMA Indirect Address Registers
A2AxL       = $4308   ; HDMA Mid Frame Table Address Registers (Low)
A2AxH       = $4309   ; HDMA Mid Frame Table Address Registers (High)
NTLRx       = $430A   ; HDMA Line Counter Register

; INIDISP bits
INIDISP_FORCE_BLANK = %10000000
INIDISP_BRIGHTNESS_MASK = %00001111

; BGMODE bits
BGMODE_MODE_MASK = %00000111
BGMODE_BG3_PRIORITY = %00001000

; VMAIN bits
VMAIN_INCREMENT_HIGH = %00000000
VMAIN_INCREMENT_LOW = %00000001
VMAIN_INCREMENT_1 = %00000000
VMAIN_INCREMENT_32 = %10000000
VMAIN_INCREMENT_128 = %10000001

; TM bits (Screen Destination)
TM_BG1 = %00000001
TM_BG2 = %00000010
TM_BG3 = %00000100
TM_BG4 = %00001000
TM_OBJ = %00010000

; NMITIMEN bits
NMITIMEN_VBLANK = %10000000
NMITIMEN_HBLANK = %00100000
NMITIMEN_AUTO_JOYPAD = %00000001

; RDNMI bits
RDNMI_VBLANK = %10000000

; HVBJOY bits
HVBJOY_VBLANK = %10000000
HVBJOY_HBLANK = %01000000
HVBJOY_AUTO_JOYPAD = %00000001
