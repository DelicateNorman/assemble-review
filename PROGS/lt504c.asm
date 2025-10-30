;lt504c.asm
dstring	MACRO string
	db '&string&',0dh,0ah,'$'
	ENDM
mainbegin	MACRO dsseg
	mov ax,dsseg
	mov ds,ax
	ENDM
mainend	MACRO retnum
	ifb <retnum>
	    mov ah,4ch
	else
	    mov ax,4c00h+(retnum AND 0ffh)
	endif
	int 21h
	ENDM
dispmsg	MACRO message
	mov dx,offset message
	mov ah,09h
	int 21h
	ENDM
	.model small
	.stack
	.data
msg1	equ this byte
dstring	<Hello, Everybody !!>
msg2	equ this byte
dstring	<You see,I made it.>
	.code
start:	mainbegin @data
	dispmsg msg1
	dispmsg msg2
	mainend
	end start
