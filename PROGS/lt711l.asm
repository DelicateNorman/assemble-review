; lt711l.asm
	.model large,c
	extern sincall:far
	public asub
	.data
sinangle	dw 35
	.code
asub   proc
	mov ax,@data
	mov es,ax
	push es:sinangle
	call sincall
	add sp,2
	ret
asub	endp
	end
