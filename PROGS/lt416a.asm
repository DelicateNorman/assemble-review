;lt416a.asm
	.model small
	.stack
	.data
count	equ 10
array	db 12h,25h,0f0h,0a3h,3,68h,71h,0cah,0ffh,90h
result	db ?
	.code
	.startup
	mov bx,offset array
	mov cx,count
	call checksuma
	mov result,al
	.exit 0
checksuma	proc
	xor al,al
suma:	add al,[bx]
	inc bx
	loop suma
	ret
checksuma	endp
	end
