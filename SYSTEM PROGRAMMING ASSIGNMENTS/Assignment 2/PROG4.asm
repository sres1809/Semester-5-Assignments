
.model small
.stack 100h

.data
prompt1 db "Enter number 1: $"
prompt2 db "Enter number 2: $"
prompt3 db "Product of the 2 numbers: $"
numA dw ?
     dw ?
numB dw ?
     dw ?
result dw 0, 0, 0, 0
endl db 0AH,0DH,"$"
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
        mov numA,ax
        
        call input
        mov numA+2,ax
        
        print prompt2 
        call input
        mov numB,ax
        
        call input
        mov numB+2,ax
        
        print prompt3

        mov ax, numA+2
        mul numB+2
        mov result+6,ax
        mov result+4,dx

        mov ax,numA+2
        mul numB
        add result+4,ax
        adc result+2,dx
        adc result, 0

        mov ax,numA
        mul numB+2
        add result+4,ax
        adc result+2,dx
        adc result, 0

        mov ax,numA
        mul numB
        add result+2,ax
        adc result,dx

        mov ax, result
        call output
        
        mov ax, result+2
        call output
        
        mov ax, result+4
        call output
        
        mov ax, result+6
        call output 
        print endl

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
	sub bx, cx  
	jz show
	loop1:  
	    mov dl, 00h
	    or dl, 30h
	    int 21h
	    dec bx
	jnz loop1
	                     

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