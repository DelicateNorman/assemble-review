;lt407.asm
	.model small
	.stack
	.data
string	db 'HeLLO,eveRyboDy !',0
	.code
	.startup
	mov bx,offset string
again:	mov al,[bx];;取一个字符
	or al,al
	jz done;;如果是结束符,则退出循环
	cmp al,'A'
	jb next
	cmp al,'Z'
	ja next
	or al,20h
	mov [bx],al;;如果是大写字母,则转换为小写字母
next:	inc bx
	jmp again
done:	.exit 0
	end
;;将字符串中的大写字母转换为小写字母