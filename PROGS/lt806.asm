;lt806.asm
	.model small
	.386
	.387
	.stack
	.data
fcount	equ 91
fconst	dq 180.0
temp	dw 0
fsine	dq fcount dup(?)
	.code
	.startup
	mov si,offset fsine
	mov cx,fcount
start1: finit
	fldpi
	fld fconst
	fdiv
start2:	fild word ptr temp
	fmul st(0),st(1)
	fsin
	fstp qword ptr [si]
	inc word ptr temp
	add si,8
	loop start2
	.exit 0
	end
