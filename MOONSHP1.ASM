;--------------------------------
; FILE>MOON.SHAPES.1
;--------------------------------
;
;--------------------------------
; UNIVERSE SHAPES
;--------------------------------
GAMESET .byte $00, $00, $00, $00, $00, $00, $00, $00 ; 00 BLANK SPACE
;--------------------------------
; CONTROL PANEL
;--------------------------------
.byte $FF, $FF, $00, $00, $FF, $FF, $FF, $FF ; 01 PANEL
.byte $00, $FF, $FF, $00, $00, $FF, $FF, $FF ; 02
.byte $00, $00, $FF, $FF, $00, $00, $FF, $FF ; 03
.byte $00, $00, $00, $FF, $FF, $00, $00, $FF ; 04
.byte $00, $00, $00, $00, $FF, $FF, $00, $00 ; 05
.byte $00, $00, $00, $00, $00, $1F, $FF, $E0 ; 06
.byte $00, $00, $00, $00, $00, $F8, $FF, $07 ; 07
.byte $00, $3C, $7E, $7E, $7E, $3C, $00, $00 ; 08 DESIGN
.byte $00, $07, $18, $20, $20, $60, $60, $60 ; 09 GUAGE
.byte $00, $FF, $00, $00, $00, $00, $00, $00 ; 0A
.byte $00, $E0, $18, $04, $04, $06, $06, $06 ; 0B
.byte $60, $60, $60, $20, $20, $18, $07, $00 ; 0C
.byte $00, $00, $00, $00, $00, $00, $FF, $00 ; 0D
.byte $06, $06, $06, $04, $04, $18, $E0, $00 ; 0E
.byte $60, $60, $60, $60, $60, $60, $60, $60 ; 0F GUAGE LEFT
.byte $00, $00, $66, $66, $66, $18, $18, $00 ; 10 VEL
.byte $00, $00, $7E, $60, $7E, $60, $7E, $00 ; 11
.byte $00, $00, $60, $60, $60, $60, $7E, $00 ; 12
.byte $06, $06, $06, $06, $06, $06, $06, $06 ; 13 GUAGE RIGHT
.byte $00, $00, $F3, $C3, $F3, $C3, $C3, $00 ; 14 FUEL
.byte $00, $00, $67, $66, $67, $66, $E7, $00 ; 15
.byte $00, $00, $98, $18, $98, $18, $9F, $00 ; 16
.byte $6F, $6C, $6C, $6C, $6C, $6C, $6C, $6F ; 17 BANK INDICATOR
.byte $FF, $00, $00, $C0, $C0, $F0, $00, $FF ; 18
.byte $C3, $00, $00, $00, $00, $00, $00, $C3 ; 19
.byte $FF, $00, $00, $0E, $0E, $09, $00, $FF ; 1A
.byte $F6, $36, $36, $36, $36, $36, $36, $F6 ; 1B
.byte $E7, $C3, $DB, $99, $00, $42, $66, $FF ; 1C SHIPS REMAINING
.byte $E7, $42, $81, $C3, $C3, $99, $99, $FF ; 1D MEN PICKED UP
.byte $3C, $66, $66, $66, $66, $66, $66, $3C ; 1E 0
.byte $18, $38, $18, $18, $18, $18, $18, $3C ; 1F 1
.byte $3C, $66, $06, $0C, $0C, $06, $66, $3C ; 20 3
.byte $3C, $66, $60, $7C, $66, $66, $66, $3C ; 21 6
.byte $3C, $66, $66, $66, $3E, $06, $66, $3C ; 22 9
;--------------------------------
; SPACE SHAPES
;--------------------------------
.byte $00, $00, $07, $0F, $0E, $09, $07, $20 ; 23 SMALL.PLANET
.byte $00, $08, $C0, $A0, $60, $E0, $C0, $00 ; 24
.byte $00, $00, $00, $00, $00, $00, $03, $0F ; 25 MEDIUM.PLANET
.byte $00, $00, $00, $00, $00, $FF, $DB, $F0 ; 26
.byte $00, $00, $08, $00, $00, $7F, $83, $1C ; 27
.byte $0F, $1F, $1F, $1F, $1E, $20, $C3, $FD ; 28
.byte $E1, $FE, $F1, $EE, $1E, $FF, $FF, $FE ; 29
.byte $F0, $E0, $E0, $E0, $E0, $80, $80, $00 ; 2A
.byte $00, $00, $00, $03, $0F, $3F, $3F, $7F ; 2B LARGE.PLANET
.byte $00, $0F, $7F, $FF, $FF, $FF, $FF, $E7 ; 2C
.byte $FF, $FF, $E0, $1F, $FF, $FF, $FF, $CF ; 2D
.byte $00, $F0, $3E, $07, $01, $C0, $C0, $F0 ; 2E
.byte $00, $00, $00, $C0, $F0, $3C, $1C, $FF ; 2F
.byte $01, $01, $07, $07, $07, $0F, $07, $07 ; 30
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; 31
.byte $82, $F0, $97, $FE, $FF, $FF, $FF, $FF ; 32
.byte $03, $03, $E3, $E3, $07, $9F, $FF, $FF ; 33
.byte $C8, $C0, $C0, $F0, $C8, $0E, $0F, $FF ; 34
.byte $7F, $3F, $0F, $0D, $00, $0E, $00, $C0 ; 35
.byte $00, $00, $C0, $C0, $C0, $E0, $20, $20 ; 36
.byte $0F, $07, $07, $07, $01, $01, $00, $00 ; 37 LARGE.PLANET.BOTTOM
.byte $F3, $C0, $00, $F0, $B0, $C3, $7F, $7F ; 38
.byte $FF, $FF, $FF, $FF, $FF, $FF, $F3, $C3 ; 39
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FC, $F0 ; 3A
.byte $66, $86, $8E, $8C, $CC, $70, $F0, $00 ; 3B
.byte $E0, $20, $20, $E0, $C0, $C0, $80, $80 ; 3C
.byte $7F, $3F, $0F, $07, $00, $00, $00, $00 ; 3D
.byte $FF, $FF, $FF, $FB, $FF, $3F, $0F, $00 ; 3E
.byte $FC, $F8, $F9, $D4, $FF, $FF, $FF, $FC ; 3F
.byte $03, $06, $38, $F0, $C0, $00, $00, $00 ; 40
.byte $1F, $70, $FE, $F9, $FF, $FF, $7F, $1F ; 41 BLUE.MOON
.byte $E0, $38, $00, $CC, $CC, $FC, $F8, $E0 ; 42
.byte $00, $00, $00, $10, $7C, $10, $00, $00 ; 43 BIG.STAR
.byte $3D, $4F, $7C, $CF, $03, $39, $E7, $17 ; 44 NEBULA1
.byte $40, $00, $F0, $C0, $E0, $D0, $D0, $C8 ; 45
.byte $4F, $19, $7C, $F9, $7E, $BF, $9F, $5D ; 46 NEBULA3
.byte $F0, $FC, $FF, $FF, $71, $FF, $F8, $E2 ; 47
.byte $10, $00, $12, $39, $F3, $3F, $80, $49 ; 48 NEBULA4
.byte $00, $4A, $01, $FC, $E6, $01, $44, $00 ; 49
.byte $20, $47, $1E, $9D, $1F, $8F, $43, $15 ; 4A NEBULA2
.byte $F0, $FE, $00, $88, $C0, $C0, $82, $20 ; 4B
.byte $10, $10, $28, $82, $28, $10, $10, $00 ; 4C TINY.PLANET
;--------------------------------
; RANDOM STARS
;--------------------------------
.byte $00, $41, $00, $02, $80, $03, $01, $00 ; 4D NEBULA STARS
.byte $40, $00, $20, $10, $00, $03, $00, $00 ; 4E
.byte $10, $61, $00, $02, $00, $20, $00, $00 ; 4F
.byte $00, $00, $80, $40, $00, $60, $00, $C0 ; 50
.byte $00, $00, $00, $00, $08, $00, $00, $00 ; 51
.byte $02, $00, $00, $01, $20, $81, $08, $82 ; 52
.byte $08, $01, $00, $04, $00, $02, $90, $04 ; 53
.byte $00, $01, $44, $00, $88, $00, $00, $88 ; 54
.byte $A0, $09, $40, $08, $40, $00, $00, $00 ; 55
.byte $11, $00, $02, $91, $00, $02, $20, $00 ; 56
.byte $00, $02, $00, $40, $00, $00, $04, $00 ; 57
.byte $00, $00, $20, $04, $10, $02, $40, $00 ; 58
.byte $48, $03, $24, $01, $08, $03, $00, $00 ; 59
.byte $00, $C0, $C0, $E0, $EF, $FE, $F0, $00 ; 5A BOTTOM.LARGE
;--------------------------------
; ORBITAL PLANET
;--------------------------------
.byte $00, $00, $07, $7F, $FF, $FF, $FF, $FF ; 5B 87
.byte $00, $00, $00, $00, $07, $7F, $FF, $FF ; 5C 86
.byte $00, $00, $00, $00, $00, $00, $07, $3F ; 5D 85
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; 5E E6
.byte $FF, $F7, $FD, $DD, $7F, $57, $57, $77 ; 5F EE
.byte $55, $D5, $FD, $FD, $FF, $FF, $FF, $FF ; 60 E5
.byte $01, $0F, $3F, $FF, $FF, $FF, $FF, $FF ; 61 84
.byte $00, $00, $00, $00, $03, $0F, $3F, $FF ; 62 B2
.byte $07, $1F, $7F, $FF, $FF, $FF, $FF, $FF ; 63 82
.byte $00, $00, $00, $01, $07, $1F, $7F, $FF ; 64 83
.byte $FF, $FF, $FF, $FF, $7F, $5F, $57, $55 ; 65 E2
.byte $DF, $55, $55, $55, $55, $55, $55, $55 ; 66 EB
.byte $03, $0F, $3F, $FF, $FF, $FF, $FF, $FF ; 67 A6
.byte $00, $00, $00, $00, $01, $07, $0F, $3F ; 68 A5
.byte $01, $00, $00, $00, $00, $00, $00, $00 ; 69 DE
.byte $00, $00, $00, $00, $00, $80, $F8, $FF ; 6A DD
.byte $00, $00, $00, $80, $F8, $FF, $FF, $1F ; 6B DC
.byte $00, $C0, $F8, $FF, $FF, $0F, $01, $E0 ; 6C 6D
.byte $F0, $FF, $FF, $FF, $01, $00, $F8, $FF ; 6D A8
.byte $FF, $FF, $FF, $00, $00, $7F, $FF, $FF ; 6E 6F
.byte $FF, $FF, $FF, $F8, $C0, $00, $07, $1F ; 6F 01
.byte $00, $03, $0F, $1F, $3F, $7F, $7F, $FF ; 70 BF
.byte $FF, $7F, $5F, $57, $55, $55, $55, $55 ; 71 E1
.byte $00, $01, $07, $0F, $3F, $7F, $FF, $FF ; 72 81
.byte $00, $00, $00, $00, $00, $C0, $F0, $FC ; 73 AD
.byte $00, $00, $80, $F0, $FC, $FF, $5F, $EB ; 74 0A
.byte $E0, $FC, $FF, $7F, $AF, $F5, $FF, $FF ; 75 09
.byte $FF, $3F, $C7, $FA, $FF, $FF, $FF, $FF ; 76 6C
.byte $E1, $FE, $FF, $EF, $FE, $FF, $FF, $1F ; 77 6E
.byte $FF, $7F, $FE, $FF, $FF, $FF, $03, $00 ; 78 0E
.byte $FF, $C0, $3F, $FF, $F4, $3F, $70, $C0 ; 79 0F
.byte $FF, $1F, $7F, $FF, $FF, $FE, $FC, $F9 ; 7A DB
.byte $1F, $3E, $3C, $3C, $3C, $3C, $1E, $1F ; 7B 6B
.byte $7E, $FE, $FE, $FE, $FE, $FE, $FF, $7F ; 7C A9
.byte $55, $55, $55, $55, $55, $D5, $F5, $FD ; 7D EA
.byte $55, $D5, $F5, $FD, $FF, $FF, $FF, $FF ; 7E E9
.byte $AB, $AF, $BF, $FF, $FF, $FF, $FF, $FF ; 7F 72
.byte $AA, $AA, $AA, $AA, $AB, $0B, $0F, $0F ; 80 1A
.byte $FF, $FF, $7F, $07, $00, $00, $00, $00 ; 81 19
.byte $7F, $03, $00, $00, $00, $00, $00, $00 ; 82 1B
.byte $80, $00, $80, $C0, $C0, $E0, $F0, $B8 ; 83 0B
.byte $F9, $F9, $79, $FD, $BE, $DF, $FF, $F7 ; 84 D8
.byte $1F, $8F, $87, $C7, $E3, $E3, $F1, $F8 ; 85 1C
.byte $FB, $7B, $79, $7D, $3C, $3F, $1F, $1F ; 86 AB
.byte $FF, $D7, $D7, $F5, $F5, $FD, $FD, $FF ; 87 ED
.byte $55, $55, $55, $D5, $D5, $D5, $FD, $FF ; 88 E8
.byte $1F, $3F, $7F, $FF, $FF, $FF, $FF, $FF ; 89 95
.byte $00, $00, $00, $00, $01, $03, $07, $0F ; 8A 97
.byte $00, $00, $00, $80, $C0, $E0, $78, $BC ; 8B 18
.byte $DC, $EE, $F7, $FB, $FD, $7F, $3F, $9F ; 8C 1E
.byte $0F, $07, $07, $03, $03, $01, $00, $00 ; 8D 07
.byte $1F, $3F, $7F, $FF, $FF, $FF, $FF, $FF ; 8E 9D
.byte $00, $00, $00, $00, $01, $03, $07, $CF ; 8F 9F
.byte $00, $80, $C0, $E0, $F8, $FC, $FF, $FF ; 90 08
.byte $FE, $FF, $FF, $FF, $3F, $9F, $CF, $E7 ; 91 DA
.byte $7F, $3F, $3F, $1F, $0F, $07, $03, $03 ; 92 4D
.byte $FF, $FF, $FF, $FF, $FF, $BF, $AF, $AB ; 93 15
.byte $BF, $AF, $AB, $AA, $AA, $AA, $AA, $AA ; 94 14
.byte $FF, $FF, $FF, $BF, $FF, $EF, $F3, $FD ; 95 4B
.byte $FB, $FD, $FF, $FF, $FF, $FF, $FF, $FF ; 96 D9
.byte $FF, $FF, $7F, $3F, $1F, $0F, $07, $03 ; 97 AE
.byte $FF, $FF, $BF, $AF, $AF, $AB, $AA, $AA ; 98 17
.byte $AB, $AA, $AA, $AA, $AA, $AA, $AA, $AA ; 99 16
.byte $FB, $FD, $7E, $3F, $1F, $0F, $07, $03 ; 9A 4C
.byte $7F, $5F, $57, $55, $55, $55, $55, $55 ; 9B E3
.byte $FF, $FF, $7F, $3F, $1F, $0F, $07, $13 ; 9C 1F
.byte $AA, $AA, $AA, $EA, $FA, $FA, $FE, $FF ; 9D 3E
.byte $3D, $7E, $FF, $FF, $FF, $FF, $FF, $FF ; 9E 99
.byte $00, $00, $00, $00, $01, $03, $03, $07 ; 9F 98
.byte $FF, $FF, $FF, $FF, $FF, $BF, $AF, $AB ; A0 38
.byte $BF, $AF, $AB, $AA, $AA, $AA, $AA, $AA ; A1 14
.byte $FF, $FF, $FF, $FF, $FF, $BF, $DF, $EF ; A2 48
.byte $AA, $EA, $EA, $FA, $FA, $FE, $FF, $FF ; A3 3F
.byte $07, $0F, $0F, $1F, $3F, $3F, $7F, $7F ; A4 9B
.byte $FF, $FF, $FF, $FF, $FF, $FF, $BF, $AF ; A5 39
.byte $FF, $FF, $BF, $AF, $AB, $AA, $AA, $AA ; A6 3A
.byte $FF, $FF, $7F, $FF, $FF, $E7, $F1, $FC ; A7 49
.byte $FB, $FD, $FE, $FF, $FF, $FF, $FF, $FF ; A8 4A
.byte $AA, $AA, $AA, $AA, $AA, $AA, $AA, $EA ; A9 11
.byte $EA, $EA, $FA, $FA, $FE, $FE, $FF, $FF ; AA 3B
.byte $00, $00, $01, $01, $03, $03, $07, $07 ; AB 9C
;--------------------------------
; NUMBERS
;--------------------------------
.byte $FF, $C3, $99, $99, $99, $99, $C3, $FF ; AC 0
.byte $FF, $E7, $C7, $E7, $E7, $E7, $C3, $FF ; AD 1
.byte $FF, $C3, $B9, $F3, $E7, $CF, $81, $FF ; AE 2
.byte $FF, $C3, $F9, $E3, $F9, $99, $C3, $FF ; AF 3
.byte $FF, $9F, $9B, $9B, $81, $F3, $F3, $FF ; B0 4
.byte $FF, $81, $9F, $83, $F9, $99, $C3, $FF ; B1 5
.byte $FF, $C3, $9F, $83, $99, $99, $C3, $FF ; B2 6
.byte $FF, $81, $B9, $F3, $E7, $CF, $CF, $FF ; B3 7
.byte $FF, $C3, $99, $C3, $99, $99, $C3, $FF ; B4 8
.byte $FF, $C3, $99, $99, $C1, $F9, $C3, $FF ; B5 9
;--------------------------------
; GAME OVER
;--------------------------------
.byte $7F, $FF, $E0, $E3, $E3, $E0, $FF, $7F ; B6
.byte $FC, $FC, $00, $F8, $FC, $1C, $FC, $F8 ; B7 G
.byte $FF, $FF, $00, $7F, $FF, $E0, $FF, $7F ; B8
.byte $F0, $F8, $38, $F8, $F8, $38, $F8, $FC ; B9 A
.byte $E0, $F0, $F8, $FC, $EF, $E7, $E3, $E0 ; BA
.byte $1C, $3C, $7C, $FC, $DC, $9C, $1C, $1C ; BB M
.byte $7F, $FF, $E0, $FF, $FF, $E0, $FF, $7F ; BC
.byte $F8, $F8, $00, $F8, $F8, $00, $F8, $F8 ; BD E
.byte $7F, $FF, $E0, $E0, $E0, $E0, $FF, $7F ; BE
.byte $F8, $FC, $1C, $1C, $1C, $1C, $FC, $F8 ; BF O
.byte $E0, $F0, $78, $3C, $1F, $0F, $07, $03 ; C0
.byte $1C, $3C, $78, $F0, $E0, $C0, $80, $00 ; C1 V
.byte $FF, $FF, $E0, $E0, $FF, $FF, $E0, $E0 ; C2
.byte $E0, $F0, $70, $70, $F0, $E0, $E0, $70 ; C3 R
GAMEND = *
;--------------------------------
; PLANET.SECONDARY COLORS
;--------------------------------
PLANET_SUB_COLOR .byte $00, $00 ; FILLER
.byte LT_RED
.byte $00, $00
.byte LT_GREEN
.byte LT_BLUE
.byte ORANGE
;--------------------------------
; SOUND TABLES
;--------------------------------
WARNING_FRQ .byte $E8, $35
.byte $20, $1C
INTO_PLANET_TBL .byte $09, $58, $41, $28
.byte $00, $00, $40, $01
.byte $09, $58, $41, $08
.byte $00, $00, $40, $01
.byte $09, $58, $41, $08
.byte $00, $00, $40, $01
.byte $0E, $08, $41, $18
.byte $00, $00, $04, $01
.byte $FF
MAN_SOUND_TBL .byte $10, $DE, $41, $02
.byte $11, $DE, $41, $02
.byte $12, $DE, $41, $02
.byte $13, $DE, $41, $02
.byte $14, $DE, $41, $02
.byte $15, $DE, $41, $02
.byte $00, $00, $04, $01
.byte $FF
SAUCER_SOUND_TBL .byte $13, $E8, $41, $04
.byte $00, $00, $04, $01
.byte $FF
RING_SOUND_TBL .byte $00, $00, $41, $10
.byte $00, $00, $04, $01
.byte $FF
BLOWUP_SOUND_TBL .byte $03, $EE, $81, $40
.byte $03, $EE, $81, $40
.byte $00, $00, $04, $01
STOP_SOUND .byte $FF
;--------------------------------
; SHIP VELOCITY TABLE
;--------------------------------
VEL_SUB_TABLE .byte $05, $05, $06, $06, $07, $07, $08, $08
.byte $09, $09, $0A, $0A, $0B, $0B, $0C, $0C
