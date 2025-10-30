;lt411.asm
	.model tiny
	.code
	.startup
	mov dx,0b800h
	mov es,dx
	mov di,0
	mov cx,25*80
	mov ax,0720h
	cld
	rep stosw
	.exit 0
	end
