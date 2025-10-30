;lt413.asm
	.model small
	.stack
	.data 
string1	db 'equal or not'
string2	db 'eQual or not'
	.code
	.startup
	mov ax,ds
	mov es,ax
	mov cx,lengthof string1
	mov si,offset string1
	mov di,offset string2
	cld
	repz cmpsb
	jne unmat
	mov dl,'Y'
	jmp output
unmat:	mov dl,'N'
output:	mov ah,2
	int 21h
	.exit 0
	end
