
.model small
.stack 300h
.data
prompt1 db 0AH,0DH,'Enter 1st number: $'
prompt2 db 0AH,0DH,'Enter 2nd number: $'
prompt3 db 0AH,0DH,'The result after addition is: $'
prompt4 db 0AH,0DH,'The result after substraction is: $'
space db ' $'
endl db 0AH,0DH,'$'

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

main proc
	mov ax,@data
	mov ds,ax
	
	print prompt1
	
	call input
	mov val1, ax

	print prompt2

	call input
	mov val2, ax

	print prompt3
        mov ax, val1
        mov bx, val2
        add ax,bx
	call output

    print prompt4
    
    mov ax, val1
    mov bx, val2
    sub ax,bx
    call output    
	
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



