; 例：通过堆栈传递参数计算数组校验和 (CHECKSUM_C)
; 功能：计算一个数组元素的校验和（16位完整累加），使用堆栈传递参数。
; 入口参数 (堆栈)：数组偏移地址 (2字节), 元素个数 (2字节)
; 出口参数 (寄存器)：AX (16位校验和)

.MODEL SMALL
.STACK 100H                         ; 确保堆栈足够大

.DATA
    array   DB 100,200,150,200,200   ; 示例数组
    count   DW ($-array)             ; 元素个数 (5)
    result  DW ?                     ; 存储16位校验和结果 (0-65535)

.CODE
.STARTUP
    ; --- 主程序逻辑 ---

    ; 1. 将参数压入堆栈 (从右向左压入，C调用约定)
    MOV AX, OFFSET array             ; AX ← 数组偏移地址
    PUSH AX                          ; 压入参数1 (数组地址)

    MOV AX, count                    ; AX ← 元素个数
    PUSH AX                          ; 压入参数2 (元素个数)

    ; 2. 调用子程序
    CALL CHECKSUM_C                  ; 调用校验和计算子程序

    ; 3. 保存结果
    MOV result, AX                   ; result ← AX (16位校验和结果)

    ; 4. 清理堆栈 (主程序负责)
    ADD SP, 4                        ; 恢复栈平衡：清理2个word参数 (4字节)

.EXIT 0                             ; 程序终止

; --- 子程序定义 ---
CHECKSUM_C PROC
    ; 1. 建立栈帧，保护调用者的BP
    PUSH BP                          ; 保存旧的BP值
    MOV BP, SP                       ; BP ← SP，建立当前栈帧

    ; 2. 保护现场：保存将要修改的寄存器
    PUSH BX                          ; 保存 BX (用于数组寻址)
    PUSH CX                          ; 保存 CX (用于循环计数)

    ; 3. 从堆栈获取参数
    ; 堆栈布局 (从低地址到高地址)：
    ; [BP+0] = 旧BP值
    ; [BP+2] = 返回地址(IP)
    ; [BP+4] = 元素个数 (count)
    ; [BP+6] = 数组偏移地址 (offset array)
    MOV BX, [BP+6]                   ; BX ← 数组偏移地址 (参数1)
    MOV CX, [BP+4]                   ; CX ← 元素个数 (参数2)

    ; 4. 初始化累加器
    XOR AX, AX                       ; AX ← 0，清零16位累加器

AGAIN:
    ; 5. 循环体：累加数组元素
    ADD AL, [BX]                     ; AL ← AL + [DS:BX]，累加到低8位
    ADC AH, 0                        ; AH ← AH + 0 + CF，处理进位到高8位
    INC BX                           ; BX ← BX + 1，指向下一个数组元素
    LOOP AGAIN                       ; CX--, JNZ AGAIN，循环直到所有元素处理完毕

    ; 6. 恢复现场 (按相反顺序)
    POP CX                           ; 恢复 CX
    POP BX                           ; 恢复 BX

    ; 7. 恢复调用者的栈帧
    POP BP                           ; 恢复旧的BP值

    RET                              ; 子程序返回 (栈顶恢复到CALL之前)
CHECKSUM_C ENDP

END                                 ; 汇编结束

