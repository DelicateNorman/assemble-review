;lt708s.asm
	.model small,c
	EXTERN num:word
	PUBLIC incnum
	.code
incnum	proc
	inc num
	ret
incnum	endp
	end
