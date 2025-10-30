;lt402.asm
	.model small
	.stack
	.data
num	dw 3456	;假设一个N值（小于2^16-2)
sum	dd ?
	.code
	.startup

	mov ax,num	;AX=N
	add ax,1	;AX=N+1
	mul num	;DX.AX=(1+N)*N
	shr dx,1	;32位逻辑右移1位
	rcr ax,1	;DX.AX=DX.AX/2
	mov word ptr sum,ax
	mov word ptr sum+2,dx	;小端方式保存

	.exit 0
	end
