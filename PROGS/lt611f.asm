;lt611f.asm  for MASM32
	.386
	.model flat,stdcall
	option casemap:none
      include include\windows.inc
	include include\kernel32.inc
	includelib lib\kernel32.lib
	.data
outhandle	dd ?
outbuffer	db 'Welcome to the Win32 Console !',0dh,0ah
		db 'Please enter your name:',0dh,0ah
outbufsize	= $-outbuffer
outsize	dd ?
inhandle	dd ?
inbufsize	= 80
inbuffer	db inbufsize dup(?),0,0
insize	dd ?
	.code
start:
	;
	invoke GetStdHandle,STD_OUTPUT_HANDLE
	mov outhandle,eax
	;
	invoke WriteConsole,outhandle,addr outbuffer,outbufsize,addr outsize,0
	;
	invoke GetStdHandle,STD_INPUT_HANDLE
	mov inhandle,eax
	;
	invoke ReadConsole,inhandle,addr inbuffer,inbufsize,addr insize,0
	;
	invoke ExitProcess,0
	end start