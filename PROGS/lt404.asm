;lt404.asm
	.model small
	.stack
	.data
msg	db 'Input number(1~8):',0dh,0ah,'$'
;;0dh 是 “回车”（Carriage Return），作用是将光标移到行首；
;;0ah 是 “换行”（Line Feed），作用是将光标移到下一行；
;;两者结合（0dh,0ah）就是我们常见的 “换行” 效果，让提示文本输出后光标跳到下一行开头，方便用户输入。
;;'$' 是 DOS 中断（如int 21h的9号功能）输出字符串时的结束标记，表示这个字符串到$为止。
msg1	db 'Chapter 1 : Fundamentals of Assembly Language',0dh,0ah,'$'
msg2	db 'Chapter 2 : 8086 Instruction Set',0dh,0ah,'$'
msg3	db 'Chapter 3 : Statements of Assembly Language',0dh,0ah,'$'
msg4	db 'Chapter 4 : Assembly Language Programming',0dh,0ah,'$'
msg5	db 'Chapter 5 : 32-bit Instructions and Programming',0dh,0ah,'$'
msg6	db 'Chapter 6 : Mixed Programming with C/C++',0dh,0ah,'$'
msg7	db 'Chapter 7 : FP Instructions and Programming',0dh,0ah,'$'
msg8	db 'Chapter 8 : MMX Instructions and Programming',0dh,0ah,'$'
table	dw disp1,disp2,disp3,disp4,disp5,disp6,disp7,disp8
	.code
	.startup
start1:	mov dx,offset msg
	mov ah,9
	int 21h;;输出一个字符串
	mov ah,1
	int 21h;;输入一个字符
	cmp al,'1'
	jb start1
	cmp al,'8'
	ja start1;;小于1或大于8重新输入
	and ax,000fh;;将输入的字符转换为数字
	dec ax
	shl ax,1
	mov bx,ax;;bx=(ax-1)*2,ax是输入的数字，减1是因为数组下标从0开始，乘2是因为每个元素占2字节，bx是元素的偏移地址
	jmp table[bx];;注意bx是以字节为单位的偏移地址，而不是以一个元素为单位
	;;这里的jmp语句还可以换成add bx,offset table ,jmp word ptr[bx]
start2:	mov ah,9;;DOS 9号功能调用输出一个字符串
	int 21h;;输出一个字符串
	.exit 0
disp1:	mov dx,offset msg1;;入口参数
	jmp start2
disp2:	mov dx,offset msg2
	jmp start2
disp3:	mov dx,offset msg3
	jmp start2
disp4:	mov dx,offset msg4
	jmp start2
disp5:	mov dx,offset msg5
	jmp start2
disp6:	mov dx,offset msg6
	jmp start2
disp7:	mov dx,offset msg7
	jmp start2
disp8:	mov dx,offset msg8
	jmp start2
	end
;;多分支结构