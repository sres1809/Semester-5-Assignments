
.model small
.stack 300h
.data
array1 db 50 dup(0)
prompt1 db 0AH,0DH,'Enter size of the array: $' 
prompt2 db 0AH,0DH,'Enter array elements (in ascending order): $'
prompt3 db 0AH,0DH,'Enter element to be searched: $'
prompt4 db 0AH,0DH,'Element found at position $ '
prompt5 db 0AH,0DH,'Element not found$'
endl db 0AH,0DH,'$'
se db 00h
count db 00H

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

main proc
	mov ax,@data
	mov ds,ax

	print prompt1
	call input
	mov count, al
	mov cl, count
	mov bx, 00h  
	print prompt2
	print endl
	rdnxt:
		call input
		mov array1[bx],al
		inc bx
	loop rdnxt
	
	mov cl, count
	print prompt3
	call input
	mov se,al
	mov al,se
	mov ah,00h
	lea si, array1
	mov ch, count
	mov cl, 00h
	
	LOOP1:
		cmp cl, ch
		ja NOTFOUND
		mov bl, cl
		mov bh, 00h
		add bl, ch
		sar bl, 1
		mov bh, 00h
		cmp al, array1[bx]
		jz FOUND
		ja upcall
		downcall:
		mov ch, bl
		dec ch
		jmp loop1
		upcall:
		mov cl, bl
		inc cl
		jmp LOOP1
	
	
NOTFOUND:
	print prompt5
	jmp end1
 
FOUND:
	print prompt4
	mov al, bl 
	add al, 1
	call output
 
end1:
	mov ah, 4ch
	int 21h

main endp

input proc near
	; this procedure will take a number as input from user and store in AL
	; input : none
	; output : AL

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

	ret                            
output endp
	
end main