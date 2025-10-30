;lt803.asm
	.model small
	.8087
	.stack
	.data
f32d	real4 100.25
f64d	real8 -0.2109375
f80d	real10 100.25e9
i16d	dw 100
i32d	dd -1234
i64d	dq 123456h
b80d	dt 123456h
ib32	dd ?
bi80	dt ?
	.code
	.startup
start1:	finit
	fld f32d
	fld f64d
	fld f80d
	fld st(1)
	fild i16d
	fild i32d
	fild i64d
	fbld b80d
start2:	fist dword ptr ib32
	fxch
	fbstp tbyte ptr bi80
	.exit 0
	end
