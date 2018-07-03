ORG 000h

start:
MOV DPTR,#50h ;  Die Adresse fuer Lookuptable wird auf 50h gesetzt 
MOV R0,#00h ;    Register R0 wird mit 0 geladen
MOV R1,#00h;     Register R1 wird mit 0 geladen
MOV R2,#11111110b ; Bits f�r die Auswahl der Spalte (hier Spalte 1) an R2 �bertragen
MOV R4,#00h
MOV R3,#48h 

main:
MOV A,R0  ;       Registerinhalt von R0 wird in den Akku geladen
ACALL output ;    Wechsel in den Interrupt "output"
MOV A,R2 ;        Die aktuelle Spalte an den Akku �bertragen
RL A ;            Akku nach Links rotieren um Spalte +1 zu erhalten
MOV R2,A ;        Die um 1 erh�hte Spalte zur�ck in R2 speichern
INC R1 ;          R0 um 1 erh�hen um sp�ter auf n�chten Wert in ORG 50h zu zugreifen
INC R0;           R0 um 1 erh�hen um nach den 8 geladenen Bytes ub den "timer" zu wechseln
ACALL delay ;     Wechsel in den Interrupt "delay"
CJNE R1,#8,main ; Springt, wenn R1 nicht gleich 8 ist zur "main"
SJMP timer;
next:
MOV R1,#00h ;     R1 wieder mit 00h laden
DEC R3
DJNZ R3,main
MOV R1,#00h
MOV R3,#48h
SJMP main ;       Jump zur "main"

delay:
MOV R6,#255 ;    R6 mit "255" laden
    here: ;      Sprungmarke f�r DJNZ
    DJNZ R6,here;R6 um 1 dekrementieren und springen wenn nicht 0 
    RET ;        Zur�ck zum Ausgangspunkt

output:
MOVC A,@A+DPTR ;    L�dt den Akku mit dem Wert vom DPTR
MOV P0,A ;          Spalte X Daten (zu aktivierende LED�s)
MOV P2,R2 ;         Spalte X ausw�hlen
RET ;               Zur�ck zum Ausgangspunkt

timer:
INC R4
CJNE R4,#255,main
MOV R4, #00h
SJMP next

ORG 50h
DB 00000000b, 00000000b, 00000000b, 00011000b, 00011000b, 00000000b, 00000000b, 00000000b
DB 00000011b, 00000011b, 00000000b, 00000000b, 00000000b, 00000000b, 11000000b, 11000000b
DB 00000011b, 00000011b, 00000000b, 00011000b, 00011000b, 00000000b, 11000000b, 11000000b
DB 11000011b, 11000011b, 00000000b, 00000000b, 00000000b, 00000000b, 11000011b, 11000011b
DB 11000011b, 11000011b, 00000000b, 00011000b, 00011000b, 00000000b, 11000011b, 11000011b
DB 11000011b, 11000011b, 00000000b, 11000011b, 11000011b, 00000000b, 11000011b, 11000011b



END