CLR RS0			; setzt im PSW den bit an RS0 auf 0
CLR RS1			; setzt im PSW den bit an RS1 auf 0
			; = Registerbank 0
MOV P2, #0FFh		; setzt P2 auf aktiv
MOV A, #0h		; Akkumulator wird geloescht
MOV SP, #4Fh		; Stackpointeradresse auf 0x4F gesetzt

JMP2:
 CJNE A, P2, JMP1	; Springt zu JMP1 wenn Akku und P2 ungleich
 SJMP JMP2		; Springe zurueck zu JMP2

JMP1:
 MOV R4, #0h		; Register 4 wird genullt
 MOV R7, #8h		; Register 7 auf den Wert 0x8
 MOV A, P2		; P2 Zustand auf Akku Uebertragen

JMP4:
 RLC A			; Akku wird links rotiert mit Carry
 JC JMP3		; Springe zu JMP3 wenn Carry high
 INC R4			; Inkrementiere R4 (+1)

JMP3:
 DJNZ R7, JMP4		; Dekrementiere R7 und Springe zu JMP4, wenn keine 0 im R7
 PUSH R4		; 
 RLC A			; Akku wird links rotiert mit Carry
 SJMP JMP2		; Springe zurueck zu JMP2

END 
