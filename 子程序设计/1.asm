; 例 1：回车换行子程序 (DPCROLF) - .STARTUP 版本
; 功能：定义一个子程序，实现光标回车和换行，并在主程序中调用。

.MODEL SMALL
.STACK 100H

.CODE
.STARTUP ; 程序入口，自动初始化 DS

    ; 主程序逻辑
    CALL DPCROLF ; 调用回车换行子程序

.EXIT 0 ; 退出程序，自动生成 MOV AH, 4CH / INT 21H

; --- 子程序定义 (放在主程序逻辑之后，END 之前) ---
DPCROLF PROC NEAR 
    ; 保护寄存器：AX, DX
    PUSH AX 
    PUSH DX

    ; 1. 显示回车 (CR) 0DH
    MOV DL, 0DH 
    MOV AH, 2H
    INT 21H

    ; 2. 显示换行 (LF) 0AH
    MOV DL, 0AH 
    MOV AH, 2H
    INT 21H

    ; 恢复寄存器
    POP DX
    POP AX
    RET 
DPCROLF ENDP

END ; 汇编结束，不需要 MAIN 标签