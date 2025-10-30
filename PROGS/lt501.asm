;lt501.asm
	.model small
	.stack
	.data
_a	sbyte ?
_b	sbyte ?
_c	sbyte ?
tag	byte ?
	.code
	.startup
	mov al,_b
	imul al
	mov bx,ax
	mov al,_a
	imul _c
	mov cx,4
	imul cx
	.if sword ptr bx >= ax
	    mov tag,0
	.else
	    mov tag,1
	.endif
	.exit 0
	end
