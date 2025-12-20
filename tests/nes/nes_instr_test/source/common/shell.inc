; Included at beginning of program

; Sub-test in a multi-test ROM
.ifdef BUILD_MULTI
	.include "build_multi.asm"
.else

; NSF music file
.ifdef BUILD_NSF
	.include "build_nsf.asm"
.endif

; Devcart
.ifdef BUILD_DEVCART
	.include "build_devcart.asm"
.endif

; NES ROM (default)
.ifndef SHELL_INCLUDED
	.include "build_rom.asm"
.endif

.endif ; .ifdef BUILD_MULTI
