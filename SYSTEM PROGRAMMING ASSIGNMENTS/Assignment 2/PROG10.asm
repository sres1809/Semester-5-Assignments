
.model small
.stack 300h
.data
msg1 db 0AH,0DH,'The list of prime numbers between 1 and 100: $'
endl db 0AH,0DH,'$'
space db ' $'
val db 03h
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

	print msg1
	print endl
	
	mov ax, 02h
	call output
	print space
	
	loop2:
	    mov cl, 02h
	    mov bl, 00h
	    loop1:
	        mov al, val
	        mov ah, 00h
	        div cl
	        cmp ah, 00h
	        jz notp
	        inc cl
	        cmp cl, val
	    jnz loop1
	    
	    mov al, val
	    mov ah, 00h
	    call output
	    print space
	    
	    notp:
	       mov al, val
	       add al, 01h
	       mov val, al
	    cmp al, 64h
	    jnz loop2	

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
