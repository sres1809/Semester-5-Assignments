
.model small
.stack 100h

.data
prompt db 0AH,0DH,'Pair of even numbers whose sum is 100: $'
endl db 0AH,0DH,'$'

.code 

main proc
    mov ax,@data
    mov ds,ax
    mov bx,0
    mov cx,100
    
    lea dx,prompt
    mov ah,09h
    int 21h
    
    lea dx,endl
    mov ah,09h
    int 21h
    
    loop1:
    mov dl,40
    mov ah,2
    int 21h

    mov ax,bx
    call output

    mov dl,44
    mov ah,2
    int 21h

    mov ax,cx
    call output

    mov dl,41
    mov ah,2
    int 21h

    mov dl,32
    mov ah,2
    int 21h

    inc bx
    inc bx

    dec cx
    dec cx

    cmp bx,50
    jle loop1
    
    mov ah,4ch
    int 21h
main endp

; program to output a number stored in num
output proc
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

end

