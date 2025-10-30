;lt403.asm
	.model small
	.stack
	.data
_a	db ?
_b	db ?
_c	db ?
tag	db ?
	.code
	.startup
	mov al,_b;AL=_b
	imul al;al=_b*_b,imul是有符号乘法
	mov dx,ax;dx=_b*_b
	mov al,_a;al=_a
	imul _c;ax=_a*_c
	mov cx,4;cx=4
	imul cx;ax=_a*_c*4
	cmp dx,ax;
	jge yes;_b*_b>=_a*_c*4
	mov tag,0;无根
	jmp done;
yes:	mov tag,1;有根
done:	.exit 0
	end
