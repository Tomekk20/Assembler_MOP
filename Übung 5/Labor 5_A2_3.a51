ORG 000h

start:
 MOV DPTR,#50h ;  Die Adresse fuer Lookuptable wird auf 50h gesetzt 
 MOV R0,#00h ;    Auswahl der Daten der DB
 MOV R1,#0;       Auswahl der Spalte f�r DB
 MOV R2,#11111110b ; Bits f�r die Auswahl der Spalte (hier Spalte 1) an R2 �bertragen
 MOV R4,#0         ; R4 mit 0 zur Sicherheit mit 0 laden
 MOV R3,#1         ; R3 mit der "ersten Zahl" laden

main:
 MOV A,R0  ;       Registerinhalt von R0 wird in den Akku geladen
 ADD A,R1 ;        R1 wird in den akktuellen Akkuinhalt addiert
 ACALL output ;    Wechsel in das Unterprogramm "output"
 MOV A,R2 ;        Die aktuelle Spalte an den Akku �bertragen
 RL A ;            Akku nach Links rotieren um Spalte +1 zu erhalten
 MOV R2,A ;        Die um 1 erh�hte Spalte zur�ck in R2 speichern
 INC R0;           R0 um 1 erh�hen um nach den 8 geladenen Bytes ub den "timer" zu wechseln
 ACALL delay ;     Wechsel in den Interrupt "delay"
 CJNE R0,#8,main ; Springt, wenn R1 nicht gleich 8 ist zur "main"
 MOV R0,#0        ; R0 wieder mit 0 laden um von vorne zu beginnen
 SJMP timer;       ; zum Timer springen um die LED aufleuchten zu lassen

next:
 MOV A,R1 ;     R1 wieder mit 00h laden
 ADD A, #8      ; addiere den Akkuinhalt mit 8 um den richtigen DB Wert zu erhalten
 MOV R1, A      ; Akkuinhalt wieder in R1 laden
 INC R3          ; R3 inkrementieren
 CJNE R3,#7, main  ; springe zur "main" bis wir "7" erreicht haben um 1-6 zu zeigen
 MOV R1,#0        ; mit 0 laden um von vorne zu beginnen
 MOV R3,#1        ; mit 0 laden um von vorne zu beginnen
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
 INC R4             ;inkrementiere R4
 CJNE R4,#255,main  ;springe zur "main" um die aktuelle Zahl immer wieder zu laden bis 255 erreicht ist
 MOV R4, #0         ;R4 wieder nullen f�r die n�chste Zahl
 SJMP next          ;zu "next" springen um die n�chste Zahl vorzubereiten

ORG 50h
DB 00000000b, 00000000b, 00000000b, 00011000b, 00011000b, 00000000b, 00000000b, 00000000b; 1
DB 11000000b, 11000000b, 00000000b, 00000000b, 00000000b, 00000000b, 00000011b, 00000011b; 2
DB 11000000b, 11000000b, 00000000b, 00011000b, 00011000b, 00000000b, 00000011b, 00000011b; 3
DB 11000011b, 11000011b, 00000000b, 00000000b, 00000000b, 00000000b, 11000011b, 11000011b; 4
DB 11000011b, 11000011b, 00000000b, 00011000b, 00011000b, 00000000b, 11000011b, 11000011b; 5
DB 11011011b, 11011011b, 00000000b, 00000000b, 00000000b, 00000000b, 11011011b, 11011011b; 6



END