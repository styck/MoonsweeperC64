;--------------------------------
; FILE>MOON.MACROS
;--------------------------------
; ADD AN 8BIT VALUE TO A
; 16 BIT RESULT
; FORMAT IS >ADD ]1,]2,]3
; ]1=BYTE TO ADD ]2=LOW ANSWER
;--------------------------------
ADD .macro
LDA #<\1
CLC
ADC \2
STA \2
BCC +
INC \2+1
+
.endm
;--------------------------------
; SUBTRACT AN 8BIT VALUE TO A
; 16 BIT RESULT
; FORMAT IS >SUB ]1,]2,]3
; ]1=BYTE TO ADD ]2=LOW ANSWER
;--------------------------------
SUB .macro
LDA \1
SEC
SBC #<\2
STA \1
BCS +
DEC \1+1
+
.endm
;--------------------------------
; BUILD A POINTER IN ZERO PAGE
;--------------------------------
; FORMAT >BUILD ]1,]2
; ]1=WHERE TO POINT TO IN MEMORY
; ]2=ZERO PAGE ADDRESS OF POINTER
;--------------------------------
BUILD .macro
LDA #<\1
STA \2
LDA #>\1
STA \2+1
.endm
;--------------------------------
; INCREMENT A 16 BIT VALUE
;--------------------------------
INC16 .macro
LDA \1
CLC
ADC #$01
STA \1
BCC +
INC \1+1
+
.endm
;--------------------------------
; PRINT ROUTINE MACRO
; ENTER WITH ]1=XCOOR, ]2=YCOOR
; ]3=COLOR ]4=STRING TO PRINT!
;--------------------------------
PRINT_MACRO .macro
LDX #<\1
LDY #<\2
LDA #<\3
STA PRINT_COLOR
JSR PRINT
.text "\4"
.byte $FF
.endm
