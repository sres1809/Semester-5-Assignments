
.model small
.stack 100h

.data
prompt1 DB 13,"Enter first 16 bit number: $" 
prompt2 DB 13,"Enter second 16 bit number: $"
num1 DW ?
num2 DW ?
num DW ?
sum DW ?
sumCarry DW 00h
prompt3 DB 10,"The sum is: $"

.code
mov ax,@data
mov ds,ax
call main
mov ah,4ch
int 21h
 
 
main proc

    lea dx, prompt1
    mov ah,09h
    int 21h
    
    call getNum
    mov num1,ax  
    
    mov dl,0ah
    mov ah,02h
    int 21h
    
    mov dl,0dh
    mov ah,02h
    int 21h

    lea dx, prompt2
    mov ah,09h
    int 21h
    
    call getNum
    mov num2,ax

    mov ax,num1
    add ax,num2
    jnc noCarry
    inc sumCarry
    noCarry:
    mov sum,ax

    lea dx,prompt3
    mov ah,09h
    int 21h
    
    mov ax,sumCarry
    mov num,ax
    call outputNum 
    
    mov ax,sum
    mov num,ax
    call outputNum

    ret
main endp


getNum proc
    push cx
    push dx

    mov dx, 0000
    mov ax, 0000
    mov cl, 4
    
    getNumber:

    call getChar
    cmp al, 13
    je inputDone
    cmp al, 10
    je inputDone

    shl dx,cl
    sub al, 48
    cmp al, 9
    jle isNumber
    sub al, 7

    isNumber:
    or dl, al

    jmp getNumber

    inputDone:
    mov ax, dx

    pop dx
    pop cx
    ret
getNum endp


getChar proc
    mov ah,1
    int 21h
    ret
getChar endp


outputNum proc
    push cx
    push dx


    mov cl, 4
    mov dx, num
    mov dl,dh
    shr dl,cl
    and dl, 0fh
    cmp dl,0ah
    jl isNumber4
    add dl,7
    isNumber4:
    add dl,48
    mov ah, 2
    int 21h

    mov dx, num
    mov dl,dh
    and dl, 0fh
    cmp dl, 0ah
    jl isNumber3
    add dl, 07h
    isNumber3:
    add dl,48
    mov ah, 2
    int 21h


    mov cl, 4
    mov dx, num
    shr dl,cl
    and dl, 0fh
    cmp dl,0ah
    jl isNumber2
    add dl,7
    isNumber2:
    add dl,48
    mov ah, 2
    int 21h

    mov dx, num
    and dl, 0fh
    cmp dl, 0ah
    jl isNumber1
    add dl, 07h
    isNumber1:
    add dl,48
    mov ah, 2
    int 21h

    pop dx
    pop cx
    ret
outputNum endp

end



