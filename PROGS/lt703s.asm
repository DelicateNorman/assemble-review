;lt703s.asm
	.model small,c
	.data
msg	db 'Hello, C and Assembly !',0dh,0ah,'$'
	.code
	PUBLIC display
display	proc
	mov ah,9
	mov dx,offset msg
	int 21h
	ret
display	endp
	end
