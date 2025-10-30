;lt408.asm
	.model small
	.stack
	.data
array	db 56h,23h,37h,78h,0ffh,0,12h,99h,64h,0b0h
	db 78h,80h,23h,1,4,0fh,2ah,46h,32h,42h
count  equ ($-array)/type array;;数组元素个数
;;count：定义的符号（常量）名，用于存储数组元素个数
;;equ：汇编中的 "等于" 伪指令，用于给符号赋值（赋值后不可修改）
;;$-array：计算数组的总字节长度
;;$表示当前汇编地址（即这条指令所在的位置）
;;array是数组的起始地址
;;两者相减得到数组从开始到结束的总字节数
;;type array：获取数组中单个元素的字节长度
;;整体含义：用数组的总字节长度除以单个元素的字节长度，得到的结果就是数组的元素个数，并用count来表示这个数量。
	.code
	.startup
	mov cx,count
	dec cx
outlp:	mov dx,cx
	mov bx,offset array
inlp:	mov al,[bx];;取一个元素
	cmp al,[bx+1]
	jna next;;如果当前元素不大于下一个元素,则不需要交换
	xchg al,[bx+1]
	mov [bx],al;;交换当前元素和下一个元素
next:	inc bx;;指向下一个元素
	dec dx
	jnz inlp;;如果还有元素未比较,则继续比较
	loop outlp;;如果还有元素未排序,则继续排序
	.exit 0
	end
;;冒泡排序，升序排序