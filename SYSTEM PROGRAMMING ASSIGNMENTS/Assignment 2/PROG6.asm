
.model small
.stack 300h
.data
prompt db 0AH,0DH,'First 10 numbers in the Fibonacci sequence: $'
space db ' $'
endl db 0AH,0DH,'$'


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
	
	mov bx, 00h
	mov dx, 01h
	mov cl, 10
	mov ch, 00h
	mov ax, 00h
	print prompt
	print endl
	loop1:
		mov ax, bx
		call output
		print space
		add ax, dx
		mov dx, bx
		mov bx, ax
	loop loop1
	
	exit:
    mov ah, 4ch
    int 21h

main endp


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



