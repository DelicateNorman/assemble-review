;lt416b.asm
	.model small
	.stack
	.data
count	equ 10
array	db 12h,25h,0f0h,0a3h,3,68h,71h,0cah,0ffh,90h
result	db ?
	.code
	.startup
	call checksumb
	.exit 0
checksumb	proc
	push ax
	push bx
	push cx
	xor al,al
	mov bx,offset array
	mov cx,count
sumb:	add al,[bx]
	inc bx
	loop sumb
	mov result,al
	pop cx
	pop bx
	pop ax
	ret
checksumb	endp
	end
