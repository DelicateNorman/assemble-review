;lt901.asm
	.model small
	.586
	.mmx
	.stack
	.data
a_ver	dq 0002000300040005h,0002000300040005h
b_ver	dq 0002000300040005h,0002000300040005h
ab_ver	dd ?
nomsg	db "MMX Not Found.",13,10,"$"
yesmsg	db "MMX Found.",13,10,"$"
okmsg	db "Result is Correct.",13,10,"$"
nokmsg	db "Result is Wrong.",13,10,"$"
	.code
	.startup
	mov eax,1
	cpuid
	test edx,00800000h
	jnz MMX_FOUND
	mov ah,9
	mov dx,offset nomsg
	int 21h
	mov si,offset a_ver
	mov di,offset b_ver
	mov cx,8
start1:	mov ax,[si]
	imul word ptr [di]
	push dx
	push ax
	add si,2
	add di,2
	loop start1
	mov cx,7
	pop eax
start2:	pop ebx
	add eax,ebx
	loop start2
	mov ab_ver,eax
	jmp start4
MMX_FOUND:	mov ah, 9
	mov dx, offset yesmsg
	int 21h
	movq MM0,a_ver
	pmaddwd MM0,b_ver
	movq MM1,a_ver+8
	pmaddwd MM1,b_ver+8
	paddd MM0,MM1
	movq MM1,MM0
	psrlq MM1,32
	paddd MM0,MM1
	movd ab_ver,MM0
	emms
start4:	mov eax,108
	cmp eax,ab_ver
	jnz start5
	mov dx,offset okmsg
	jmp start6
start5:	mov dx,offset nokmsg
start6:	mov ah,9
	int 21h
	.exit
	end
