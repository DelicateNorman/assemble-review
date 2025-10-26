; 例 4.15：过程嵌套与查表转换
; 功能：显示 AL 寄存器中存储的 2 位十六进制数 (00H ~ FFH)。
; 核心：
; 1. ALDISP 嵌套调用 HTOASC。
; 2. HTOASC 使用 XLAT 指令查表，且数据表 ASCII 位于代码段 (.CODE)。

.MODEL SMALL
.STACK 100H

.CODE

; ====================================================================
; 子过程 1: 显示 AL 中的 2 位十六进制数
; 入口参数：AL (2 位十六进制数，00H-FFH)
; 嵌套调用 HTOASC
; ====================================================================
ALDISP PROC NEAR
    PUSH AX       ; 保护 AL 及其它寄存器
    PUSH CX       ; 保护 CX (用于移位计数)
    
    ; --- 1. 转换并显示高 4 位 ---
    
    PUSH AX       ; 暂存 AX 的原始值副本
    
    MOV CL, 4     ; CL ← 4
    SHR AL, CL    ; AL 逻辑右移 4 位，将高 4 位移到低 4 位 (准备查表)
    CALL HTOASC   ; 子程序调用：显示转换后的高 4 位字符
    
    POP AX        ; 恢复 AX 的原始值 (AL 恢复为完整的 2 位十六进制数)
    
    ; --- 2. 转换并显示低 4 位 ---
    
    ; AL 中低 4 位即为待转换的 16 进制数
    CALL HTOASC   ; 子程序调用：显示转换后的低 4 位字符
    
    POP CX        ; 恢复 CX
    POP AX        ; 恢复 AX
    RET           ; 子程序返回
ALDISP ENDP

; ====================================================================
; 子过程 2: 将 AL 低 4 位表达的 1 位十六进制数转换为 ASCII 码并显示
; 入口参数：AL (低 4 位，范围 0-FH)
; 使用 XLAT 指令查表
; ====================================================================
HTOASC PROC NEAR
    PUSH AX       ; 保护 AX, BX, DX
    PUSH BX
    PUSH DX

    ; 关键步骤：由于 ASCII 表在代码段 (CS)，需要设置 DS=CS 才能让 XLAT 访问
    PUSH DS
    PUSH CS       ; 将 CS 的值压栈
    POP DS        ; 弹出 CS 的值给 DS (DS ← CS)
    
    MOV BX, OFFSET ASCII ; BX ← ASCII 码表的偏移地址
    
    AND AL, 0FH   ; 取得 1 位十六进制数 (0-15)，作为 XLAT 的索引
    
    XLAT ASCII    ; 换码：AL ← DS:[BX + AL]。AL 得到对应的 ASCII 码字符
    
    ; 显示字符
    MOV DL, AL    ; DL ← 欲显示的 ASCII 码字符
    MOV AH, 2     ; 设置 DOS 功能号 02H (字符输出)
    INT 21H       ; 执行 DOS 功能调用
    
    ; 由于这是子程序，为保证主程序能正确访问数据段，理论上需恢复 DS，
    POP DS
    
    POP DX        ; 恢复 DX
    POP BX        ; 恢复 BX
    POP AX        ; 恢复 AX
    RET           ; 子程序返回
HTOASC ENDP

; --- 子程序的数据区 (在 .CODE 段中) ---
ASCII DB '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
      DB 'A', 'B', 'C', 'D', 'E', 'F'

; ====================================================================
; 主程序
; ====================================================================
MAIN PROC
    ; 准备入口参数：一个 2 位十六进制数
    MOV AL, 0F7H  ; 示例：AL = F7H (将显示 'F' 和 '7')
    
    ; 调用外层子程序
    CALL ALDISP
    
    ; 退出程序
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN