;lt409.asm
	.model small
	.stack
	.data
string	db 'Let us have a try !','$'
	.code
	.startup
	mov si,offset string
outlp:	cmp byte ptr [si],'$'
	jz done;;如果是字符串结束符,则结束
	cmp byte ptr [si],' '
	jnz next;;如果不是空格,则继续比较下一个字符
	mov di,si;;将空格的地址保存到di
inlp:	inc di
	mov al,[di]
	mov [di-1],al
	cmp byte ptr [di],'$'
	jnz inlp
	jmp outlp
next:	inc si
	jmp outlp
done:	.exit 0
	end
;;去掉字符串中的空格
;;将空格后面的字符前移,覆盖空格
;;si指向当前要比较的字符
;;di指向空格后面的字符