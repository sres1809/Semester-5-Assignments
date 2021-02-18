

.model small
.stack 100h

.data 
prompt1 db 'Enter an upper case character:$'  
prompt2 db 'The corresponding lower case character:$'

.code
main proc
    mov ax,@data
    mov ds,ax 
    
    lea dx,prompt1
    mov ah,09h
    int 21h 
    
    mov ah,01h
    int 21h
    
    mov dl,al
    add dl,32
    mov bl,dl

    mov dl,0ah
    mov ah,02h
    int 21h

    mov dl,0dh
    mov ah,02h
    int 21h

    lea dx,prompt2
    mov ah,09h
    int 21h       
    
    mov dl,bl
    mov ah,02h
    int 21h

    mov ah,4ch
    int 21h

main endp
end main




