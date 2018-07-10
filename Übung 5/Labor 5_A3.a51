ORG 00h
    SJMP start
ORG 03h
    SJMP isr
    
ORG 30h
start:
 SETB P3.2           ; S19 Schalter aktivieren
 SETB IT0            ; Interrupt - Ausloesung mit der fallenden Flanke an INT0
 SETB EX0             ; externen Interrupt 0 zulassen
 SETB EA             ;allgemeine Interruptfreigabe
 MOV DPTR,#0A0h      ;Die Adresse fuer Lookuptable wird auf 0A0h gesetzt 
 MOV R0,#00h         ;Auswahl der Daten der Lookuptable
 MOV R2,#11111110b ; Bits für die Auswahl der Spalte (hier Spalte 1) an R2 übertragen
 MOV R1,#0         ; Zähler für (1-6) auf 0 setzen

main:
 MOV A,R0          ; R0 in Akku laden um später mit DPTR zu addieren
 ACALL output      ; in Unterprogramm "output" springen

 MOV A,R2 ;        Die aktuelle Spalte an den Akku übertragen
 RL A ;            Akku nach Links rotieren um Spalte +1 zu erhalten
 MOV R2,A ;        Die um 1 erhöhte Spalte zurück in R2 speichern
 INC R0;           R0 um 1 erhöhen um nach den 8 geladenen Bytes ub den "timer" zu wechseln
 ACALL delay ;     Wechsel in das Unterprogramm "delay"
 CJNE R0,#8,main ; Springt, wenn R0 nicht gleich 8 ist zur "main"
 MOV R0,#00h      ; R0 wieder mit 0 laden um von vorne in der DB Reihe zu beginnen
 INC R1           ; R1 um 1 inkrementieren um auf die nächste Zahl (DB Reihe) zu springen
 CJNE R1,#06h,main ; Springt zurück zur Main bis wir "6" (letzte Zahl) erreicht haben um von vorne zu beginnen
 MOV R1,#00h      ; Ist die letzte Zahl fertig geladen, laden wir R1 wieder mit 0
 SJMP main

delay:
 MOV R6,#255 ;    R6 mit "255" laden
 here: ;      Sprungmarke für DJNZ
  DJNZ R6,here;R6 um 1 dekrementieren und springen wenn nicht 0 
  RET ;        Zurück zum Ausgangspunkt

output:
 MOVC A,@A+DPTR ;    Lädt den Akku mit dem Wert vom DPTR + Akku (R0)
 MOV P0,A ;          Spalte X Daten (zu aktivierende LED´s)
 MOV P2,R2 ;         Spalte X auswählen
 RET ;               Zurück zum Ausgangspunkt

isr:
 PUSH ACC ; Inhalt des Akkus retten
 MOV DPTR,#0A0h  ; DPTR nochmal setzen ?
 MOV A,R1  ;       Registerinhalt von R1 wird in den Akku geladen
 MOV B,#08h			;		Hilfsakku mit 8 füllen								
 MUL AB					; Hilfsakku mit Akku multiplizieren								
 ADD A,DPL				; addiere den Akku mit dem Datenpointer									
 MOV DPL,A       ; Ergebnis in den Datenpointer laden
 POP ACC ; Originalinhalt des Akkus wiederherstellen
 RETI

ORG 0A0h
db 00000000b, 00000000b, 00000000b, 00011000b, 00011000b, 00000000b, 00000000b, 00000000b; 1     
db 11000000b, 11000000b, 00000000b, 00000000b, 00000000b, 00000000b, 00000011b, 00000011b; 2     
db 11000000b, 11000000b, 00000000b, 00011000b, 00011000b, 00000000b, 00000011b, 00000011b; 3     
db 11000011b, 11000011b, 00000000b, 00000000b, 00000000b, 00000000b, 11000011b, 11000011b; 4   
db 11000011b, 11000011b, 00000000b, 00011000b, 00011000b, 00000000b, 11000011b, 11000011b; 5
db 11011011b, 11011011b, 00000000b, 00000000b, 00000000b, 00000000b, 11011011b, 11011011b; 6 

END