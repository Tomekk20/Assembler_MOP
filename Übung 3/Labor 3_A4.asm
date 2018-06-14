
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

MOV P1, #00Fh
SETB P3.2

loop:
JB P3.2, loop

lock:
JNB P3.2, lock
CPL P0.0
SJMP loop

End
