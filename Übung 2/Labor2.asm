MOV P1, #0FFh; LEDs initial.

MOV R0, #14; Wert G1
MOV R1, #11; Wert H1
MOV R2, #8;  Wert G2
MOV R3, #12; Wert H2

;Berechnung der 1. Dreiecksflaeche
CLR A
MOV A, R0
MOV B, R1
MUL AB; Multiplikation vom Akku und B
CLR C; für RRC
RRC A; Division durch 2
MOV R4, A; Zwischenergebnis 1

;Berechnung der 2. Dreiecksflaeche
CLR A
MOV A, R2
MOV B, R3
MUL AB
CLR C
RRC A
MOV R5, A; Zwischenergebnis 2

;Addition der 2 Dreiecksflaechen
ADD A, R4; Ergebnis

;Darstellung als LED-Kette
CPL A; Invertiere A
MOV P1, A
