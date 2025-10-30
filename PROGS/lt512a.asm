;lt512a.asm
	include lt512a.mac
	.model small
	.stack
	.data
msg1	db 'Please enter the number (xx):',0dh,0ah,'$'
msg2	db 'The numbers entered are:',0dh,0ah,'$'
msg3	db 'The sorting result (ascending):',0dh,0ah,'$'
crlf	db 0dh,0ah,'$'
maxcount = 100
count	dw ?
buf	db maxcount dup(?)
	.code
	.startup
	dispmsg msg1
	mov bx,offset buf
	call input
	cmp cx,0
	je start4
	mov count,cx
	dispmsg crlf
	dispmsg msg2
	mov bx,offset buf
	mov cx,count
start2: mov al,[bx]
	call ALdisp
	dispchar ','
	inc bx
	loop start2
	dispmsg crlf
	mov bx,offset buf
	mov cx,count
	call sorting
	dispmsg msg3
	mov bx,offset buf
	mov cx,count
start3: mov al,[bx]
	call ALdisp
	dispchar ','
	inc bx
	loop start3
	dispmsg crlf
start4: .exit 0
	include sub512a.asm
	end
