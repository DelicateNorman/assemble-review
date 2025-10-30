;lt307.asm
dseg	segment word public 'data'
	org 100h
	dw 200 dup(?)
topsp	equ this word
array	dw 100 dup(5868h)
dseg	ends
cseg	segment 'code'
	assume cs:cseg,ds:dseg,ss:dseg
start:	mov ax,dseg
	mov ds,ax
	mov ss,ax
	mov sp,offset topsp
	mov cx,100
	xor si,si
again:	push array[si]
	inc si
	inc si
	loop again
	mov ah,4ch
	int 21h
cseg	ends
	end start
