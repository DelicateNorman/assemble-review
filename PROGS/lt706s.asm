;lt706s.asm
	.model small,c
	.code
	PUBLIC plus
plus	proc
	push bp
	mov bp,sp
	mov bx,[bp+4]
	mov ax,[bx]
	inc ax
	mov [bx],ax
	pop bp
	ret
plus	endp
	end