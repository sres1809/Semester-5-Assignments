
.model small
.stack 100h

.data
prompt1 DB 13,"Enter the dividend (16bit): $"
prompt2 DB 13,"Enter the divisor (8bit): $"
prompt3 DB 13,"Quotient is: $"
prompt4 DB 10,"Reminder is: $"
dividend DW ?
divisor DB ?
quotient DW ?
reminder Dw ?
num16 DW ?

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
    call input16
    mov dividend,ax

    print prompt2
    call input8
    mov divisor,al

    ;performing division
    mov ax,dividend
    mov dx,00
    mov bl,divisor
    mov bh,0
    div bx
    mov quotient,ax
    mov reminder,dx

    ;output quotient
    print prompt3
    mov ax,quotient
    mov num16,ax
    call output

    ;output reminder
    print prompt4
    mov ax,reminder
    mov num16,ax
    call output

    mov ah,4ch
    int 21h
main endp


;fucntion to take in character
getChar proc
    mov ah,1
    int 21h
    ret
getChar endp

;function to take 16 bit number input
input16 proc
    push cx
    push dx

    mov dx, 0000
    mov ax, 0000
    mov cl, 4
    
    getnum1:

    call getChar
    cmp al, 13
    je done1
    cmp al, 10
    je done1

    shl dx,cl
    sub al, 48
    cmp al, 9
    jle isNum5
    sub al, 7

    isNum5:
    or dl, al

    jmp getnum1

    done1:
    mov ax, dx

    pop dx
    pop cx
    ret
input16 endp

; program to output a 16 bit number stored in num16
output proc
    push cx
    push dx


    mov cl, 4
    mov dx, num16
    mov dl,dh
    shr dl,cl
    and dl, 0fh
    cmp dl,0ah
    jl isNum1
    add dl,7
    isNum1:
    add dl,48
    mov ah, 2
    int 21h

    mov dx, num16
    mov dl,dh
    and dl, 0fh
    cmp dl, 0ah
    jl isNum2
    add dl, 07h
    isNum2:
    add dl,48
    mov ah, 2
    int 21h


    mov cl, 4
    mov dx, num16
    shr dl,cl
    and dl, 0fh
    cmp dl,0ah
    jl isNum3
    add dl,7
    isNum3:
    add dl,48
    mov ah, 2
    int 21h

    mov dx, num16
    and dl, 0fh
    cmp dl, 0ah
    jl isNum4
    add dl, 07h
    isNum4:
    add dl,48
    mov ah, 2
    int 21h

    pop dx
    pop cx
    ret
output endp

;function to take number input 8bit
input8 proc
    push cx
    push dx

    mov dl, 00
    mov cl, 04
    
    getnum2:

    call getChar
    cmp al, 13
    je done2
    cmp al, 10
    je done2

    shl dl,cl
    sub al, 48
    cmp al, 9
    jle isNum6
    sub al, 7

    isNum6:
    or dl, al
    
    jmp getnum2

    done2:
    mov al, dl
    pop dx
    pop cx
    ret
input8 endp

end