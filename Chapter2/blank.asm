; 例 2.45：记录空格个数
; 功能：计算字符串 STRING 中空格 (20H) 的数量，并将结果存入 RESULT。
; 采用计数控制循环 (LOOP 指令)。

.MODEL SMALL
.STACK 100H

.DATA
    STRING DB ' This is a test string with spaces. '
    COUNT  EQU ($-STRING)       ; 字符串的长度，$-STRING就是STRING的长度
    RESULT DW ?                 ; 存储最终的空格计数 (使用 DW 保证和 BX 匹配)
    
.CODE
.STARTUP ; 程序入口点，自动完成 MOV AX, @DATA 和 MOV DS, AX (方案 B 结构)

    ; --- 循环初始部分 ---
    ; 在 .STARTUP 结构中，ES 默认也指向数据段，但为明确使用 ES:[SI] 寻址，显式设置 ES=DS
    MOV AX,DS
    MOV ES, AX                ; 设置 ES = DS，以支持 ES:[SI] 寻址
    
    MOV CX, COUNT               ; 设置循环次数 CX ← 字符串长度 COUNT
    MOV SI, OFFSET STRING       ; SI ← 字符串起始地址
    XOR BX, BX                  ; BX ← 0，用 BX 记录空格数 (出口参数)

    ; MOV AL, 20H ; AL ← 20H (空格的 ASCII 码)

    ; 1. 循环控制：先判断
    ; JCXZ (Jump if CX is Zero): 如果 CX=0，跳过循环
    JCXZ DONE                   
    
    ; MOV AL, 20H 指令应该放在循环之前，或者不需要
    MOV AL, 20H                 ; AL ← 20H (空格的 ASCII 码)

AGAIN:
    ; --- 循环体内部：判断是否是空格 ---
    
    ; 比较 AL (空格 20H) 和 ES:[SI] (当前字符)
    CMP AL, ES:[SI]             
    
    ; JNZ (Jump if Not Zero): ZF=0 非空格，转移
    JNZ NEXT                    
    
    ; ZF=1 是空格，执行分支体
    INC BX                      ; BX ← BX + 1，空格数加 1

NEXT: 
    INC SI                      ; SI ← SI + 1，指向下一个字符

    ; --- 循环控制部分 ---
    LOOP AGAIN                  ; CX 自动减 1，若 CX != 0 则跳转到 AGAIN

DONE: 
    ; --- 循环结束后的操作 ---
    MOV RESULT, BX              ; 保存结果 BX (空格数)

.EXIT 0 ; 退出程序，自动生成 MOV AH, 4CH / INT 21H

END ; 汇编结束