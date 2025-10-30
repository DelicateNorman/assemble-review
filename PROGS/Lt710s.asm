; lt710s.asm
	.model small,c
	extern csub:near
	.data
astring	db 'OK, Assembly !',0dh,0ah,'$'
cstring	db 'Good, Turbo C 2.0 !',0
	.code
	PUBLIC asub
asub	proc
	mov dx,offset astring
	mov ah,09h
	int 21h
	MOV ax,offset cstring
	push ax
	call csub
	add sp,2
	ret
asub	endp
	end