; 例4.5：自然数求和程序
; 功能：计算 1 到 100 的自然数之和，并将结果存入字变量 SUM 中。
; 采用计数控制循环 (LOOP 指令)。

.MODEL SMALL ; 内存模式：SMALL
.STACK 100H  ; 定义堆栈大小

.DATA
    SUM DW ?   ; 预留字变量 (2字节) 来保存求和结果。
               ; 1到100的和为 5050 (小于 65535, 一个字足够存储)。
    
.CODE
MAIN PROC
    ; 初始化数据段寄存器 DS
    MOV AX, @DATA   
    MOV DS, AX
    
    ; --- 循环初始部分 ---
    XOR AX, AX      ; 初始化累加和 AX = 0。AX 将作为累加器。
    MOV CX, 100     ; 设置循环次数 CX = 100。
    
again:
    ; --- 循环体部分 ---
    ADD AX, CX      ; 累加：执行 AX = AX + CX。
                    ; CX 的值从 100 递减到 1，实现 100 + 99 + ... + 1 的累加。
    
    ; --- 循环控制部分 ---
    LOOP again      ; 1. CX = CX - 1
                    ; 2. 如果 CX != 0，则跳转到标签 'again'
                    ; 3. 如果 CX = 0，则执行下一条指令
    
    ; --- 循环结束后的操作 ---
    MOV SUM, AX     ; 将最终的求和结果 (AX) 存储到变量 SUM 中。
    
    ; 退出程序 其实也可以写exit 0 
    MOV AH, 4CH     
    INT 21H

MAIN ENDP
END