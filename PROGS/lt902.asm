;lt902.asm
	.model small
	.686
	.xmm
	.stack
	.data
dd_ary  dd 1234.5,-1.45,-234.9,0.456,2.3e-7,-1.45,0,0.98765
	dd 500.23,-720.12,-2.87e2,-1.45e5,0.0123,-7.001,-3.4,10.0
dd_size	= ($-dd_ary)/4
mindd	dd ?
mindi	dd ?
errmsg	db 'Sorry, something is wrong with your program !$'
	.code
	.startup
;start:	mov ax,@data
;	mov ds,ax
	;
	mov ecx,dd_size
        lea esi,dd_ary
	cmp ecx,4
	jb mind_7
        movups xmm0,oword ptr dd_ary
mind_0: add esi,16
        sub ecx,4
mind_1:	cmp ecx,4
	jb mind_3
        MOVUPS XMM1,[ESI]
	minps xmm0,xmm1
        jmp mind_0
mind_3:	movups xmm1,[esi+ecx*4-16]
	minps xmm0,xmm1
	movaps xmm1,xmm0
	shufps xmm1,xmm0,0eeh
	minps xmm0,xmm1
	movaps xmm1,xmm0
	shufps xmm1,xmm0,0e5h
	minss xmm0,xmm1
	jmp mind_9
mind_7:	movss xmm0,[esi]
mind_8:	add esi,4
	dec ecx
	jz mind_9
	movss xmm1,[esi]
	minss xmm0,xmm1
	jmp mind_8
mind_9:	movss mindd,xmm0
	;
	mov ecx,dd_size
	mov esi,offset dd_ary
	xor edx,edx
	movaps xmm1,xmm0
	shufps xmm0,xmm1,0
mind_11:	cmp ecx,4
	jb mind_17
	movups xmm1,[esi]
	cmpeqps xmm1,xmm0
	movmskps eax,xmm1
	cmp eax,0
	jnz mind_18
	add esi,16
	add edx,4
	sub ecx,4
	jmp mind_11
mind_17:	comiss xmm0,[esi]
	lahf
	and ah,01000101b	;=45h
	cmp ah,01000000b	;xor ah,40h
	jz mind_19
	;
	add esi,4
	inc edx
	dec ecx
	jnz mind_17
	;
	jmp error
	;
mind_18:	mov ecx,4
	shr eax,1
	jc mind_19
	inc edx
	loop mind_18
	;
error:	mov ah,9
	mov dx,offset errmsg
	int 21h
	jmp done
mind_19:	mov mindi,edx
	mov eax,edx
	call dispd
	;
done:	.exit 0
;done:	mov ax,4c00h
;	int 21h
	;
dispd	proc
	push ebx
	push edx
	test eax,eax
	jnz dispd0
	mov dl,'0'
	mov ah,2
	int 21h
	jmp dispd4
dispd0:	mov ebx,10
	push bx
dispd2:	cmp eax,0
	jz dispd3
	sub edx,edx
	div ebx
	add dl,30h
	push dx
	jmp dispd2
dispd3:	pop dx
	cmp dl,10
	je dispd4
	mov ah,2
	int 21h
	jmp dispd3
dispd4:	pop edx
	pop ebx
	ret
dispd	endp
	;
	end
;	end start
