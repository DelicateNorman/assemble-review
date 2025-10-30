;lt709s.asm
	.model small,c
	PUBLIC num
	PUBLIC incnum
	.data
num	dw 0
	.code
incnum	proc
	inc num
	ret
incnum	endp
	end