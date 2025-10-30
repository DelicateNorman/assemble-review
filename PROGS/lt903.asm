;lt903.asm
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
;start:	mov ax,@data
;	mov ds,ax
	;
	mov ecx,dq_size
        lea esi,dq_ary
	call mdouble
	jnc done
	mov ah,9
    mov dx,offset errmsg
	int 21h
done:	.exit 0
;	mov ax,4c00h
;	int 21h
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
maxd_3:	jecxz maxd_8
	movupd xmm1,[esi]
	maxpd xmm0,xmm1
	jmp maxd_2
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
;	end start
