;lt308.asm
	.model small
	.stack 256
	.data
person	struct
number	dw 0
pname	db '--------'
sex	db 0
birthday	db 'mm/dd/yyyy'
person	ends
array	person 100 dup(< >)
	.code
	.startup
	mov bx,offset array
	mov ax,1
	sub si,si
	mov cx,length array
	mov dx,type array
again:	mov [bx+si].person.number,ax
	inc ax
	add si,dx
	loop again
	.exit
	end
