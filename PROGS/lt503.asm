;lt503.asm
	.model small
checksumd proto c,:word,:word
	.stack
	.data
count	equ 10
array	db 12h,25h,0f0h,0a3h,3,68h,71h,0cah,0ffh,90h
result	db ?
	.code
	.startup
	invoke checksumd,count,offset array
	mov result,al
	.exit 0
checksumd proc c USES bx cx,countp:word,arrayp:word
	mov bx,arrayp
	mov cx,countp
	xor al,al
sumd:	add al,[bx]
	inc bx
	loop sumd
	ret
checksumd	endp
	end
