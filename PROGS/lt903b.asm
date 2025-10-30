;lt903b.asm
	.model small
	.686
	.xmm
	.stack
	.data
dq_ary  dq 1234.5,-234.9,0,0.456,2.3e-7,-1.45e5,0,0.98765
        dq 500.23,-720.12,-2.87e2,0.0123,-7.001,1.2,-3.4,10.0
dq_size	= ($-dq_ary)/8
dq_max  dq ?
errmsg	db 'Sorry, something is wrong with your program !$'
	.code
	.startup
	;
	mov ecx,dq_size
        lea esi,dq_ary
	call mdouble
	jnc done
	mov ah,9
        mov dx,offset errmsg
	int 21h
done:	.exit 0
	;
mdouble	proc
    jecxz maxd_10
	test ecx,1
	je maxd_1
        movlpd xmm0,[esi+ecx*8-8]
        unpcklpd xmm0,xmm0
	sub ecx,1
	jmp maxd_3
maxd_1:	movupd xmm0,[esi]
maxd_2:	add esi,16
	sub ecx,2
maxd_3:	cmp ecx,14
	jb maxd_5
	movupd xmm1,[esi]
	movupd xmm2,[esi+16]
	movupd xmm3,[esi+32]
	movupd xmm4,[esi+48]
	movupd xmm5,[esi+64]
	movupd xmm6,[esi+80]
	movupd xmm7,[esi+96]
	add esi,112
	maxpd xmm0,xmm1
	maxpd xmm2,xmm3
	maxpd xmm4,xmm5
	maxpd xmm6,xmm7
	maxpd xmm0,xmm2
	maxpd xmm4,xmm6
	maxpd xmm0,xmm4
	sub ecx,14
	jmp maxd_3
maxd_5:	jecxz maxd_8
        movupd xmm1,[esi]
	add esi,16
	maxpd xmm0,xmm1
	sub ecx,2
	jmp maxd_5
maxd_8: movapd xmm1,xmm0
	unpckhpd xmm1,xmm0
	maxsd xmm0,xmm1
        movlpd dq_max,xmm0
	clc
	ret
maxd_10: stc
	ret
mdouble	endp
	;
	end
