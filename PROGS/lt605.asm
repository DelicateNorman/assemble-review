;lt605.asm
	.model small
	.386
	.stack
	.data
qvar	dq 1234567887654321h
	.code
	.startup
	mov eax,dword ptr qvar
	mov edx,dword ptr qvar[4]
	mov cx,8
start1:	shl eax,1
	rcl edx,1
	loop start1
	mov dword ptr qvar,eax
	mov dword ptr qvar[4],edx
	.exit 0
	end
