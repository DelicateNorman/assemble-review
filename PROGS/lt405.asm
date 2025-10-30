;lt405.asm
	.model small
	.stack
	.data
sum	dw ?
	.code
	.startup
	xor ax, ax
	mov cx,100
again:	add ax,cx
	loop again;;cx=cx-1,若cx不为0,则继续循环,充分利用cx寄存器
	mov sum,ax
	.exit 0
	end
;;计算1到100的和