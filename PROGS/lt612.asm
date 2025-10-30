;lt612.asm
    .386
    .model flat,stdcall
    option casemap:none
 	includelib bin32\kernel32.lib
	includelib bin32\user32.lib
ExitProcess	proto,:dword
MessageBoxA	proto :dword,:dword,:dword,:dword
MessageBox	equ <MessageBoxA>
NULL	equ 0
MB_OK	equ 0
    .data
szCaption   db 'Win32示例',0
szText  db '欢迎进入32位Windows世界!',0
    .code
start:
    invoke MessageBox,NULL,addr szText, addr szCaption,MB_OK
    invoke ExitProcess,NULL
end start