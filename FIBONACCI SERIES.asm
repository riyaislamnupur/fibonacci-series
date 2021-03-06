ORG 100H
.MODEL SMALL
.STACK 100H
.DATA 
R DB 'INPUT NUMBER $'
F DB 0
S DB 1
SUM DB ?
N DW ?
FAB DB 13,10,13,10,'FABANOCCI SERIES$'
.CODE
MAIN PROC

MOV DX,OFFSET R
MOV AH,9 ;PRINTING A STRING
INT 21H

;INPUT CODE STARTS HERE
MOV N,0 ;N = 0
MOV BL,10 ;BL = 10
INPUT:
MOV AH,1 ;TAKE INPUT
INT 21H
CMP AL,13 ;IF(INPUT == ENTER) 
JE NEXT ;JUMP EQUAL TO
SUB AL,30H
MOV AH,0
MOV CX,AX ;CX = AX
MOV AX,N ;AX = N
MUL BL ;AX = AX BL
ADD AX,CX ;AX = AX + CX
MOV N,AX ;N = AX
JMP INPUT
;INPUT CODE ENDS HERE

NEXT:
LEA DX,FAB 
MOV AH,9
INT 21H

MOV CX,N ;CX = N
L:

PUSH CX

MOV DL,10 
MOV AH,2
INT 21H

MOV DL,13
MOV AH,2
INT 21H

MOV BL,F ;BL = F = 0
ADD BL,S ;BL = BL + S
MOV SUM,BL ;SUM = BL

;OUTPUT CODE STARTS HERE
MOV AH,0 ;AH = 0
MOV AL,SUM ;AL = SUM 

;DISPLAY
MOV DX,0
MOV BX,10
MOV CX,0
L1:
DIV BX
PUSH DX
MOV DX,0
MOV AH,0 ;AX AH 00000000 AL=QUOTIENT
INC CX
CMP AX,0
JNE L1
MOV AH,2
L2:
POP DX
ADD DX,48
INT 21H
LOOP L2

;OUTPUT CODE ENDS HERE

MOV BL,S ;BL = S
MOV F,BL ;F = BL F = S

MOV BL,SUM ;BL = SUM
MOV S,BL ;S = BL

POP CX
LOOP L

RET

MAIN ENDP
END MAINP
