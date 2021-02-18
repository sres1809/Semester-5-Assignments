
.model small
.stack 300h
.data
prompt1 db 0AH,0DH,'Enter binary number: $'
prompt2 db 0AH,0DH,'Decimal equivalent: $'
prompt3 db 0AH,0DH,'Enter Decimal number: $'
prompt4 db 0AH,0DH,'Binary equivalent: $'

space db ' $'
endl db 0AH,0DH,'$'
binno db 17
	  db ?
	  db 17 dup(0)

str1 db 20 dup('$')
str2 db 20 dup('$')

.code

val1 dw ?
val2 dw ?

.code
print macro msg
	push ax
	push dx
	mov ah, 09h
	lea dx, msg
	int 21h
	pop dx
	pop ax
endm 

read macro memloc
	push ax
	push cx
	push dx
	mov ah, 0ah
	lea dx, memloc
	int 21h
	lea si, memloc + 1 ;NUMBER OF CHARACTERS ENTERED.
	mov cl, [si] ;MOVE LENGTH TO CL.
	mov ch, 0      ;CLEAR CH TO USE CX. 
	inc cx ;TO REACH CHR(13).
	add si, cx ;NOW SI POINTS TO CHR(13).
	mov al, '$'
	mov [si], al ;REPLACE CHR(13) BY '$'.            
	
	pop dx
	pop cx
	pop ax
endm

main proc
	mov ax,@data
	mov ds,ax

	print prompt1
	
	read binno; bin no strored in binno
	
	print  prompt2
	mov ax,0000h
	mov bx,0000h
	lea si, binno + 1
	mov cl, [si]
	mov ch, 00h
	inc si

	mov ax,00h
	
	loop1:
		mov bl, [si]
		sub bl, '0'
		mov bh, 00h
		mov dx,02h
		mul dx
		add ax, bx
		inc si
	loop loop1
	
	call output

	print endl
	print prompt3
	call input

	lea si, str1
	
	mov bh, 00
	mov bl,2
	
	loop2:
	div bl
	add ah,'0'
	mov byte ptr[si],ah
	mov ah, 00
	inc si
	inc bh
	cmp al,00
	jne loop2
	
	mov cl,bh
	lea si, str1
	lea di, str2
	mov ch, 00
	add si, cx
	dec si
	
	loop3:
	mov ah,byte ptr[si]
	mov byte ptr[di],ah
	dec si
	inc di
	loop loop3
	
	print prompt4
	print str2
	
	
	exit:
    mov ah, 4ch
    int 21h

main endp

input proc near
	; this procedure will take a number as input from user and store in AX
	; input : none
	
	; output : AX

	
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

output proc near
	; this procedure will display a decimal number
	; input : AX
	; output : none

	push ax
	push bx                        
	push cx                        
	push dx                        

	xor cx, cx
	mov bx, 0ah                     

	getnum:                       
		xor dx, dx                   
		div bx                       ; divide AX by BX
		push dx                      ; push remainder onto the STACK
		inc cx                       
		or ax, ax                    
	jne getnum                    

	mov ah, 02h                      ; set output function

	show:                      
		pop dx                       ; pop a value(remainder) from STACK to DX
		or dl, 30h                   ; convert decimal to ascii code
		int 21h                      
	loop show                  

	pop dx                         
	pop cx                         
	pop bx 
	pop ax

	ret                            
output endp

end main




