;lt810.asm
	.model small
	.386
	.387
	.stack
	.data
msg	db 'No real roots. ','$'
ftwo	dd 2.0
ffour	dd 4.0
_fa	dd 3.0
_fb	dd 8.0
_fc	dd 5.0
fr1	dd ?
fr2	dd ?
	.code
	.startup
start1:	finit
	fld ftwo
	fmul _fa
	fld ffour
	fmul _fa
	fmul _fc
	fld _fb
	fmul _fb
	fsubr
start2:	ftst
	fstsw ax
	sahf
	jz froot1
	fsqrt
	fstsw ax
	test ax,1
	jz froot1
	fcompp
	mov ah,9
	mov dx,offset msg
	int 21h
	jmp start3
froot1: fld _fb
	fchs
	fsub st(0),st(1)
	fdiv st(0),st(2)
	fstp fr1
froot2:	fld _fb
	fchs
	fadd
	fdivr
	fstp fr2
start3:	.exit 0
	end
