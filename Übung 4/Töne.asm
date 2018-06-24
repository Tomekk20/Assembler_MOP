CLR P1.7 		; Buzzer aus
CLR P1.6
CLR P1.5
MOV P3, #0FFh 	; konfiguriere Port 3 als Eingang
loop:
MOV A, P3 		; kopiere Tasterstatus in Akku
CPL A 			; komplementiere Akku
 	
JB P3.2, cton	; Wenn S19 gedrückt wird (1), dann springe zum cton
JB P3.1, eton	; Wenn S18 gedrückt wird (1), dann springe zum eton
JB P3.0, gton	; Wenn S17 gedrückt wird (1), dann springe zum gton
SJMP skip

cton:
SETB P1.7 		; Buzzer an
SJMP loop 		; zuruck zu Loop

eton:
SETB P1.6		; Buzzer an
SJMP loop		; zurück zum loop

gton:
SETB P1.5		; Buzzer an
SJMP loop		; zurück zum loop

skip:
CLR P1.7 		; Buzzer aus
CLR P1.6		; Buzzer aus
CLR P1.5		; Buzzer aus
SJMP loop 		; zuruck zu Loop
end
