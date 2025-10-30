;lt515a.asm
	.model small
	.stack
	.data
intoff	dw ?
intseg	dw ?
	.code
	.startup
	mov ax,3580h
        int 21h
	mov intoff,bx
	mov intseg,es
	;
	push ds
	mov dx,offset newint80h
	mov ax,seg newint80h
	mov ds,ax
	mov ax,2580h
        int 21h
	pop ds
        ;
	int 80h
	;
	mov dx,intoff
	mov ax,intseg
	mov ds,ax
	mov ax,2580h
	int 21h
	.exit 0
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
	 end
