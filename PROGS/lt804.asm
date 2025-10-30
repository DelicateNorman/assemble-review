;lt804.asm
	.model small
	.8087
	.stack
	.data
fcount	equ 6
farray	dq 100.25,-0.2109375,100.25e9,-1234.0,123456.,0.98765
fsum	dq ?
	.code
	.startup
	mov si,offset farray
	mov cx,fcount
start1: finit
	fldz
start2:	fadd qword ptr [si]
	add si,8
	loop start2
	fstp qword ptr fsum
	.exit 0
	end
