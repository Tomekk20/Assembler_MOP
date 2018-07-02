ORG 00h

start:
 MOV DPTR, #50h ; Die Adresse für Lookuptable wird auf 50h gesetzt
 MOV R0,#0      ; Register R0 wird auf 0 gesetzt
 MOV P0,#0FFh   ; die LEDs/Segementanzeige P1 wird auf aktiv gesetzt
 MOV P2,#07h    ; die rechte Segmentanzeige wird gesetzt
 SETB P3.7

main:
 MOV A,R0       ; Registerinhalt von R0 übertrag auf A
 ACALL output   ; Unterprogrammaufruf output
 MOV P0,A       ; Segment stellt den Inhalt von A dar
 INC R0         ; Register 0 +1
 CJNE R0,#10,wait ; Wenn R0 nicht 4, dann Springe zu wait
 MOV R0,#0       ; Rücksetzten des R0 auf 0

wait:
  MOV R1, #2
 loop_t1:
  MOV R2, #158
 loop_t2:
  MOV R3, #157
 loop_t3:
  NOP
  NOP
  DJNZ R3, loop_t3
  DJNZ R2, loop_t2
  DJNZ R1, loop_t1
 SJMP main       ; Springe zurück zu main

output:
 MOVC A,@A+DPTR  ; Lädt den Akku mit Wert vom DPTR
 RET             ; Rücksprung aus dem Unterprogramm

ORG 50h
table:
 DB 3Fh, 06h, 5Bh, 4Fh, 66h, 6Dh, 7Dh, 07h, 7Fh, 6Fh
End
