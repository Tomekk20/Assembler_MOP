
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
 MOV P0, #0FFh	  ; setze alle LEDs auﬂer LED1 auf aktiv
 SETB P3.2	      ; setze Taster auf aktiv
 
lock:
 JNB P3.2, lock	 ; Springe zu lock wenn, Taster S19 = '0'
 SETB P0.2        ; LED3 (Gelb) aus
 CLR P0.0         ; LED1 (Rot) an

loop:
 JB P3.2, loop	  ; Springe zu loop wenn, Taster S19 = '1'

MOV A, #8         ; Setze Timer auf 2 Sek
ACALL timer       ; Aufruf Unterprogramm "Timer"
  
gruen:
 CPL P0.0        ; inventiere LED1 (Rot)
 CPL P0.4        ; inventiere LED5 (Gruen)
 MOV A, #12      ; Setze Timer auf 3 Sek                
 ACALL timer     ; Aufruf Unterprogramm "Timer"

gelb:
 CPL P0.4        ; inventiere LED5 (Gruen)
 CPL P0.2        ; inventiere LED3 (Gelb)
 MOV A, #4
 ACALL timer    ; Aufruf Unterprogramm "Timer"
 
SJMP lock	      ; Springe zu loop

ORG 300h        ;Unterprogramm
; Timer
timer:
 MOV R1, A
loop_t1:
 MOV R2, #250
loop_t2:
 MOV R3, #250
loop_t3:
 NOP
 NOP
 DJNZ R3, loop_t3
 DJNZ R2, loop_t2
 DJNZ R1, loop_t1
RET

End
