
.model small
.stack 100h

.data 
prompt1 db 'The alphabets from A-Z: $'  

.code
main proc
    mov ax,@data
    mov ds,ax 
    
    lea dx,prompt1
    mov ah,09h
    int 21h 

    mov dl,0ah
    mov ah,02h
    int 21h

    mov dl,0dh
    mov ah,02h
    int 21h

    mov cx,26
    mov dx,65
    
    l1:
    mov ah,02h
    int 21h
    inc dx
    loop l1          

    mov ah,4ch
    int 21h

main endp
end main




