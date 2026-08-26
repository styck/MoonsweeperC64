;------------------------------------------------------------------
; FILE>MOONSPRT.ASM
;
; Sprite shape data for the C64 Moonsweeper port.
;
; The S-C source we converted contains only sprite POINTERS but no
; shape data.  The core sprites (ship, shot, saucer, mother, orbit
; objects and explosions) below are copied VERBATIM from the
; released tape game (MOONSWE1.T64) memory image.
;
; The gauge needles (VELOCITY/FUEL dials, ptrs $B5-$C4) are also
; real tape data: $B5-$C0 come from the tape load image ($6D40-$7000)
; and $C2-$C4 from the runtime RAM dump ($7080-$7140) - verified
; byte-for-byte against a VICE snapshot of the orbit screen.  Only
; the radar blips ($D3/$D4) are reconstructed (not in the tape).
;
; Blocks are stored compactly and copied to their VIC-bank
; destinations by INIT_SPRITES (called from INIT_HARDWARE).
;------------------------------------------------------------------

; The table sits at $7240 (just above the orbit-explosion sprites);
; it must stay below $8000 where INIT_HARDWARE stores the restart
; vector.  The radar blocks at the end of the table overlap the
; table region, but they are the LAST blocks copied, so the overlap
; only clobbers already-consumed source bytes.
* = $7240

;--------------------------------
; COMPACT SPRITE SHAPE DATA (64 bytes per block)
;--------------------------------
SPR_SHIP_33  ; ptr $33 -> $4CC0  [tape]
    .byte $00, $00, $0C, $00, $00, $38, $00, $00
    .byte $D0, $00, $00, $B0, $00, $00, $70, $00
    .byte $00, $60, $02, $00, $00, $06, $00, $00
    .byte $0C, $00, $00, $18, $00, $00, $70, $00
    .byte $01, $A0, $00, $01, $60, $00, $00, $E0
    .byte $00, $00, $C0, $19, $14, $00, $01, $80
    .byte $00, $03, $00, $00, $06, $00, $00, $3C
    .byte $00, $00, $28, $00, $00, $18, $00, $00

SPR_SHIP_34  ; ptr $34 -> $4D00  [tape]
    .byte $40, $00, $00, $80, $0C, $00, $00, $18
    .byte $00, $00, $70, $00, $01, $A0, $00, $01
    .byte $60, $00, $00, $C0, $00, $02, $00, $00
    .byte $04, $19, $16, $00, $C0, $00, $01, $80
    .byte $00, $03, $00, $00, $1E, $00, $00, $14
    .byte $00, $00, $0C, $19, $03, $00, $0C, $00
    .byte $40, $18, $00, $00, $70, $00, $01, $A0
    .byte $00, $01, $60, $00, $00, $C0, $19, $07

SPR_SHIP_35  ; ptr $35 -> $4D40  [tape]
    .byte $00, $08, $19, $16, $00, $60, $00, $00
    .byte $C0, $00, $01, $80, $00, $0F, $00, $00
    .byte $0A, $00, $00, $06, $0C, $00, $10, $18
    .byte $00, $00, $70, $00, $01, $A0, $00, $81
    .byte $40, $00, $00, $C0, $19, $0A, $00, $08
    .byte $19, $16, $00, $60, $00, $00, $C0, $00
    .byte $03, $80, $00, $05, $00, $00, $02, $0C
    .byte $00, $08, $18, $00, $10, $70, $00, $00

SPR_SHIP_36  ; ptr $36 -> $4D80  [tape]
    .byte $A0, $00, $00, $40, $00, $01, $00, $00
    .byte $02, $19, $22, $00, $20, $00, $00, $40
    .byte $00, $00, $84, $00, $03, $08, $00, $01
    .byte $10, $00, $00, $60, $00, $00, $20, $19
    .byte $04, $00, $20, $19, $05, $00, $80, $19
    .byte $05, $00, $10, $19, $05, $00, $40, $19
    .byte $13, $00, $10, $00, $00, $20, $00, $00
    .byte $C2, $00, $00, $44, $00, $00, $18, $00

SPR_SHIP_37  ; ptr $37 -> $4DC0  [tape]
    .byte $00, $08, $19, $30, $00, $04, $00, $00
    .byte $09, $00, $00, $02, $19, $47, $00, $07
    .byte $00, $00, $1F, $C0, $00, $2E, $60, $00
    .byte $14, $E0, $00, $1F, $40, $00, $06, $80
    .byte $19, $2F, $00, $07, $00, $00, $1A, $40
    .byte $00, $2F, $60, $00, $11, $E0, $00, $1F
    .byte $40, $00, $06, $80, $19, $2F, $00, $07
    .byte $00, $00, $1C, $C0, $00, $1E, $60, $00

SPR_SHOT_6B  ; ptr $6B -> $5AC0  [tape]
    .byte $2D, $2D, $2D, $2D, $2D, $2D, $2D, $2D
    .byte $2D, $2D, $2D, $2D, $2D, $2D, $2D, $2D
    .byte $2D, $2D, $2D, $2D, $2D, $2D, $2D, $2D
    .byte $2D, $2D, $2D, $2D, $2D, $2D, $2D, $2D
    .byte $2D, $2D, $2D, $2D, $2D, $2D, $2D, $2D
    .byte $2D, $2D, $2D, $2D, $2D, $2D, $2D, $2D
    .byte $2D, $2D, $2D, $2D, $2D, $2D, $2D, $2D
    .byte $2D, $2D, $2D, $2D, $2D, $2D, $2D, $2D

SPR_SHOT_72  ; ptr $72 -> $5C80  [tape]
    .byte $E0, $E0, $E0, $E0, $E0, $E0, $50, $50
    .byte $50, $50, $50, $50, $50, $70, $70, $70
    .byte $70, $70, $70, $70, $10, $80, $80, $80
    .byte $20, $20, $20, $10, $10, $10, $20, $10
    .byte $10, $40, $40, $10, $E0, $E0, $E0, $E0
    .byte $E0, $E0, $E0, $E0, $E0, $E0, $50, $50
    .byte $50, $50, $50, $50, $50, $70, $70, $70
    .byte $70, $70, $70, $70, $10, $80, $80, $80

SPR_SHOT_73  ; ptr $73 -> $5CC0  [tape]
    .byte $20, $20, $20, $20, $20, $20, $20, $20
    .byte $10, $40, $40, $10, $E0, $E0, $E0, $E0
    .byte $E0, $E0, $E0, $E0, $E0, $E0, $50, $50
    .byte $50, $50, $50, $50, $50, $10, $70, $70
    .byte $70, $70, $70, $70, $10, $80, $80, $80
    .byte $10, $20, $20, $20, $20, $20, $20, $20
    .byte $10, $40, $40, $10, $E0, $E0, $E0, $E0
    .byte $E0, $E0, $E0, $E0, $E0, $E0, $50, $50

SPR_SHOT_7B  ; ptr $7B -> $5EC0  [tape]
    .byte $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0
    .byte $F0, $F0, $F0, $F0, $F0, $F0, $F0, $10
    .byte $10, $F0, $F0, $F0, $F0, $F0, $F0, $F0
    .byte $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0
    .byte $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0
    .byte $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0
    .byte $F0, $F0, $F0, $F0, $F0, $F0, $F0, $10
    .byte $10, $F0, $F0, $F0, $F0, $F0, $F0, $F0

SPR_SAUCER_DROP_47  ; ptr $47 -> $51C0  [tape]
    .byte $44, $19, $0D, $00, $02, $80, $00, $0A
    .byte $A0, $00, $02, $80, $19, $04, $00, $FF
    .byte $19, $18, $00, $01, $40, $00, $05, $50
    .byte $00, $04, $10, $00, $07, $D0, $00, $05
    .byte $50, $00, $11, $44, $19, $0D, $00, $02
    .byte $80, $19, $07, $00, $FF, $19, $1B, $00
    .byte $01, $40, $00, $05, $50, $00, $04, $10
    .byte $00, $05, $50, $00, $11, $44, $19, $0D

SPR_SAUCER_DROP_48  ; ptr $48 -> $5200  [tape]
    .byte $00, $02, $80, $19, $07, $00, $FF, $BF
    .byte $00, $00, $3F, $FC, $00, $FF, $FF, $00
    .byte $7F, $FE, $19, $38, $00, $3F, $FC, $00
    .byte $FF, $FF, $00, $7F, $FE, $19, $38, $00
    .byte $1F, $F8, $00, $7F, $FE, $00, $3F, $FC
    .byte $19, $38, $00, $1F, $F8, $00, $7F, $FE
    .byte $00, $3F, $FC, $19, $38, $00, $0F, $F0
    .byte $00, $3F, $FC, $00, $1F, $F8, $19, $38

SPR_SAUCER_DROP_49  ; ptr $49 -> $5240  [tape]
    .byte $00, $07, $E0, $00, $1F, $F8, $00, $0F
    .byte $F0, $19, $38, $00, $03, $80, $00, $0F
    .byte $E0, $19, $3B, $00, $01, $00, $00, $07
    .byte $C0, $19, $3C, $00, $0F, $00, $00, $F8
    .byte $00, $03, $DF, $00, $0E, $80, $00, $18
    .byte $FF, $00, $7F, $FF, $00, $99, $BB, $00
    .byte $7F, $FF, $00, $4B, $FF, $00, $40, $F0
    .byte $00, $01, $BF, $00, $02, $0C, $00, $00

SPR_SAUCER_EXPLODE_3B  ; ptr $3B -> $4EC0  [tape]
    .byte $1A, $00, $03, $E0, $00, $0F, $F8, $00
    .byte $18, $1C, $00, $1F, $FC, $00, $27, $82
    .byte $00, $3F, $FE, $00, $20, $02, $00, $3F
    .byte $FE, $00, $10, $EC, $00, $1F, $FC, $00
    .byte $0C, $18, $00, $03, $E0, $19, $20, $00
    .byte $01, $C0, $00, $07, $F0, $00, $0C, $28
    .byte $00, $1F, $F8, $00, $11, $C4, $00, $0F
    .byte $F8, $00, $15, $0C, $00, $0F, $F8, $00

SPR_SAUCER_EXPLODE_3C  ; ptr $3C -> $4F00  [tape]
    .byte $06, $30, $00, $01, $C0, $19, $26, $00
    .byte $03, $80, $00, $06, $40, $00, $0F, $E0
    .byte $00, $0B, $20, $00, $0F, $E0, $00, $0E
    .byte $60, $00, $07, $C0, $00, $03, $80, $19
    .byte $2C, $00, $01, $80, $00, $03, $C0, $00
    .byte $04, $60, $00, $07, $E0, $00, $02, $40
    .byte $00, $01, $80, $19, $33, $00, $80, $00
    .byte $01, $C0, $00, $01, $C0, $00, $00, $80

SPR_SAUCER_EXPLODE_3D  ; ptr $3D -> $4F40  [tape]
    .byte $19, $23, $00, $40, $02, $00, $23, $C4
    .byte $00, $16, $68, $00, $0D, $B0, $00, $69
    .byte $D6, $00, $69, $F6, $00, $69, $F6, $00
    .byte $79, $FE, $00, $69, $F6, $00, $69, $F6
    .byte $00, $6B, $F6, $00, $0E, $70, $00, $09
    .byte $90, $00, $1B, $D8, $00, $27, $E4, $00
    .byte $43, $C2, $19, $11, $00, $20, $04, $00
    .byte $10, $08, $00, $0B, $D0, $00, $06, $20

SPR_SAUCER_EXPLODE_3E  ; ptr $3E -> $4F80  [tape]
    .byte $00, $1E, $58, $00, $1E, $78, $00, $1E
    .byte $78, $00, $1E, $78, $00, $1E, $78, $00
    .byte $1F, $F8, $00, $1E, $78, $00, $05, $A0
    .byte $00, $0B, $D0, $00, $17, $E8, $00, $23
    .byte $C4, $19, $1A, $00, $10, $08, $00, $0B
    .byte $D0, $00, $07, $60, $00, $07, $20, $00
    .byte $07, $20, $00, $07, $20, $00, $07, $20
    .byte $00, $07, $A0, $00, $06, $60, $00, $05

SPR_MOTHER_00  ; ptr $00 -> $4000  [tape]
    .byte $FF, $7F, $F8, $F8, $00, $F8, $F8, $00
    .byte $F8, $F8, $7F, $FF, $19, $04, $E0, $FF
    .byte $7F, $F8, $FC, $19, $04, $1C, $FC, $F8
    .byte $E0, $F0, $78, $3C, $1F, $0F, $07, $03
    .byte $1C, $3C, $78, $F0, $E0, $C0, $80, $00
    .byte $FF, $FF, $E0, $E0, $FF, $FF, $19, $03
    .byte $E0, $F0, $70, $70, $F0, $E0, $E0, $70
    .byte $00, $FF, $00, $FF, $10, $FF, $00, $19

SPR_MOTHER_01  ; ptr $01 -> $4040  [tape]
    .byte $03, $FF, $F6, $7F, $00, $FF, $00, $FF
    .byte $00, $FF, $00, $B1, $00, $FF, $00, $BB
    .byte $10, $FF, $00, $FF, $00, $FF, $00, $CF
    .byte $38, $19, $03, $FF, $00, $FF, $74, $F5
    .byte $00, $FF, $00, $FD, $00, $7F, $00, $FF
    .byte $00, $FF, $00, $FF, $00, $FF, $00, $19
    .byte $03, $FF, $00, $FF, $00, $FF, $3B, $FF
    .byte $10, $FF, $00, $FF, $00, $FF, $00, $FF

SPR_MOTHER_02  ; ptr $02 -> $4080  [tape]
    .byte $00, $FF, $80, $FF, $FE, $FD, $FF, $FF
    .byte $F6, $FF, $00, $FF, $08, $FF, $00, $FB
    .byte $00, $FF, $FF, $81, $00, $FF, $FE, $80
    .byte $E6, $00, $FD, $00, $FF, $00, $FF, $00
    .byte $FF, $00, $FF, $00, $09, $00, $FF, $00
    .byte $FF, $00, $FF, $00, $FF, $00, $FF, $00
    .byte $FF, $00, $FF, $00, $FF, $00, $FF, $00
    .byte $FF, $00, $FF, $00, $EF, $00, $EF, $19

SPR_MOTHER_EXPLODE_C8  ; ptr $C8 -> $7200  [tape]
    .byte $FE, $FE, $7E, $3E, $3E, $3E, $00, $00
    .byte $00, $00, $00, $1F, $1F, $1F, $00, $00
    .byte $3E, $1E, $1E, $FE, $FC, $F8, $00, $00
    .byte $1E, $1F, $1F, $0F, $0F, $07, $00, $00
    .byte $79, $FF, $FF, $CF, $CF, $03, $00, $00
    .byte $E1, $E1, $E1, $C0, $C0, $80, $00, $00
    .byte $F0, $F0, $F8, $F8, $FF, $7F, $00, $00
    .byte $00, $00, $00, $00, $F8, $F8, $00, $00

SPR_MOTHER_EXPLODE_C6  ; ptr $C6 -> $7180  [tape]
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $01, $01, $01, $01, $01, $00, $00, $00

SPR_ORBIT_STAR_89  ; ptr $89 -> $6240  [tape]
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $01, $07, $0F, $1E
    .byte $07, $1F, $7F, $FF, $FF, $FF, $FF, $7F
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $F8
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $03
    .byte $F0, $FC, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $00, $00, $00, $80, $C0, $F0, $F8, $FC
    .byte $00, $00, $00, $00, $00, $00, $00, $00

SPR_ORBIT_PLANET_91  ; ptr $91 -> $6440  [tape]
    .byte $7F, $7F, $FF, $FF, $FE, $FF, $FF, $FF
    .byte $81, $81, $00, $00, $00, $FF, $FF, $FF
    .byte $9F, $CF, $CF, $E7, $67, $FF, $FF, $FF
    .byte $C0, $E0, $F0, $F0, $F8, $FC, $FC, $FE
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $1C, $1C, $1C, $1C, $1C, $1C, $1C, $0E
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $7F
    .byte $80, $00, $00, $00, $00, $00, $01, $81

SPR_ORBIT_SATELLITE_99  ; ptr $99 -> $6640  [tape]
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $67, $67, $67, $67, $67, $73, $39, $1F
    .byte $FC, $FC, $FC, $FC, $FC, $FC, $F8, $F0
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $67, $E7, $CF, $CF, $E7, $E7, $79, $3F
    .byte $FE, $FC, $FC, $F8, $F8, $F8, $F0, $E0
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $13, $19, $0C, $06, $02, $03, $01, $00

SPR_ORBIT_COMET_A1  ; ptr $A1 -> $6840  [tape]
    .byte $FF, $FF, $00, $00, $00, $00, $00, $00
    .byte $FC, $E0, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $3E, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00

SPR_ORBIT_EXPLODE_C5  ; ptr $C5 -> $7140  [tape]
    .byte $1F, $03, $03, $03, $00, $00, $00, $00
    .byte $E7, $06, $06, $06, $00, $00, $00, $00
    .byte $FE, $66, $66, $06, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00

SPR_ORBIT_EXPLODE_C7  ; ptr $C7 -> $71C0  [tape]
    .byte $E3, $E0, $E0, $E0, $FC, $FC, $00, $00
    .byte $C7, $07, $07, $07, $3F, $3F, $00, $00
    .byte $87, $87, $87, $83, $81, $00, $00, $00
    .byte $81, $81, $81, $C3, $FF, $7E, $00, $00
    .byte $E1, $E1, $E1, $C0, $80, $00, $00, $00
    .byte $E0, $E0, $E0, $F0, $7F, $1F, $00, $00
    .byte $78, $78, $78, $F0, $E0, $80, $00, $00
    .byte $F9, $F8, $F8, $F8, $F8, $F8, $00, $00

SPR_ORBIT_EXPLODE_C9  ; ptr $C9 -> $7240  [tape]
    .byte $F8, $F8, $FC, $7C, $7F, $3F, $00, $00
    .byte $00, $00, $00, $00, $FC, $FC, $00, $00
    .byte $3C, $3C, $3C, $3C, $3C, $3C, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $7C, $7C, $7E, $3E, $3F, $1F, $00, $00
    .byte $00, $00, $00, $00, $FE, $FE, $00, $00
    .byte $3C, $3C, $3C, $3C, $3C, $3C, $00, $00
    .byte $3C, $1E, $1E, $0F, $0F, $0F, $00, $00

SPR_DIAL_B5  ; ptr $B5 -> $6D40  [tape needle]
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $03, $03, $03, $0F, $00, $00, $00, $00
    .byte $C0, $C0, $C0, $F0, $00, $00, $00, $00
    .byte $3C, $3C, $3C, $3C, $00, $00, $00, $00
    .byte $CF, $CF, $0F, $0F, $00, $00, $00, $00
    .byte $3F, $3C, $3C, $3C, $00, $00, $00, $00
    .byte $FC, $3C, $3C, $3C, $00, $00, $00, $00

SPR_DIAL_B6  ; ptr $B6 -> $6D80  [tape needle]
    .byte $3C, $3C, $3C, $1F, $00, $00, $00, $00
    .byte $FC, $3C, $3C, $F8, $00, $00, $00, $00
    .byte $03, $03, $03, $0F, $00, $00, $00, $00
    .byte $C0, $C0, $C0, $F0, $00, $00, $00, $00
    .byte $3C, $3C, $3C, $1F, $00, $00, $00, $00
    .byte $00, $00, $3C, $F8, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00

SPR_DIAL_B7  ; ptr $B7 -> $6DC0  [tape needle]
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $03, $0F, $1E, $1F, $1E, $1E
    .byte $00, $00, $F0, $3C, $1E, $FE, $1E, $1E
    .byte $00, $00, $00, $07, $01, $01, $01, $01
    .byte $00, $00, $00, $E0, $E0, $E0, $E0, $E0
    .byte $00, $00, $00, $07, $01, $01, $01, $01
    .byte $00, $00, $00, $E0, $E0, $E0, $E0, $E0
    .byte $00, $00, $00, $00, $00, $00, $00, $00

SPR_DIAL_B8  ; ptr $B8 -> $6E00  [tape needle]
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $1F, $1E, $1E, $1F, $1F, $1E
    .byte $00, $00, $FC, $1E, $1E, $FC, $E0, $78
    .byte $00, $00, $00, $01, $00, $07, $01, $01
    .byte $00, $00, $00, $E0, $00, $E0, $E0, $E0
    .byte $00, $00, $00, $00, $0F, $1E, $1E, $0F
    .byte $00, $00, $00, $00, $FE, $1E, $1E, $FE
    .byte $00, $00, $00, $1E, $1E, $1F, $1E, $1E

SPR_DIAL_B9  ; ptr $B9 -> $6E40  [tape needle]
    .byte $00, $00, $00, $00, $00, $FC, $1E, $1E
    .byte $00, $00, $00, $01, $1F, $01, $01, $01
    .byte $00, $00, $00, $E0, $FE, $E0, $E0, $E0
    .byte $00, $00, $00, $00, $0F, $1E, $0F, $00
    .byte $00, $00, $00, $00, $FE, $00, $FC, $1E
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $1F, $1E, $1E, $1F, $1F, $1E

SPR_DIAL_BA  ; ptr $BA -> $6E80  [tape needle]
    .byte $00, $00, $FC, $1E, $1E, $FC, $E0, $78
    .byte $00, $00, $00, $00, $0F, $1E, $1F, $1E
    .byte $00, $00, $00, $00, $FC, $1E, $FE, $00
    .byte $00, $00, $00, $00, $0F, $1E, $0F, $00
    .byte $00, $00, $00, $00, $FE, $00, $FC, $1E
    .byte $00, $00, $00, $00, $0F, $1E, $1F, $1E
    .byte $00, $00, $00, $00, $FC, $1E, $FE, $00
    .byte $00, $00, $00, $00, $1F, $1E, $1E, $1E

SPR_DIAL_BB  ; ptr $BB -> $6EC0  [tape needle]
    .byte $00, $00, $00, $00, $FC, $1E, $00, $00
    .byte $00, $00, $00, $00, $1E, $1E, $1E, $0F
    .byte $00, $00, $00, $00, $1E, $1E, $1E, $3C
    .byte $00, $00, $00, $00, $0F, $1E, $1F, $1E
    .byte $00, $00, $00, $00, $FC, $1E, $FE, $00
    .byte $00, $00, $00, $00, $00, $0F, $1E, $1E
    .byte $00, $00, $00, $1E, $1E, $FE, $1E, $1E
    .byte $00, $00, $00, $00, $00, $00, $00, $00

SPR_DIAL_BC  ; ptr $BC -> $6F00  [tape needle]
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $1E, $00, $00, $00, $00, $00, $00, $00
    .byte $1E, $00, $00, $00, $00, $00, $00, $00
    .byte $07, $00, $00, $00, $00, $00, $00, $00
    .byte $F8, $00, $00, $00, $00, $00, $00, $00
    .byte $07, $00, $00, $00, $00, $00, $00, $00
    .byte $F8, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00

SPR_DIAL_BD  ; ptr $BD -> $6F40  [tape needle]
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $1E, $00, $00, $00, $00, $00, $00, $00
    .byte $1E, $00, $00, $00, $00, $00, $00, $00
    .byte $07, $00, $00, $00, $00, $00, $00, $00
    .byte $F8, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $1F, $00, $00, $00, $00, $00, $00
    .byte $1E, $FC, $00, $00, $00, $00, $00, $00
    .byte $1E, $00, $00, $00, $00, $00, $00, $00

SPR_DIAL_BE  ; ptr $BE -> $6F80  [tape needle]
    .byte $1E, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $FE, $00, $00, $00, $00, $00, $00, $00
    .byte $1F, $00, $00, $00, $00, $00, $00, $00
    .byte $FC, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $1E, $00, $00, $00, $00, $00, $00, $00

SPR_DIAL_BF  ; ptr $BF -> $6FC0  [tape needle]
    .byte $1E, $00, $00, $00, $00, $00, $00, $00
    .byte $0F, $00, $00, $00, $00, $00, $00, $00
    .byte $F8, $00, $00, $00, $00, $00, $00, $00
    .byte $1F, $00, $00, $00, $00, $00, $00, $00
    .byte $FC, $00, $00, $00, $00, $00, $00, $00
    .byte $0F, $00, $00, $00, $00, $00, $00, $00
    .byte $F8, $00, $00, $00, $00, $00, $00, $00
    .byte $1E, $00, $00, $00, $00, $00, $00, $00

SPR_DIAL_C0  ; ptr $C0 -> $7000  [tape needle]
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $03, $00, $00, $00, $00, $00, $00, $00
    .byte $F0, $00, $00, $00, $00, $00, $00, $00
    .byte $0F, $00, $00, $00, $00, $00, $00, $00
    .byte $F8, $00, $00, $00, $00, $00, $00, $00
    .byte $0F, $00, $00, $00, $00, $00, $00, $00
    .byte $FE, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00

SPR_DIAL_C1  ; ptr $C1 -> $7040  [tape needle]
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00

SPR_DIAL_C2  ; ptr $C2 -> $7080  [tape needle]
    .byte $38, $7E, $7E, $FF, $FF, $F3, $F3, $E3
    .byte $1C, $7E, $7E, $FF, $FF, $CF, $CF, $C7
    .byte $00, $01, $03, $07, $07, $07, $07, $87
    .byte $7E, $FF, $C3, $81, $81, $81, $81, $81
    .byte $00, $80, $C0, $E1, $E1, $E1, $E1, $E1
    .byte $1F, $7F, $F0, $E0, $E0, $E0, $E0, $E0
    .byte $80, $E0, $F0, $78, $78, $78, $78, $78
    .byte $3C, $3C, $7F, $7F, $7F, $7F, $7F, $7F

SPR_DIAL_C3  ; ptr $C3 -> $70C0  [tape needle]
    .byte $3E, $3E, $3E, $3E, $FE, $FE, $FE, $FE
    .byte $07, $0F, $1F, $1E, $1C, $1E, $0F, $07
    .byte $FE, $FE, $FE, $00, $00, $00, $F8, $FC
    .byte $1F, $3F, $3C, $3C, $3C, $3C, $3C, $1E
    .byte $87, $87, $00, $00, $00, $78, $78, $79
    .byte $E0, $F0, $F0, $F1, $F1, $F1, $F1, $E1
    .byte $7F, $FF, $F8, $F0, $F0, $FF, $FF, $F0
    .byte $F8, $F8, $00, $00, $00, $80, $80, $00

SPR_DIAL_C4  ; ptr $C4 -> $7100  [tape needle]
    .byte $3F, $7F, $7C, $F8, $F8, $FF, $FF, $F8
    .byte $FC, $FC, $00, $00, $00, $C0, $C0, $00
    .byte $3F, $3F, $3C, $3C, $3C, $3C, $3F, $3F
    .byte $F0, $F8, $3C, $3C, $3C, $3C, $F8, $F0
    .byte $1F, $3F, $3E, $7C, $7C, $7F, $7F, $7C
    .byte $FE, $FE, $00, $00, $00, $E0, $E0, $00
    .byte $3F, $3F, $3C, $3C, $3C, $3C, $3F, $3F
    .byte $F0, $F8, $3C, $3C, $3C, $3C, $F8, $F8

SPR_RADAR_MAN_D3  ; ptr $D3 -> $74C0  [reconstructed blip]
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $08, $00, $00, $08, $00, $00, $7E
    .byte $00, $00, $08, $00, $00, $08, $00, $00
    .byte $08, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00

SPR_RADAR_SHIP_D4  ; ptr $D4 -> $7500  [reconstructed blip]
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $08, $00, $00, $14
    .byte $00, $00, $22, $00, $00, $41, $00, $00
    .byte $22, $00, $00, $14, $00, $00, $08, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00

;--------------------------------
; DESTINATION TABLE (one word per block, same order)
;--------------------------------
SPRITE_DEST_TABLE
    .word $4CC0  ; SHIP ptr $33
    .word $4D00  ; SHIP ptr $34
    .word $4D40  ; SHIP ptr $35
    .word $4D80  ; SHIP ptr $36
    .word $4DC0  ; SHIP ptr $37
    .word $5AC0  ; SHOT ptr $6B
    .word $5C80  ; SHOT ptr $72
    .word $5CC0  ; SHOT ptr $73
    .word $5EC0  ; SHOT ptr $7B
    .word $51C0  ; SAUCER_DROP ptr $47
    .word $5200  ; SAUCER_DROP ptr $48
    .word $5240  ; SAUCER_DROP ptr $49
    .word $4EC0  ; SAUCER_EXPLODE ptr $3B
    .word $4F00  ; SAUCER_EXPLODE ptr $3C
    .word $4F40  ; SAUCER_EXPLODE ptr $3D
    .word $4F80  ; SAUCER_EXPLODE ptr $3E
    .word $4000  ; MOTHER ptr $00
    .word $4040  ; MOTHER ptr $01
    .word $4080  ; MOTHER ptr $02
    .word $7200  ; MOTHER_EXPLODE ptr $C8
    .word $7180  ; MOTHER_EXPLODE ptr $C6
    .word $6240  ; ORBIT_STAR ptr $89
    .word $6440  ; ORBIT_PLANET ptr $91
    .word $6640  ; ORBIT_SATELLITE ptr $99
    .word $6840  ; ORBIT_COMET ptr $A1
    .word $7140  ; ORBIT_EXPLODE ptr $C5
    .word $71C0  ; ORBIT_EXPLODE ptr $C7
    .word $7240  ; ORBIT_EXPLODE ptr $C9
    .word $6D40  ; DIAL ptr $B5
    .word $6D80  ; DIAL ptr $B6
    .word $6DC0  ; DIAL ptr $B7
    .word $6E00  ; DIAL ptr $B8
    .word $6E40  ; DIAL ptr $B9
    .word $6E80  ; DIAL ptr $BA
    .word $6EC0  ; DIAL ptr $BB
    .word $6F00  ; DIAL ptr $BC
    .word $6F40  ; DIAL ptr $BD
    .word $6F80  ; DIAL ptr $BE
    .word $6FC0  ; DIAL ptr $BF
    .word $7000  ; DIAL ptr $C0
    .word $7040  ; DIAL ptr $C1
    .word $7080  ; DIAL ptr $C2
    .word $70C0  ; DIAL ptr $C3
    .word $7100  ; DIAL ptr $C4
    .word $74C0  ; RADAR_MAN ptr $D3
    .word $7500  ; RADAR_SHIP ptr $D4
SPRITE_BLOCK_COUNT = 46

;--------------------------------
; COPY SPRITES FROM TABLE TO VIC BANK
; Uses zero-page $FB-$FE as pointers.
;--------------------------------
INIT_SPRITES
    LDA #<SPR_SHIP_33
    STA $FB
    LDA #>SPR_SHIP_33
    STA $FC
    LDX #$00
_1 LDA SPRITE_DEST_TABLE,X
    STA $FD
    LDA SPRITE_DEST_TABLE+1,X
    STA $FE
    LDY #$00
_2 LDA ($FB),Y
    STA ($FD),Y
    INY
    CPY #64
    BNE _2
    LDA $FB
    CLC
    ADC #64
    STA $FB
    BCC _3
    INC $FC
_3 INX
    INX
    CPX #<SPRITE_BLOCK_COUNT*2
    BNE _1
    RTS
