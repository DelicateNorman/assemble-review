;lt401.asm
	.model small
	.stack
	.data
HEX	db 8bh	;待显示的字节数据
ASCII	db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h;0~9对应的ASCII码
	db 41h,42h,43h,44h,45h,46h	;ASCII表，大写A~F对应的ASCII码
	;;十六进制数字对应的ASCII码表！！
	.code
	.startup
	mov bx,offset ASCII	;BX指向ASCII表
	mov al,HEX	;AL取得字节数据
	mov cl,4	;先显示二进制高四位（对应十六进制一位）
	shr al,cl	;高4位移位到低4位，即ASCII表中的位移
	xlat	;换码：AL<-DS:[BX+AL]
	mov dl,al	;入口参数：DL<-AL
	mov ah,2	;02号DOS功能调用
	int 21h	;显示数据高位
	mov al,HEX	;al取得字节数据
	and al,0fh	;高4位清0，只有低4位有效
	xlat	;换码
	mov dl,al
	mov ah,2
	int 21h	;显示数据低位
	.exit 0
	end
