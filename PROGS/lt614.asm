;lt614.asm
	.386
	.model flat,stdcall
	option casemap:none
	include include\windows.inc
	include include\kernel32.inc
	include include\user32.inc
	includelib lib\kernel32.lib 
	includelib lib\user32.lib
WinMain	proto :DWORD,:DWORD,:DWORD,:DWORD
	.data	;具有初值的数据段定义（汇编时分配主存空间）
ClassName	db "SimpleWinClass",0	;窗口类名称
AppName	db "Win32示例",0	;程序名

szText	db '欢迎进入32位Windows世界！',0

	.data?	;没有初值的数据段定义（运行时分配主存空间）
hInstance	dd ?	;应用程序实例句柄
CommandLine dd ?	;命令行参数地址指针
	.code
start:	;调用主过程
	invoke GetModuleHandle, NULL
	mov    hInstance,eax	;获得实例句柄，保存
	invoke GetCommandLine
	mov    CommandLine,eax	;获得命令行参数地址指针，保存
	invoke WinMain, hInstance,NULL,CommandLine, SW_SHOWDEFAULT
	invoke ExitProcess,eax
	;WinMain主过程
WinMain proc hInst:DWORD ,hPrevInst:DWORD,CmdLine:DWORD,CmdShow:DWORD
	LOCAL wc:WNDCLASSEX	;定义窗口属性的结构变量
	LOCAL msg:MSG	;定义消息变量
	LOCAL hwnd:DWORD	;定义窗口句柄变量
	;初始化窗口类变量
	mov   wc.cbSize,SIZEOF WNDCLASSEX
	mov   wc.style,CS_HREDRAW or CS_VREDRAW
	mov   wc.lpfnWndProc, OFFSET WndProc	;WndProc是窗口过程
	mov   wc.cbClsExtra,NULL
	mov   wc.cbWndExtra,NULL
	push  hInstance
	pop   wc.hInstance
	mov   wc.hbrBackground,COLOR_WINDOW+1
	mov   wc.lpszMenuName,NULL	;没有使用菜单栏
	mov   wc.lpszClassName,OFFSET ClassName
	invoke LoadIcon,NULL,IDI_APPLICATION	;获得系统标准图标
	mov   wc.hIcon,eax
	mov   wc.hIconSm,eax
	invoke LoadCursor,NULL,IDC_ARROW	;获得系统标准光标
	mov   wc.hCursor,eax
	invoke RegisterClassEx, addr wc	;注册窗口类
	INVOKE CreateWindowEx,NULL,ADDR ClassName,ADDR AppName,\
	WS_OVERLAPPEDWINDOW,CW_USEDEFAULT, CW_USEDEFAULT,\
	CW_USEDEFAULT,CW_USEDEFAULT,NULL,NULL, hInst,NULL
	mov   hwnd,eax	;创建窗口，保存其句柄
	invoke ShowWindow, hwnd,SW_SHOWNORMAL	;显示窗口
	invoke UpdateWindow, hwnd	;更新窗口
	.WHILE TRUE	;消息循环
	invoke GetMessage, ADDR msg,NULL,0,0	;获得消息
	.BREAK .IF (!eax)
	;.WHILE TRUE形成无条件循环，此处当EAX等于0则跳出循环
	invoke TranslateMessage, ADDR msg	;翻译消息
	invoke DispatchMessage, ADDR msg	;分派消息
	.ENDW
	mov     eax,msg.wParam
	ret
WinMain endp
;窗口过程
WndProc proc hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
	.IF uMsg==WM_DESTROY
	invoke PostQuitMessage,NULL	;处理关闭程序的消息

	.ELSEIF uMsg==WM_LBUTTONDOWN	;处理单击鼠标左键的消息
	invoke MessageBox,NULL,addr szText, addr AppName,MB_OK

	.ELSE	;不处理的消息由系统默认操作
	invoke DefWindowProc,hWnd,uMsg,wParam,lParam		
            ret
	.ENDIF
	xor eax,eax
	ret
WndProc	endp
end start
