 1000 *--------------------------------
 1010 * FILE>MOON.MACROS
 1020 *--------------------------------
 1030 * ADD AN 8BIT VALUE TO A
 1040 * 16 BIT RESULT
 1050 * FORMAT IS >ADD ]1,]2,]3
 1060 * ]1=BYTE TO ADD ]2=LOW ANSWER
 1070 *--------------------------------
 1080		 .MA ADD
 1090		 LDA #]1
 1100		 CLC
 1110		 ADC ]2
 1120		 STA ]2
 1130		 BCC :1
 1140		 INC ]2+1
 1150 :1
 1160		 .EM
 1170 *--------------------------------
 1180 * SUBTRACT AN 8BIT VALUE TO A
 1190 * 16 BIT RESULT
 1200 * FORMAT IS >SUB ]1,]2,]3
 1210 * ]1=BYTE TO ADD ]2=LOW ANSWER
 1220 *--------------------------------
 1230		 .MA SUB
 1240		 LDA ]1
 1250		 SEC
 1260		 SBC #]2
 1270		 STA ]1
 1280		 BCS :1
 1290		 DEC ]1+1
 1300 :1
 1310		 .EM
 1320 *--------------------------------
 1330 * BUILD A POINTER IN ZERO PAGE
 1340 *--------------------------------
 1350 * FORMAT >BUILD ]1,]2
 1360 * ]1=WHERE TO POINT TO IN MEMORY
 1370 * ]2=ZERO PAGE ADDRESS OF POINTER
 1380 *--------------------------------
 1390		 .MA BUILD
 1400		 LDA #]1
 1410		 STA ]2
 1420		 LDA /]1
 1430		 STA ]2+1
 1440		 .EM
 1450 *--------------------------------
 1460 * INCREMENT A 16 BIT VALUE
 1470 *--------------------------------
 1480		 .MA INC
 1490		 LDA ]1
 1500		 CLC
 1510		 ADC #$01
 1520		 STA ]1
 1530		 BCC :1
 1540		 INC ]1+1
 1550 :1
 1560		 .EM
 1570 *--------------------------------
 1580 * PRINT ROUTINE MACRO
 1590 * ENTER WITH ]1=XCOOR, ]2=YCOOR
 1600 * ]3=COLOR ]4=STRING TO PRINT!
 1610 *--------------------------------
 1620		 .MA PRINT
 1630		 LDX #]1
 1640		 LDY #]2
 1650		 LDA #]3
 1660		 STA PRINT.COLOR
 1670		 JSR PRINT
 1680		 .AS -"]4"
 1690		 .HS FF
 1700		 .EM
