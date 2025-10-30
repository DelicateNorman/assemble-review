;lt611.asm
	.386
	.model flat,stdcall
	option casemap:none
	includelib bin32\kernel32.lib
ExitProcess	proto,:DWORD
GetStdHandle	proto,:DWORD
ReadConsoleA	proto,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
ReadConsole	equ <ReadConsoleA>
WriteConsoleA	proto,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
WriteConsole	equ <WriteConsoleA>
STD_INPUT_HANDLE = -10
STD_OUTPUT_HANDLE = -11
	.data
outhandle	dd ?
outbuffer	db 'Welcome to the Win32 Console !',0dh,0ah
		db 'Please enter your name:',0dh,0ah
outbufsize	= $-outbuffer
outsize	dd ?
inhandle	dd ?
inbufsize	= 80
inbuffer	db inbufsize dup(?),0,0
insize		dd ?
	.code
start:
	;获得输出句柄
	invoke GetStdHandle,STD_OUTPUT_HANDLE
	mov outhandle,eax
	;显示信息
	invoke WriteConsole,outhandle,addr outbuffer,outbufsize,addr outsize,0
	;获得输入句柄
	invoke GetStdHandle,STD_INPUT_HANDLE
	mov inhandle,eax
	;等待用户输入
	invoke ReadConsole,inhandle,addr inbuffer,inbufsize,addr insize,0
	;退出
	invoke ExitProcess,0
	end start