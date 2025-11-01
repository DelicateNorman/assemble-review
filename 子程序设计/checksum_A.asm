; 例：通过寄存器传递参数计算数组校验和 (CHECKSUM_A)
; 功能：计算一个数组元素的校验和（16位完整累加），使用寄存器传递参数。
; 入口参数 (寄存器)：BX (数组偏移地址), CX (元素个数)。
; 出口参数 (寄存器)：AX (16位校验和)，AL为低8位，AH为高8位。

.MODEL SMALL
.STACK 100H

.DATA
    ARRAY   DB 10,20,30,40,50      ; 示例数组
    COUNT   DW ($-ARRAY)           ; 元素个数 (5)
    RESULT  DW ?                   ; 存储16位校验和结果 (0-65535)

.CODE
.STARTUP                          ; 程序入口点，自动初始化 DS

    ; --- 主程序逻辑 ---

    ; 1. 设置入口参数 (寄存器传递)
    MOV BX, OFFSET ARRAY           ; BX ← 数组的偏移地址 (参数1)
    MOV CX, COUNT                  ; CX ← 元素个数 (参数2)

    ; 2. 调用子程序
    CALL CHECKSUM_A                ; 调用校验和计算子程序

    ; 3. 保存出口参数
    MOV RESULT, AX                ; RESULT ← AX (16位校验和结果)

.EXIT 0                           ; 程序终止，返回 DOS

; --- 子程序定义 ---
CHECKSUM_A PROC
    ; 1. 初始化累加器
    XOR AX, AX                     ; AX ← 0，清零16位累加器 (AH和AL都清零)

AGAIN:
    ; 2. 循环体：累加数组元素
    ADD AL, [BX]                   ; AL ← AL + [DS:BX]，累加到低8位
    ADC AH, 0                      ; AH ← AH + 0 + CF，处理进位到高8位
    INC BX                         ; BX ← BX + 1，指向下一个数组元素
    LOOP AGAIN                     ; CX--, JNZ AGAIN，循环直到所有元素处理完毕

    RET                            ; 子程序返回
CHECKSUM_A ENDP

END                               ; 汇编结束