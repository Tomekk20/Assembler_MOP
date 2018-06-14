
;
$DATE (04.06.2018)
$TITLE ( )
$PAGELENGTH(56)
$PAGEWIDTH(150)
$DEBUG
$XREF
$NOLIST
$MOD51
$LIST
;

start:
MOV P0, #0FEh	; setze alle LEDs auﬂer LED1 auf aktiv
SETB P3.2	; setze Taster auf aktiv
 
loop:
JB P3.2, loop	; Springe zu loop wenn, Taster S19 = '1'

lock:
JNB P3.2, lock	; Springe zu lock wenn, Taster S19 = '0'
CPL P0.0        ; inventiere LED 1
CPL P0.2        ; inventiere LED 3
SJMP loop	; Springe zu loop

End
