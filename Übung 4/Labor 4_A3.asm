ORG 00h

start:
 MOV DPTR, #50h ; 
 MOV R0,#0 ; 
 MOV P1,#0FFh ; 
 MOV P3,#00h ;

main:
 MOV A,R0 ; 
 ACALL output ; 
 CPL A ; 
 MOV P1,A ; 
 INC R0 ; 
 CJNE R0,#4,wait ; 
 MOV R0,#0 ;

wait:

 SJMP main ; 
output:
 MOVC A,@A+DPTR ;
 RET ; 
ORG 50h

table:
 DB 3Fh, 06h, 5Bh, 4Fh
end