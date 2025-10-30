;lt502.asm
	.model small
	.stack
	.data
array	sword 100 dup(?)
result	sword ?
	.code
	.startup
	mov cx,100
	xor ax,ax
	lea bx,array
	.repeat
	    .if sword ptr [bx] >= 0
	        add ax,[bx]
	    .else
	        .break
	    .endif
	    inc bx
	    inc bx
	.untilcxz
	mov result,ax
	.exit 0
	end
