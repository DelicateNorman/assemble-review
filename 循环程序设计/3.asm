; 例4.8：多重循环：冒泡排序 (从小到大)
; 假设数组长度为 N，需要 N-1 次外循环。
; 每次外循环需要进行 N-i 次内循环比较。

.MODEL SMALL
.STACK 100H

.DATA
    ; 待排序数组 (N=5)
    ARRAY   DB 92, 55, 30, 78, 41
    LENGTH  EQU ($-ARRAY) ; 数组长度 N = 5
    
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; --- 外循环初始化 ---
    ; 外循环次数: LENGTH - 1 = 4 次 (共 N 个元素，只需 N-1 趟)
    MOV CX, LENGTH          ; CX = 5
    DEC CX                  ; CX = 4 (外循环次数)
    
OuterLoop:
    ; --- 内循环初始化 ---
    ; 内循环次数: CX (内循环次数在外循环中递减)
    PUSH CX                 ; 保护外循环计数器 CX
    MOV CH, 0               ; 清零 CH (或 MOV DX, CX)，确保 DX 只有 8 位
    MOV DL, CL              ; 将当前的外循环次数 CL 赋给 DL 作为内循环计数器
    
    MOV SI, OFFSET ARRAY    ; SI 指向数组首地址 (始终指向第一个比较元素)
    
InnerLoop:
    ; 1. 循环体内部的分支结构 (比较相邻元素)
    MOV AL, [SI]            ; AL = ARRAY[i]
    MOV BL, [SI+1]          ; BL = ARRAY[i+1]
    
    CMP AL, BL              ; 比较两个元素
    JBE NextCompare         ; 如果 AL <= BL (已排序或相等)，则不需要交换，跳过
    
    ; 2. 交换逻辑 (如果 AL > BL)
    MOV [SI], BL            ; ARRAY[i] = BL (较小值)
    MOV [SI+1], AL          ; ARRAY[i+1] = AL (较大值)
    
NextCompare:
    ; 3. 修改内循环条件
    INC SI                  ; 检查下一对相邻元素
    
    ; 4. 内循环控制 (使用 DL 计数器和 JNZ)
    DEC DL                  ; 内循环计数器 - 1
    JNZ InnerLoop           ; 如果 DL != 0，继续内循环
    
    ; --- 外循环控制 ---
    POP CX                  ; 恢复外循环计数器 CX
    LOOP OuterLoop          ; CX--，如果 CX != 0，继续外循环
    
    ; 排序完成，结果在 ARRAY 中。

    ; 退出程序
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN