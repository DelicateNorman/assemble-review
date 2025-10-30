;lt601.asm
	.model small
	.386
	.code
	.startup

	mov ecx,16
	mov bx,ax
next:	shr ax,1
	rcr edx,1
	shr bx,1
	rcr edx,1
	loop next
	mov eax,edx

	.exit
	end