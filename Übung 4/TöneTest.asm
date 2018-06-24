CLR P1.7 		; Buzzer aus
MOV P3, #0FFh	 ; konfiguriere Port 3 als Eingang
loop:
MOV A, P3 ; kopiere Tasterstatus in Akku
CPL A ; komplementiere Akku
JZ skip ; springe wenn kein Taster gedruckt
SETB P1.7 ; Buzzer an
SJMP loop ; zuruck zu Loop
skip:
CLR P1.7 ; Buzzer aus
SJMP loop ; zuruck zu Loop
end