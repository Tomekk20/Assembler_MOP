SETB P1.7       ; aktiviere P1.7
MOV P0, #0FFh 	; konfiguriere Port 0 als Eingang
MOV P3, #0FFh 	; konfiguriere Port 3 als Eingang
loop:
 JNB P3.2, cton	; Wenn S19 gedr�ckt wird (0), dann springe zum cton
 JNB P3.3, eton	; Wenn S18 gedr�ckt wird (0), dann springe zum eton
 JNB P3.4, gton	; Wenn S17 gedr�ckt wird (0), dann springe zum gton
 SJMP skip

cton:
 CLR P1.7 		  ; Buzzer an
 CLR P0.7       ; LED 8 an
 MOV A, #107    ; "107" in den Akku f�r den Interrupt
ton1:           ; Schleife um den Ton aufrecht zu halten
 ACALL timer    ; in den Interrupt wechseln
 JNB P3.2, ton1 ; Falls S19 noch gedr�ckt ist wieder in den Interrupt
 SJMP loop 		; zur�ck zu Loop

eton:
 CLR P1.7 		  ; Buzzer an
 CLR P0.6       ; LED 7 an
 MOV A, #84     ; "84" in den Akku f�r den Interrupt
ton2:           ; Schleife um den Ton aufrecht zu halten
 ACALL timer    ; in den Interrupt wechseln
 JNB P3.3, ton2 ; Falls S18 noch gedr�ckt ist wieder in den Interrupt
 SJMP loop		; zur�ck zum loop

gton:
 SETB P1.7		  ; Buzzer an
 CLR P0.5       ; LED 6 an
 MOV A, #70     ; "70" in den Akku f�r den Interrupt
ton3:           ; Schleife um den Ton aufrecht zu halten
 ACALL timer    ; in den Interrupt wechseln
 JNB P3.4, ton3 ; Falls S17 noch gedr�ckt ist wieder in den Interrupt
 SJMP loop		  ; zur�ck zum loop

skip:
 SETB P0.7 		; LED 8 aus
 SETB P0.6		; LED 7 aus
 SETB P0.5		; LED 6 aus
 SJMP loop 		; zur�ck zu Loop

timer:
 MOV R1, A      ; Akkuinhalt in R1 schreiben
 loop2:
 DJNZ R1, loop2 ; Dekrementieren und erst verlassen, wenn R1 null ist
 CPL P1.7       ; Buzzer aus
 RET            ; zur�ck zum Ausgangspunkt

end