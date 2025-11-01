; 例：通过变量传递参数计算数组校验和 (CHECKSUM_B)
; 功能：计算一个数组元素的校验和（16位完整累加），使用全局变量传递参数。
; 入口参数 (变量)：array, count
; 出口参数 (变量)：result

.MODEL SMALL
.STACK 100H

.DATA
    array   DB 100,200,150,200,200   ; 示例数组
    count   DW ($-array)             ; 元素个数 (5)
    result  DW ?                     ; 存储16位校验和结果 (0-65535)

.CODE
.STARTUP                            ; 程序入口点，自动初始化 DS

    ; --- 主程序逻辑 ---
    ; 直接调用子程序，参数通过全局变量传递
    CALL CHECKSUM_B                  ; 调用校验和计算子程序

.EXIT 0                             ; 程序终止，返回 DOS

; --- 子程序定义 ---
CHECKSUM_B PROC
    ; 1. 保护现场：保存将要修改的寄存器
    PUSH AX                          ; 保存 AX (用于累加)
    PUSH BX                          ; 保存 BX (用于数组寻址)
    PUSH CX                          ; 保存 CX (用于循环计数)

    ; 2. 初始化累加器
    XOR AX, AX                       ; AX ← 0，清零16位累加器

    ; 3. 加载参数 (从全局变量)
    MOV BX, OFFSET array             ; BX ← 数组偏移地址
    MOV CX, count                    ; CX ← 元素个数

AGAIN:
    ; 4. 循环体：累加数组元素
    ADD AL, [BX]                     ; AL ← AL + [DS:BX]，累加到低8位
    ADC AH, 0                        ; AH ← AH + 0 + CF，处理进位到高8位
    INC BX                           ; BX ← BX + 1，指向下一个数组元素
    LOOP AGAIN                       ; CX--, JNZ AGAIN，循环直到所有元素处理完毕

    ; 5. 保存结果到全局变量
    MOV result, AX                   ; result ← AX (16位校验和结果)

    ; 6. 恢复现场：按相反顺序恢复寄存器
    POP CX                           ; 恢复 CX
    POP BX                           ; 恢复 BX
    POP AX                           ; 恢复 AX

    RET                              ; 子程序返回
CHECKSUM_B ENDP

END                                 ; 汇编结束