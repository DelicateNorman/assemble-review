;lt705s.asm
.model small,c
PUBLIC adds
	.code
adds	proc
	push bp
	mov bp,sp
	mov ax,[bp+4]
	add ax,[bp+8]
	mov dx,[bp+6]
	adc dx,[bp+10]
	pop bp
	ret
adds	endp
	end