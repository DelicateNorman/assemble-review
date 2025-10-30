;lt415.asm
	.model small
	.stack
	.data
array	db 56h,23h,37h,78h,0ffh,0,12h,99h,64h,0b0h
	db 78h,80h,23h,1,4,0fh,2ah,46h,32h,42h
count	equ ($-array)/type array
	.code
	.startup
	mov cx,count
	dec cx
outlp:	mov dx,cx
	mov bx,offset array
inlp:	mov al,[bx]
	cmp al,[bx+1]
	jna next
	xchg al,[bx+1]
	mov [bx],al
next:	inc bx
	dec dx
	jnz inlp
	loop outlp
	mov bx,offset array
	mov cx,count
displp:	mov al,[bx]
	call ALdisp
	mov dl,','
	mov ah,2
	int 21h
	inc bx
	loop displp
	.exit 0
ALdisp	proc
	push ax
	push cx
	push dx
	push ax
	mov dl,al
	mov cl,4
	shr dl,cl
	or dl,30h
	cmp dl,39h
	jbe aldisp1
	add dl,7
aldisp1:	mov ah,2
	int 21h
	pop dx
	and dl,0fh
	or dl,30h
	cmp dl,39h
	jbe aldisp2
	add dl,7
aldisp2:	mov ah,2
	int 21h
	pop dx
	pop cx
	pop ax
	ret
ALdisp	endp
	end
