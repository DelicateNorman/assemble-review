;lt704s.asm
	.model small,c
	public min
	.code
min	proc
	push bp
	mov bp,sp
	mov ax,[bp+4]
	cmp ax,[bp+6]
	jle minexit
	mov ax,[bp+6]
minexit:	pop bp
	ret	
min	endp
	end
