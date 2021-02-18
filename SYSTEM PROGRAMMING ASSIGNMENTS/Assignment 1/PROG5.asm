
.model small
.stack 100h

.data 
prompt1 db 'The program has started!$'  
prompt2 db 'The program is terminating!$'

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

    lea dx,prompt2
    mov ah,09h
    int 21h            

    mov ah,4ch
    int 21h

main endp
end main




