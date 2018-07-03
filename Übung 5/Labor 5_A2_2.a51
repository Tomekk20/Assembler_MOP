ORG 000h

start:
MOV DPTR,#50h ;  Die Adresse fuer Lookuptable wird auf 50h gesetzt 
MOV R0,#00h ;    Register R0 wird auf 0 gesetzt
MOV R2,#11111110b ; Bits für die Auswahl der Spalte (hier Spalte 1) an R2 übertragen

main:
MOV A,R0  ;       Registerinhalt von R0 wird in den Akku geladen
ACALL output ;    Wechsel in den Interrupt "output"
MOV A,R2 ;        Die aktuelle Spalte an den Akku übertragen
RL A ;            Akku nach Links rotieren um Spalte +1 zu erhalten
MOV R2,A ;        Die um 1 erhöhte Spalte zurück in R2 speichern
INC R0 ;          R0 um 1 erhöhen um später auf nöchten Wert in ORG 50h zu zugreifen
ACALL delay ;     Wechsel in den Interrupt "delay"
CJNE R0,#8,main ; Springt, wenn R0 nicht gleich 8 ist zur "main"
MOV R0,#00h ;     R0 wieder mit 00h laden
SJMP main ;       Jump zur "main"

delay:
MOV R6,#255 ;    R6 mit "255" laden
    here: ;      Sprungmarke für DJNZ
    DJNZ R6,here;R6 um 1 dekrementieren und springen wenn nicht 0 
    RET ;        Zurück zum Ausgangspunkt

output:
MOVC A,@A+DPTR ;    Lädt den Akku mit dem Wert vom DPTR
MOV P0,A ;          Spalte X Daten (zu aktivierende LED´s)
MOV P2,R2 ;         Spalte X auswählen
RET ;               Zurück zum Ausgangspunkt

ORG 50h
DB 11000011b, 11000011b, 00000000b, 00011000b
DB 00011000b, 00000000b, 11000011b, 11000011b
END