
.MODEL SMALL
.STACK 100H   

.DATA
	prompt1 DB 10,13, "Enter your string : $"
	prompt2 DB 10,13, "Enter your substring that you want to be delete : $"
	prompt3 DB 10,13, "The string after deletion is : $"
	prompt4 DB 10,13, "Substring is not contained in string.$"
	STRING DB 50 DUP(?)
	SUBSTRING DB 50 DUP(?)
	NUM DW ?
	LEN1 DB ?
	LEN2 DB ?
	STARTINDEX DW ?
	ENDINDEX DW ? 
	
.CODE
	MOV AX, @DATA
	MOV DS, AX

	LEA DX, prompt1
	MOV AH, 09H
	INT 21H

	MOV SI, 0
	MOV CX, 0
	MOV AH, 01H
	IN1: INT 21H
		CMP AL, 0DH
		JE OUT1
		MOV STRING[SI], AL
		INC SI
		INC CX
	JMP IN1

	OUT1:
	MOV LEN1, CL
	LEA DX, prompt2
    MOV AH, 09H
    INT 21H

    MOV SI, 0
	MOV CX, 0
    MOV AH, 01H
    IN2: INT 21H
         CMP AL, 0DH
         JE OUT2
         MOV SUBSTRING[SI], AL
         INC SI
		 INC CX
    JMP IN2

	OUT2:

	MOV LEN2, CL

	MOV DH, 0
	MOV DL, LEN1
	SUB DL, LEN2
	ADD DL, 1

	MOV CH, 0
	MOV CL, LEN2

	MOV SI, 0
	EQUL: MOV STARTINDEX, SI
		MOV AL, STRING[SI]
		MOV BL, SUBSTRING[0]
		CMP AL, BL
		JNE NEXXTT

		MOV DI, 0
		EQULN:
			MOV AL, STRING[SI]
			MOV BL, SUBSTRING[DI]
			CMP AL, BL
			JNE NEXT
			ADD SI, 1
			ADD DI, 1
			LOOP EQULN
		NEXT: CMP CX, 0
			JBE FIND

			MOV SI, STARTINDEX
		NEXXTT:	INC SI
			MOV CH, 0
			MOV CL, LEN2

			DEC DX
		JNE EQUL

	JMP NOTFIND
	FIND: MOV CL, LEN1
		MOV BH, LEN2
		CMP CL, BH
		JB NOTFIND
   		LEA DX, prompt3
		MOV AH, 09H
		INT 21H

		SUB SI, 1
		MOV ENDINDEX, SI				;ENDINDEX WILL BE SI+LENGTH OF SUBSTRING

		MOV CH, 0
		MOV CL, LEN1

		MOV DI, 0
		MOV AH, 02H
		PRINT: CMP DI, STARTINDEX
			JB PRINTC
			CMP DI, ENDINDEX
			JA  PRINTC
			JMP NEXTT
			PRINTC:MOV DL, STRING[DI]
				INT 21H
			NEXTT: ADD DI, 1
		LOOP PRINT

		JMP EXITT

	NOTFIND: LEA DX, prompt4
		MOV AH, 09H
		INT 21H

	EXITT: MOV AH, 4CH
		INT 21H

OUTPUT PROC
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX

	MOV AX, NUM
	AND AL, 00001111B
	MOV BH, AL
	MOV AX, NUM
	AND AL, 11110000B
	RCR AL, 1
	RCR AL, 1
	RCR AL, 1
	RCR AL, 1

	MOV AH, 02H
	MOV DL, AL
	ADD DL, 30H
	INT 21H
	MOV DL, BH
	ADD DL, 30H
	INT 21H

	MOV DL, 0AH
	INT 21H
	MOV DL, 0DH
	INT 21H

	POP DX
	POP CX
	POP BX
	POP AX
	RET
OUTPUT ENDP

END
