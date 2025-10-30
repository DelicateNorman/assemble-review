;lt514.asm
	.model small
	.stack
	.data
okmsg	db 'Good, My printer !',0dh,0ah,'$'
errmsg	db 'Not Ready, My printer !',0dh,0ah,'$'
	.code
	.startup
	mov cx,(sizeof okmsg)-1
	mov si,offset okmsg
prnbegin:	mov dx,378h
	mov bx,100
	mov al,[si]
	call printchar
	jc prnerr
	inc si
	loop prnbegin
	mov dx,offset okmsg
	jmp prnok
prnerr: mov dx,offset errmsg
prnok:	mov ah,9
	int 21h
	.exit 0

printchar proc
	push cx
	out dx,al
	inc dx
print0:	sub cx,cx
print1:	in al,dx
	test al,80h
	jnz print2
	loop print1
	dec bl
	jnz print0
	stc
	jmp print3
print2: inc dx
	mov al,0dh
	inc dx
	out dx,al
	nop
	mov al,0ch
	out  dx,al
	clc
print3:	pop cx
	ret
printchar endp
	end
