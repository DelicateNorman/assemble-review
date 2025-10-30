;lt811l.asm
	.model large,c
	.386
	.387
	.code
	public froot
froot	proc
	push bp
	mov bp,sp
	finit
	fld qword ptr [bp+6]
	fld qword ptr [bp+14]
	fchs
	fld qword ptr [bp+22]
	fld st(1)
	fmul st,st(0)
	fxch
	fadd st,st(0)
	fadd st,st(0)
	fmul st,st(3)
	fsubp st(1),st
	ftst
	fstsw ax
	sahf
	jae froots
	fstp st
	fstp st
	fstp st
	xor ax,ax
	jmp frootexit
froots:	fsqrt
	fxch st(2)
	fadd st,st(0)
	fld st(1)
	fsub st,st(3)
	fdiv st,st(1)
	les bx,[bp+30]
	fstp qword ptr es:[bx]
	fxch
	faddp st(2),st(0)
	fdiv
	les bx,[bp+34]
	fstp qword ptr es:[bx]
	mov ax,1
frootexit:	pop bp
	ret
froot	endp
	end
	