;lt704l.asm
	.model large,c
	public min
	.code
min	proc
	push bp
	mov bp,sp
	mov ax,[bp+6]
	cmp ax,[bp+8]
	jle minexit
	mov ax,[bp+8]
minexit:	pop bp
	ret	
min	endp
	end
