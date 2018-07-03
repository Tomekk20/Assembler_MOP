ORG 000h
start:
 MOV DPTR,#50h ;
 MOV R0,#00h ;
 MOV R2,#11111110b ;

main:
 MOV A,R0 ;
 ACALL output ;
 MOV A,R2 ;
 RL A ;
 MOV R2,A ;
 INC R0 ;
 ACALL delay ;
 CJNE R0,#8,main ;
 MOV R0,#00h ;
 SJMP main ;

delay:
 MOV R6,#255 ;

here:
 DJNZ R6,here ;
 RET ;

output:
 MOVC A,@A+DPTR ;
 MOV P0,A ;
 MOV P2,R2 ;
 RET ;

ORG 50h
DB 11000011b, 11000011b, 00000000b, 00011000b
DB 00011000b, 00000000b, 11000011b, 11000011b
END