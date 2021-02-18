
.model small
.stack 100h

.data
prompt1  db  'Enter the number of array elements :',0dh,0ah,'$'
prompt2  db  'Enter the array elements :',0dh,0ah,'$'
prompt3  db  'The maximum is : $'
prompt4  db  'The minimum is : $'

array   dw  50 dup(0)    

s dw ?

.code
main proc

		mov ax, @data               
		mov ds, ax

		lea dx, prompt1             
		mov ah, 9     
		int 21h

		mov ah,1                                   
		int 21h

		input1:
		cmp al,0dh                                  
		je line1                                    

		and al,0fh                                  

		shl bx, 1
		shl bx, 1
		shl bx, 1
		shl bx, 1
		or  bl,al                                   

		int 21h
		jmp input1

		line1:     
		lea dx, prompt2             
		mov ah, 9     
		int 21h

		lea si, array                

		mov cx, bx                     


		@read_array:                   
		mov ah,1                                    
		int 21h

		xor dx,dx

		input2:
		cmp al,0dh                                  
		je line2                                  

		and al,0fh                                 

		shl dx,1
		shl dx,1
		shl dx,1
		shl dx,1
		or  dl,al                                   

		int 21h
		jmp input2

		line2:
		mov [si], dx                 
		add si, 2                    

		mov dl, 0ah                  
		mov ah, 2                    
		int 21h                      

		loop @read_array               

		lea si,array
		mov ax,bx
		dec ax
		xor bx,bx
		xor cx,cx
		mov bx,word ptr[si]	
		mov cx,word ptr[si]	
		
		add si, 2

	
		arrayloop2:

		cmp word ptr[si],bx
		jg maximum

		cmp word ptr[si],cx
		jl minimum

		jmp incre
		maximum:
		mov bx,word ptr[si]
		jmp incre

		minimum:
		mov cx,word ptr[si]

		incre:
		add si, 2
		dec ax

		jnz arrayloop2

		
		lea dx,prompt3
		mov ah,09h
		int 21h

		
		output:                                   

		mov dh,bh
		shr dh, 1
		shr dh, 1
		shr dh, 1
		shr dh, 1
		and dh,0fh

		add dh,'0'                               
		mov dl,dh
		mov ah,2
		int 21h

		mov dh,bh
		and dh,0fh
		add dh,'0'
		mov dl,dh
		mov ah,2
		int 21h

		mov dh,bl
		shr dh, 1
		shr dh, 1
		shr dh, 1
		shr dh, 1
		and dh,0fh
		add dh,'0'
		mov dl,dh
		mov ah,2
		int 21h

		mov dh,bl
		and dh,0fh
		cmp dh,10
		add dh,'0'
		mov dl,dh
		mov ah,2
		int 21h

		mov dl, 0ah                  
		mov ah, 2                    
		int 21h                      

		lea dx,prompt4	
		mov ah,09h
		int 21h

		
		mov bx,cx

		mov dh,bh
		shr dh, 1
		shr dh, 1
		shr dh, 1
		shr dh, 1
		and dh,0fh

		add dh,'0'                               
		mov dl,dh
		mov ah,2
		int 21h

		mov dh,bh
		and dh,0fh
		add dh,'0'
		mov dl,dh
		mov ah,2
		int 21h

		mov dh,bl
		shr dh, 1
		shr dh, 1
		shr dh, 1
		shr dh, 1
		and dh,0fh
		add dh,'0'
		mov dl,dh
		mov ah,2
		int 21h

		mov dh,bl
		and dh,0fh
		cmp dh,10
		add dh,'0'
		mov dl,dh
		mov ah,2
		int 21h


		exit:
		mov ah, 4ch                               
		int 21h

main endp
end main




