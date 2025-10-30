;lt609.asm
.model tiny
	.586
dispdl	macro
	mov ah,2
	int 21h
	shr edx,8
	endm
	.code
	.startup
	mov eax,0
	cpuid
	push edx
	push ebx
	pop edx
	repeat 4
	    dispdl
	endm
	pop edx
	repeat 4
	    dispdl
	endm
	mov edx,ecx
	repeat 4
	    dispdl
	endm
	.exit
	end
