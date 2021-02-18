
.model small
.stack 100h

.data 
my_name db 'Name- Srestha Kanjilal$'  
prog_title db 'Program title- Program to print my name and program title$'

.code
main proc
    mov ax,@data
    mov ds,ax 
    
    lea dx,my_name
    mov ah,09h
    int 21h

    mov dl,0ah
    mov ah,02h
    int 21h

    mov dl,0dh
    mov ah,02h
    int 21h

    lea dx,prog_title
    mov ah,09h
    int 21h

    mov ah,4ch
    int 21h

main endp
end main
