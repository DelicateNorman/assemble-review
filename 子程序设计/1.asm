; 例 1：回车换行子程序 (DPCROLF)
; 功能：定义一个子程序，实现光标回车和换行，并在主程序中调用。

.MODEL SMALL
.STACK 100H

.CODE
; --- 子程序定义 ---
DPCROLF PROC NEAR ; 定义近过程
    PUSH AX ; 保护寄存器：AX, DX (因为过程体中使用了它们)
    PUSH DX

    MOV DL, 0DH ; 1. 回车 (Carriage Return)
    MOV AH, 2H  ; DOS功能 2H：显示 DL 中的字符
    INT 21H

    MOV DL, 0AH ; 2. 换行 (Line Feed)
    MOV AH, 2H
    INT 21H

    POP DX  ; 恢复寄存器：DX, AX
    POP AX
    RET     ; 子程序返回
DPCROLF ENDP

; --- 主程序 ---
MAIN PROC
    MOV AX, @DATA ; 初始化 DS (虽然本例中没有数据段，仍是良好习惯)
    MOV DS, AX

    ; 主程序调用子程序
    CALL DPCROLF  ; 调用回车换行子程序

    ; 可以在这里继续主程序代码...
    
    ; 退出程序
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN