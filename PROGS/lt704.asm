;lt704.asm
	.model small,c
	public min
	.code
min	proc,var1:word,var2:word
	mov ax,var1
	cmp ax,var2
	jle minexit
	mov ax,var2
minexit:
	ret	
min	endp
	end
