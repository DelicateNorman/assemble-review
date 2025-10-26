; 例4.7：条件控制循环：将字符串中的所有大写字母改为小写字母
; 循环结束条件：遇到字符 '0'。

.MODEL SMALL
.STACK 100H

.DATA
    ; 待处理的字符串，以 '0' 作为结束标志
    STRING DB 'Hello WORLD! This Is A Test0'
    ; 显示消息
    MSG_BEFORE DB 'String before processing: $'
    MSG_AFTER DB 13, 10, 'String after processing: $'
    STRING_DISPLAY DB 'Hello WORLD! This Is A Test$', 13, 10, '$'  ; 用于显示的原始字符串副本 
    
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; 显示处理前的字符串
    LEA DX, MSG_BEFORE
    MOV AH, 09H
    INT 21H

    LEA DX, STRING_DISPLAY
    MOV AH, 09H
    INT 21H

    ; 初始化 SI 寄存器指向字符串首地址
    MOV SI, OFFSET STRING 
    
loop_start:
    ; 1. 循环控制部分：先判断是否遇到结束符 '0'
    
    MOV AL, [SI]        ; 读取当前字符到 AL
    CMP AL, '0'         ; 检查是否为结束符
    JE loop_end         ; 如果是 '0'，跳转到循环结束
    
    ; 2. 循环体内部的分支结构 (判断是否为大写字母)
    CMP AL, 'A'         ; 检查是否小于 'A'
    JB next_char        ; 不是大写字母（小于 'A'），跳过转换
    
    CMP AL, 'Z'         ; 检查是否大于 'Z'
    JA next_char        ; 不是大写字母（大于 'Z'），跳过转换
    
    ; 3. 转换逻辑：大写 -> 小写
    ADD AL, 32          ; ASCII码 + 32 (或 ADD AL, 20H)，实现大写转小写
    MOV [SI], AL        ; 写回转换后的字符
    
next_char:
    ; 4. 修改循环条件 (指向下一个字符)
    INC SI              ; 递增 SI 寄存器，指向字符串中的下一个字节
    
    ; 5. 无条件跳转回循环开始处继续判断
    JMP loop_start      
    
loop_end:
    ; 循环结束后的操作

    ; 将处理后的字符串的结束符从 '0' 改为 '$' 以便显示
    MOV SI, OFFSET STRING
find_end:
    MOV AL, [SI]
    CMP AL, '0'
    JE replace_end
    INC SI
    JMP find_end
replace_end:
    MOV BYTE PTR [SI], '$'

    ; 显示处理后的字符串
    LEA DX, MSG_AFTER
    MOV AH, 09H
    INT 21H

    LEA DX, STRING
    MOV AH, 09H
    INT 21H

    ; 退出程序
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN