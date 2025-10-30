;lt515b.asm
	.model tiny
	.code
	org 100h
newint80h	proc
	sti
	push ax
	push bx
	push cx
	push si
	mov si,offset intmsg
	mov cx,sizeof intmsg
disp:	mov al,cs:[si]
	mov bx,0
	mov ah,0eh
	int 10h
	inc si
	loop disp
	pop si
	pop cx
	pop bx
	pop ax
	iret
intmsg	db 'I am Great !',0dh,0ah
newint80h	endp
start:	mov ax,cs
	mov ds,ax
	mov dx,offset newint80h
	mov ax,2580h
	int 21h
	;
	int 80h
	;
	mov dx,offset istmsg
	mov ah,9
	int 21h
	;
	mov dx,(offset start)+15
	mov cl,4
	shr dx,cl
	mov ax,3100h
	int 21h
istmsg	db 'INT 80H is installed!',0dh,0ah,'$'
	end start
