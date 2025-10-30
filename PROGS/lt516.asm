;lt516.asm
	.model small
	.stack
	.data
esccode	db 0
	.code
	.startup
	mov ax,3509h
	int 21h
	push es
	push bx
	cli
	push ds
	mov ax,2509h
	mov dx,seg scancode
	mov ds,dx
	mov dx,offset scancode
	int 21h
	pop ds
        in al,21h
	push ax
	and al,0fdh
        out 21h,al
	;
	mov byte ptr esccode,0
	sti
waiting:	cmp byte ptr esccode,81h
	jne waiting
	cli
	pop ax
        out 21h,al
	mov ax,2509h
	pop dx
	pop ds
	int 21h
	sti
	.exit 0
scancode	proc
	sti
	push ax
	push bx
	in al,60h
	push ax
	in al,61h
	or al,80h
	out 61h,al
	and al,7fh
	out 61h,al
	pop ax
	cmp al,81h
	jne scan1
	push ds
	mov bx,@data
	mov ds,bx
	mov esccode,al
	pop ds
scan1:	push ax
	shr al,1
	shr al,1
	shr al,1
	shr al,1
	cmp al,0ah
	jb scan2
	add al,7
scan2:	add al,30h
	mov bx,0
	mov ah,0eh
	int 10h
	pop ax
	and al,0fh
	cmp al,0ah
	jb scan3
	add al,7
scan3:	add al,30h
	mov ah,0eh
	int 10h
	mov ax,0e20h
	int 10h
	mov ax,0e20h
	int 10h
	mov al,20h
	out 20h,al
	pop bx
	pop ax
	iret
scancode	endp
        end
