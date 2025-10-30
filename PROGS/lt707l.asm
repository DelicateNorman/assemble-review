; lt707l.asm
	.model large,c
	.code
	public upper
upper	proc
	push si
	push di
	push ds
	push bp
	mov bp,sp
	lds si,[bp+16]
	les di,[bp+12]
	cld
	xor cx,cx
upper1:	lodsb
	cmp al,'a'
	jb upper2
	cmp al,'z'
	ja upper2
	sub al,20h
upper2:	stosb
	inc cx
	and al,al
	jnz upper1
	dec cx
	mov ax,cx
	pop bp
	pop ds
	pop di
	pop si
	ret
upper	endp
	end
