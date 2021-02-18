
.MODEL SMALL
.STACK 300H
.DATA    
ARRAY1 DB 50 dup(0)
prompt1 DB 0AH,0DH,'Enter size of the array: $'
prompt2 DB 0AH,0DH,'Enter array elements: $'
prompt3 DB 0AH,0DH,'Enter element to be searched: $'
prompt4 DB 0AH,0DH,'Element found at position: $ '
prompt5 DB 0AH,0DH,'Element not found in the array$'
ENDL DB 0AH,0DH,'$'

SE DB 00H
COUNT DB 00H

.CODE

PRINT MACRO MSG
	push ax
	push dx
	mov AH, 09H
	lea DX, MSG
	int 21H
	pop dx
	pop ax
ENDM

MAIN PROC
	MOV AX,@DATA
	MOV DS,AX

	PRINT prompt1
	call input
	mov COUNT, al
	mov cl, COUNT
	mov bx, 00h
	PRINT prompt2
	rdnxt:
		call input
		mov ARRAY1[BX],AL
		inc BX
	loop rdnxt
	
	mov cl, COUNT
	PRINT prompt3
	call input
	mov se,al
	mov al,se
	mov ah,00h
	LEA SI, ARRAY1
	mov bh, 00h    
	
LINEARSEARCH:
	MOV BL,[SI]
	CMP AL, BL
	JZ FOUND
	INC SI
	inc bh
	loop LINEARSEARCH
	PRINT prompt5
	JMP END1
 
FOUND:
	PRINT prompt4 
	add bh, 01
	mov al, bh
	call output
 
END1:
	mov ah, 4ch
	int 21h

MAIN ENDP


input proc near
	
	push bx
	push cx
	mov cx,0ah
	mov bx,00h
loopnum: 
	mov ah,01h
	int 21h
	cmp al,'0'
	jb skip
	cmp al,'9'
	ja skip
	sub al,'0'
	push ax
	mov ax,bx
	mul cx
	mov bx,ax
	pop ax
	mov ah,00h
	add bx,ax
	jmp loopnum
skip:
	mov ax,bx
	pop cx
	pop bx
	ret
input endp

output PROC near
   ; this procedure will display a decimal number
   ; input : AX
   ; output : none

   push bx                        ; push BX onto the STACK
   push cx                        ; push CX onto the STACK
   push dx                        ; push DX onto the STACK

   XOR CX, CX                     ; clear CX
   MOV BX, 10                     ; set BX=10

   GETNUM:                       ; loop label
     XOR DX, DX                   ; clear DX
     DIV BX                       ; divide AX by BX
     PUSH DX                      ; push DX onto the STACK
     INC CX                       ; increment CX
     OR AX, AX                    ; take OR of Ax with AX
   JNE GETNUM                    ; jump to label @OUTPUT if ZF=0

   MOV AH, 2                      ; set output function

   SHOW:                      ; loop label
     POP DX                       ; pop a value from STACK to DX
     OR DL, 30H                   ; convert decimal to ascii code
     INT 21H                      ; print a character
   LOOP SHOW                  ; jump to label @DISPLAY if CX!=0

   POP DX                         ; pop a value from STACK into DX
   POP CX                         ; pop a value from STACK into CX
   POP BX                         ; pop a value from STACK into BX

   RET                            ; return control to the calling procedure
output ENDP
	
END MAIN




