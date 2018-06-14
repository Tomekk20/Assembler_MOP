
;
$DATE (04.06.2018)
$TITLE ( )
$PAGELENGTH(56)
$PAGEWIDTH(150)
$DEBUG
$XREF
$NOLIST
$MOD51
$LIST
;

MOV P0, #0FFh
SETB P3.2
lock:
 SETB P0.2;
 CPL P0.0;
 SJMP loop2;
loop2:
 JB P3.2, loop2 ;
lock1:
 JNB P3.2, lock1 ;
 MOV A, #8;
 LCALL delay;
 SETB P0.0 ;
 CPL P0.4;
 MOV A, #12
 LCALL delay;
 CPL P0.4;
 CPL P0.2;
 MOV A, #4
 LCALL delay;
 SJMP lock;
 
 ORG 300h
 delay:
	MOV R1, A
 loop3:
	MOV R2, #250
 loop4:
	MOV R3, #250
 loop5:
	NOP
	NOP
	DJNZ R3,loop5
	DJNZ R2,loop4
	DJNZ R1,loop3
  RET 
End
