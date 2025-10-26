; 例 2：一位十六进制数转换为 ASCII 码并显示 (HTOASC)
; 功能：将 AL 低 4 位的一位 16 进制数转换为 ASCII 码并在屏幕上显示。
; 入口参数：AL (低 4 位)

.MODEL SMALL
.STACK 100H

.DATA
    MSG DB 'The displayed character is:', '$'
    
.CODE
; --- 子程序定义 ---
HTOASC PROC NEAR
    PUSH AX ; 保护 AX 和 DX (用于 DOS 调用)
    PUSH DX

    AND AL, 0FH  ; 清除 AL 的高 4 位，只保留低 4 位的 16 进制数 (入口参数)
    
    CMP AL, 9    ; 比较是否大于 9 (即是否为 A~F)
    JBE htoasc1  ; 如果小于等于 9 (0~9)，跳转到 htoasc1
    
    ; 转换 A~F 逻辑 (数值 10~15)
    ADD AL, 7    ; 加上 7，使 0Ah 变为 11h，然后加上 30h 后变为 41h ('A')
    
htoasc1:
    ; 转换 0~9 或 A~F 结果到 ASCII 码
    ADD AL, 30H  ; 转换为 ASCII 码 ('0' 的 ASCII 码是 30H)

    ; 显示字符
    MOV DL, AL   ; DL ← 欲显示的 ASCII 码 (出口参数)
    MOV AH, 2H   ; 设置 DOS 功能号 02H (字符输出)
    INT 21H      ; 执行 DOS 功能调用

    POP DX       ; 恢复 DX
    POP AX       ; 恢复 AX
    RET          ; 子程序返回
HTOASC ENDP

; --- 主程序 ---
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; 1. 显示提示信息
    MOV DX, OFFSET MSG
    MOV AH, 9H
    INT 21H
    
    ; 2. 准备入口参数：将 16 进制数 0AH (即数值 10) 放入 AL
    MOV AL, 0AH ; 假设要转换并显示 'A'
    
    ; 3. 调用子程序
    CALL HTOASC ; 屏幕将显示 'A'

    ; 退出程序
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN