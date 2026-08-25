;--------------------------------
; MOONSWEEPER C-64 VERSION
; (C) 1984 IMAGIC
; BY DANIEL FILIBERTI
; A.C.T
;--------------------------------
;      .TI 55,MOONSWEEPER C-64
;      .LIS OFF
;
; Auto-run BASIC stub: 10 SYS <COLD_START> - the SYS address is
; computed automatically by 64tass so it never needs updating.
; The game code itself starts at $0860 (set in MOONEQU.ASM).

* = $0801
    .word (+), 10
    .null $9e, format("%4d", COLD_START)
+   .word 0

    .include "MOONMACR.ASM"
    .include "MOONEQU.ASM"
    .include "MOONCOD1.ASM"
    .include "MOONCOD2.ASM"
    .include "MOONCOD3.ASM"
    .include "MOONCOD4.ASM"
    .include "MOONCOD5.ASM"
    .include "MOONIRQ.ASM"
    .include "MOON.SHAPES.1"
    .include "MOON.SHAPES.2"
