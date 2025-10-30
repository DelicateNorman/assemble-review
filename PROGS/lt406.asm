;lt406.asm
	.model small
	.stack
	.data
wordX	dw 56
byteY	db ?
	.code
	.startup
	mov ax,wordX;;测试目标送给ax
	mov cx,16;;循环计数器设置初值
	mov dl,-1;;结果初始值设置为-1
again:	inc dl
	test ax,1;;逻辑运算影响ZF\SF\PF
	ror ax,1;;循环移位(1位)只影响OF\CF,cl位只影响CF；OF最高位改没改变
	loope again;;cx<-cx-1,若cx不为0且ZF=0（ax最低位不为1时），则继续循环
	je  notfound;;循环完了ax的最低位仍不为1,则未找到
	mov byteY,dl;;结果送byteY
	jmp done
notfound:	mov byteY,-1
done:	.exit 0
	end
;;查找wordX的二进制表示中最低位的1的位置