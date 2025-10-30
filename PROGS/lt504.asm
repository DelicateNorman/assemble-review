;lt504.asm
mainbegin	MACRO
	mov ax,@data
	mov ds,ax
	ENDM
mainend	MACRO retnum
	mov al,retnum
	mov ah,4ch
	int 21h
	ENDM
dispmsg	MACRO message
	lea dx,message
	mov ah,09h
	int 21h
	ENDM
	.model small
	.stack
	.data
string	db 'Hello, Everybody !',0dh,0ah,'$'
	.code
start:	mainbegin
	dispmsg string
	mainend 0
	end start
