;lt412.asm
	.model small
	.stack
	.data 
block	db 12,-87,63,85,0,-32
count	equ lengthof block
dplus	db count dup(?)
dminus	db count dup(?)
	.code
	.startup
	mov si,offset block
	mov di,offset dplus
	mov bx,offset dminus
	mov ax,ds
	mov es,ax;;数据段段地址ds存到es，以便后续进行stosb将东西存到dplus或dminus
	mov cx,count
	cld
go_on:	lodsb
	test al,80h;;检测符号位
	jnz minus
	stosb
	jmp again
minus:	xchg bx,di
	stosb
	xchg bx,di
again:	dec cx
	jnz go_on
	.exit 0
	end
;;将block中的数根据符号位分类存到dplus和dminus中