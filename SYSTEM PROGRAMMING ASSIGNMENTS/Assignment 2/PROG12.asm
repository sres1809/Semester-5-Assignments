
.model small
.stack 100h
.data 
	prompt1 db 0AH,0DH,'Enter old filename: $'
	prompt2 db 0AH,0DH,'Enter new filename: $' 
	old db 80 dup('$') 
	new db 80 dup('$')
	prompt3 db 'has been renamed to $' 
    prompt4 db 'not found. ERROR!!!$' 

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
    mov es,ax 

	print prompt1
	lea SI, old
	call input

	print prompt2
	lea SI, new
	call input

    lea dx,old  ;ds:dx points to the ASCIIZ string old,0 
    lea di,new  ;es:di points to the ASCIIZ string new,0 
    mov ah,56h  ;DOS function 56h is used for renaming 
    int 21h 
    jc error    ;if there is an error carry flag is set 
    print old
	print prompt3 
	print new
    jmp exit 
error: 
	print old
    print prompt4 

exit:         
    mov ah,4ch 
    int 21h 
main endp

input proc near
read:
	mov ah, 01h
	int 21h
	cmp al, 13
	je done
	mov [SI],al
	inc SI
	jmp read

done:
    mov al, 0
    mov [SI],al
	ret
input endp

end main