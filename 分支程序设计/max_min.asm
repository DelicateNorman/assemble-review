; 例：查找数组最大值和最小值 (MAX_MIN)
; 功能：在一个数组中查找最大值和最小值，并使用分支程序设计实现条件判断。
; 主要技术：
; 1. 使用条件跳转指令 (JA, JBE) 实现分支逻辑
; 2. 使用循环结构遍历数组元素
; 3. 使用子程序实现模块化设计
; 4. 实现多位数的DOS输出功能

.MODEL SMALL
.STACK 100H                         ; 设置堆栈大小，确保子程序调用安全

.DATA
    array   DW 1,2,3,4,5,6,7,8,9,10 ; 示例数组：10个word类型数据
    count   EQU 10                   ; 数组元素个数 (常量)
    minimal DW ?                     ; 存储最小值结果 (2字节)
    maximum DW ?                     ; 存储最大值结果 (2字节)

    ; DOS输出用字符串 (以'$'为结束符)
    max_msg DB 'Maximum value: $'    ; 最大值提示信息
    min_msg DB 0Dh,0Ah,'Minimum value: $' ; 换行+最小值提示信息

.CODE
.STARTUP                            ; 程序入口点，自动初始化DS

    ; --- 主程序逻辑 ---

    ; 1. 查找并存储最大值
    CALL SOLVE_MAX                  ; 调用查找最大值子程序，结果存入maximum变量

    ; 2. 查找并存储最小值
    CALL SOLVE_MIN                  ; 调用查找最小值子程序，结果存入minimal变量

    ; 3. 输出结果
    CALL OUTPUT_RESULTS             ; 调用结果输出子程序，显示最大值和最小值

.EXIT 0                             ; 程序终止，返回DOS (生成 MOV AH,4CH / INT 21H)
; ====================================================================
; 子程序 1: 查找数组最大值 (SOLVE_MAX)
; 功能：在数组中查找最大值，使用分支逻辑进行比较判断
; 算法：遍历数组，使用条件跳转指令比较并更新最大值
; 出口参数：将最大值存储到全局变量 maximum 中
; ====================================================================
SOLVE_MAX PROC
    ; 1. 保护现场：保存将要修改的寄存器
    PUSH BX                          ; 保存 BX (用于数组寻址)
    PUSH CX                          ; 保存 CX (用于循环计数)

    ; 2. 初始化查找参数
    MOV BX, OFFSET array             ; BX ← 数组首地址，用于寻址
    MOV CX, count                    ; CX ← 数组元素个数，循环计数器
    MOV AX, [BX]                     ; AX ← 第一个元素，作为初始最大值

AGAIN:
    ; 3. 分支逻辑：比较当前元素与最大值
    CMP AX, [BX]                     ; 比较 AX 与当前数组元素
    JA NO_PROCESS                    ; 如果 AX > [BX]，跳过更新 (JA: Jump if Above)

    ; 4. 更新最大值 (仅当当前元素更大时)
    MOV AX, [BX]                     ; AX ← [BX]，更新为更大的值

NO_PROCESS:
    ; 5. 移动到下一个元素
    INC BX                           ; BX ← BX + 1 (字节数组需要+2)
    INC BX                           ; BX ← BX + 1，总共+2 (word类型)
    LOOP AGAIN                       ; CX--, JNZ AGAIN，继续循环直到遍历完毕

    ; 6. 保存结果
    MOV maximum, AX                  ; maximum ← AX，存储最终最大值

    ; 7. 恢复现场
    POP CX                           ; 恢复 CX
    POP BX                           ; 恢复 BX

    RET                              ; 子程序返回
SOLVE_MAX ENDP

; ====================================================================
; 子程序 2: 查找数组最小值 (SOLVE_MIN)
; 功能：在数组中查找最小值，使用分支逻辑进行比较判断
; 算法：遍历数组，使用条件跳转指令比较并更新最小值
; 出口参数：将最小值存储到全局变量 minimal 中
; ====================================================================
SOLVE_MIN PROC
    ; 1. 保护现场：保存将要修改的寄存器
    PUSH BX                          ; 保存 BX (用于数组寻址)
    PUSH CX                          ; 保存 CX (用于循环计数)

    ; 2. 初始化查找参数
    MOV BX, OFFSET array             ; BX ← 数组首地址，用于寻址
    MOV CX, count                    ; CX ← 数组元素个数，循环计数器
    MOV AX, [BX]                     ; AX ← 第一个元素，作为初始最小值

AGAIN1:
    ; 3. 分支逻辑：比较当前元素与最小值
    CMP AX, [BX]                     ; 比较 AX 与当前数组元素
    JBE NO_PROCESS1                  ; 如果 AX ≤ [BX]，跳过更新 (JBE: Jump if Below or Equal)

    ; 4. 更新最小值 (仅当当前元素更小时)
    MOV AX, [BX]                     ; AX ← [BX]，更新为更小的值

NO_PROCESS1:
    ; 5. 移动到下一个元素
    INC BX                           ; BX ← BX + 1 (字节数组需要+2)
    INC BX                           ; BX ← BX + 1，总共+2 (word类型)
    LOOP AGAIN1                      ; CX--, JNZ AGAIN1，继续循环直到遍历完毕

    ; 6. 保存结果
    MOV minimal, AX                  ; minimal ← AX，存储最终最小值

    ; 7. 恢复现场
    POP CX                           ; 恢复 CX
    POP BX                           ; 恢复 BX

    RET                              ; 子程序返回
SOLVE_MIN ENDP

; ====================================================================
; 子程序 3: DOS功能调用输出结果 (OUTPUT_RESULTS)
; 功能：显示最大值和最小值的查找结果
; 调用：使用DOS INT 21H功能09H显示字符串，调用OUTPUT_NUMBER显示数字
; ====================================================================
OUTPUT_RESULTS PROC
    ; 1. 保护现场：保存将要修改的寄存器
    PUSH AX                          ; 保存 AX (用于传递数字给输出子程序)
    PUSH DX                          ; 保存 DX (用于DOS字符串输出)

    ; 2. 输出最大值提示信息
    MOV AH, 09H                      ; AH ← DOS功能号09H (字符串输出)
    LEA DX, max_msg                  ; DX ← 最大值提示字符串的偏移地址
    INT 21H                          ; 调用DOS中断，显示 "Maximum value: "

    ; 3. 输出最大值数值
    MOV AX, maximum                  ; AX ← 最大值 (传递给数字输出子程序)
    CALL OUTPUT_NUMBER               ; 调用数字输出子程序，显示多位数

    ; 4. 输出最小值提示信息 (包含换行)
    MOV AH, 09H                      ; AH ← DOS功能号09H (字符串输出)
    LEA DX, min_msg                  ; DX ← 最小值提示字符串的偏移地址
    INT 21H                          ; 调用DOS中断，显示换行和 "Minimum value: "

    ; 5. 输出最小值数值
    MOV AX, minimal                  ; AX ← 最小值 (传递给数字输出子程序)
    CALL OUTPUT_NUMBER               ; 调用数字输出子程序，显示多位数

    ; 6. 恢复现场
    POP DX                           ; 恢复 DX
    POP AX                           ; 恢复 AX

    RET                              ; 子程序返回
OUTPUT_RESULTS ENDP

; ====================================================================
; 子程序 4: 输出数字过程 (OUTPUT_NUMBER)
; 功能：将AX中的16位数字转换为ASCII码并在屏幕上显示
; 入口参数：AX = 要输出的数字 (0-65535)
; 算法：使用除10取余法，从低位到高位分解数字，利用堆栈逆序输出
; ====================================================================
OUTPUT_NUMBER PROC
    ; 1. 保护现场：保存所有将要修改的寄存器
    PUSH AX                          ; 保存 AX (包含待输出数字)
    PUSH BX                          ; 保存 BX (用作除数)
    PUSH CX                          ; 保存 CX (用作位数计数器)
    PUSH DX                          ; 保存 DX (用于余数和字符输出)

    ; 2. 初始化除法参数
    MOV CX, 0                        ; CX ← 0，数字位数计数器
    MOV BX, 10                       ; BX ← 10，除数 (十进制分解)

DIVIDE_LOOP:
    ; 3. 16位除法：分解数字的最后一位
    XOR DX, DX                       ; DX ← 0，清除高位，确保DX:AX作为被除数
    DIV BX                           ; AX = AX / 10 (商), DX = AX % 10 (余数)

    ; 4. 将余数转换为ASCII字符并压栈
    ADD DL, '0'                      ; DL ← DL + '0'，将数字(0-9)转换为ASCII字符
    PUSH DX                          ; 将ASCII字符压入堆栈 (低位数字先入栈)
    INC CX                           ; CX ← CX + 1，位数计数器加1

    ; 5. 检查是否继续分解
    TEST AX, AX                      ; 测试商是否为0 (AX == 0 ?)
    JNZ DIVIDE_LOOP                  ; 如果商不为0，继续除法分解

PRINT_LOOP:
    ; 6. 从堆栈弹出并显示字符 (高位先出，实现正确顺序)
    POP DX                           ; DX ← 弹出ASCII字符 (高位数字先出)
    MOV AH, 02H                      ; AH ← DOS功能号02H (字符输出)
    INT 21H                          ; 调用DOS中断，显示字符
    LOOP PRINT_LOOP                  ; CX--, JNZ PRINT_LOOP，显示所有位数的字符

    ; 7. 恢复现场 (按相反顺序)
    POP DX                           ; 恢复 DX
    POP CX                           ; 恢复 CX
    POP BX                           ; 恢复 BX
    POP AX                           ; 恢复 AX

    RET                              ; 子程序返回
OUTPUT_NUMBER ENDP

END                                 ; 汇编结束