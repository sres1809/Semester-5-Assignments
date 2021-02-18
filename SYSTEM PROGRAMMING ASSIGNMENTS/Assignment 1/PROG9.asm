
.model small
.stack 100h  

.data
prompt1 db 0dh, 0ah, "Enter Y to exit: ", "$"
prompt2 db 0dh, 0ah, "Still in loop...", "$" 

.code
main proc
    mov ax,@data
    mov ds,ax

    loop1:
    lea dx,prompt2
    mov ah,09h
    int 21h
    
    lea dx,prompt1
    mov ah,09h
    int 21h

    mov ah,01h
    int 21h
    cmp al,'Y'
    jne loop1
    mov ah,4ch
    int 21h
main endp
end




