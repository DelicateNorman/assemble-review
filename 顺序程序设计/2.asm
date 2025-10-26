; 例 4.2：自然数求和程序 (公式法：(N+1) * N / 2)
; 功能：计算 1 到 N 的自然数之和 (N <= 65535)，使用 32 位运算。

.MODEL SMALL
.STACK 100H

.DATA
    NUM DW 100      ; N值 (16位，求和到 100)
    ; 100 * 101 / 2 = 5050 (小于 65535)，但使用 32 位变量是稳妥的处理方式。
    SUM DW 0, 0     ; 预留双倍长变量 (32位) 保存求和结果 (低字在前，高字在后)
    
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; --- 顺序执行流程 ---
    
    ; 1. 计算 N + 1
    MOV AX, NUM     ; AX ← N
    INC AX          ; AX ← N + 1 (现在 AX = 101)
    
    MOV BX, NUM     ; BX ← N (现在 BX = 100)
    
    ; 2. 计算乘法：(N+1) * N
    ; DX:AX ← AX * BX = 101 * 100 = 10100
    MUL BX          ; 无符号乘法。结果 10100 (2774H) 存入 AX，DX=0
    
    ; 3. 计算除法： 乘积 / 2
    ; 使用右移 1 位实现 32 位数据 DX:AX 除以 2
    SHR DX, 1       ; DX (高 16 位) 逻辑右移 1 位
    RCR AX, 1       ; AX (低 16 位) 带进位循环右移 1 位
                    ; 原 DX 的最低位移入 AX 的最高位，完成 32 位右移
    
    ; 4. 保存结果 (结果在 DX:AX)
    MOV WORD PTR SUM+2, DX ; 保存高 16 位 (DX) 到 SUM 的高字 (SUM+2)
    MOV WORD PTR SUM, AX   ; 保存低 16 位 (AX) 到 SUM 的低字 (SUM)
    
    ; 退出程序
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN