;lt302.asm
	.model small
	.stack
	.data
bvar	db 16
wvar	dw 4*3
dvar	dd 4294967295
qvar	dq ?
	db 1,2,3,4,5
tvar	dt 2345
abc	db 'a','b','c'
msg	db 'Hello',13,10,'$'
bbuf	db 12 dup('month')
dbuf	dd 25 dup(?)
CALLDOS	equ <int 21h>
	.code
	.startup
	mov bl,bvar
	mov ax,word ptr dvar[0]
	mov dx,word ptr dvar[2]
	mov dx,offset msg
	mov ah,09h
	CALLDOS
	.exit 0
	end
