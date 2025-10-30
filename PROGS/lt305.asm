;lt305.asm
	.model tiny
	.code
	.startup
	mov dx,offset string
	mov ah,9
	int 21h
	mov ah,01h
	int 21h
	mov ah,02h
	mov dl,07h
	int 21h
	.exit 0
string	db 'Press any key to contiune !',0dh,0ah,'$'
	end
