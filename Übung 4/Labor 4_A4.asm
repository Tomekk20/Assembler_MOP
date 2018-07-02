ORG 00h

start:
 MOV DPTR, #50h ; Die Adresse für Lookuptable wird auf 50h gesetzt
 MOV R0,#3      ;
 MOV R1,#4 
 MOV P0,#0FFh   ; die LEDs/Segementanzeige P1 wird auf aktiv gesetzt
 MOV P2,#07h    ; die rechte Segmentanzeige wird gesetzt

Segment0:
 CLR P3.7       ; Schalte Segment aus
 MOV P2,#07h    ; Wähle Segment 0 aus
 MOV A, R0      ; Kopiere die Zahl in den Akku
 ACALL output   ; Lädt den Akku mit der umgewandelten Zahl
 MOV P0, A      ; Übertragung der Zahl zum Segment
 SETB P3.7      ; Gebe Segement Frei
 ACALL timer    ; Verzögerung von 10ms
 SJMP Segment1  ; Springe zum Segment1

Segment1:
 CLR P3.7       ; Schalte Segment aus
 MOV P2,#06h    ; Wähle Segment 1 aus
 MOV A, R1      ; Kopiere die Zahl in den Akku
 ACALL output   ; Lädt den Akku mit der umgewandelten Zahl
 MOV P0, A      ; Übertragung der Zahl zum Segment
 SETB P3.7      ; Gebe Segement Frei
 ACALL timer    ; Verzögerung von 10ms
 SJMP Segment0  ; Springe zum Segment1

ORG 300h
; Timer 100ms
timer:
  MOV R2, #1
 loop_t1:
  MOV R3, #50
 loop_t2:
  MOV R4, #50
 loop_t3:
  NOP
  NOP
  DJNZ R4, loop_t3
  DJNZ R3, loop_t2
  DJNZ R2, loop_t1
 RET
 
output:
 MOVC A,@A+DPTR  ; Lädt den Akku mit Wert vom DPTR
 RET             ; Rücksprung aus dem Unterprogramm

ORG 50h
table:
 DB 3Fh, 06h, 5Bh, 4Fh, 66h, 6Dh, 7Dh, 07h, 7Fh, 6Fh
End
