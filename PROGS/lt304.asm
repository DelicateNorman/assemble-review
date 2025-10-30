;lt304.asm
	.model small
	.stack
	.data
v_byte	equ this byte
v_word	dw 3332h,3735h
target	dw 5 dup (20h)
crlf	db 0dh,0ah,'$'
flag	db 0
n_point	dw offset s_label
	.code
	.startup
	mov al,byte ptr v_word
	dec al
	mov v_byte,al
n_label:	cmp flag,1
	jz s_label
	inc flag
	jmp short n_label
s_label:	cmp flag,2
	jz next
	inc flag
	jmp n_point
next:	mov ax,type v_word
	mov cx,lengthof target
	mov si,offset target
w_again:	mov [si],ax
	inc si
	inc si
	loop w_again
	mov cx,sizeof target
	mov al,'?'
	mov di,offset target
b_again:	mov [di],al
	inc di
	loop b_again
	mov dx,offset v_word
	mov ah,9
	int 21h
	.exit 0
	end
