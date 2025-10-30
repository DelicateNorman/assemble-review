;lt416c.asm
	.model small
	.stack
	.data
count	equ 10
array	db 12h,25h,0f0h,0a3h,3,68h,71h,0cah,0ffh,90h
result	db ?
	.code
	.startup
	mov ax,offset array
	push ax
	mov ax,count
	push ax
	call checksumc
	add sp,4
	mov result,al
	.exit 0
checksumc	proc
	push bp
	mov bp,sp
	push bx
	push cx
	mov bx,[bp+6]
	mov cx,[bp+4]
	xor al,al
sumc:	add al,[bx]
	inc bx
	loop sumc
	pop cx
	pop bx
	pop bp
	ret
checksumc	endp
	end
