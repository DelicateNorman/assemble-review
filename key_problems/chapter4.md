# 第四章基本汇编语言程序设计 - 重点题目解答

## 目录
1. [4.6 比较两个8位无符号数大小](#46-比较两个8位无符号数大小)
2. [4.14 有符号数数组分离](#414-有符号数数组分离)
3. [4.16 搜索DEBUG字符串](#416-搜索debug字符串)
4. [4.28 大小写转换子程序](#428-大小写转换子程序)
5. [4.29 三种参数传递的十六进制显示](#429-三种参数传递的十六进制显示)
6. [4.30 成绩分段统计](#430-成绩分段统计)
7. [4.31 递归计算指数函数](#431-递归计算指数函数)

---

## 4.6 比较两个8位无符号数大小

### 题目要求
编制一个程序，把变量bufX和bufY中较大者存入bufZ；若两者相等，则把其中之一存入bufZ中。假设变量存放的是8位无符号数。

### 题目分析
- 需要比较两个8位无符号数的大小
- 使用CMP指令进行比较，配合JA（高于则转移）指令
- 无符号数比较使用JA/JB等指令，有符号数使用JG/JL等指令

### 算法设计
1. 将bufX加载到AL寄存器
2. 将bufY加载到另一个寄存器或直接与AL比较
3. 使用CMP指令比较两者大小
4. 根据比较结果将较大的数存入bufZ

### 完整代码
```asm
.MODEL SMALL
.STACK 100H
.DATA
    bufX DB 45h        ; 第一个8位无符号数
    bufY DB 78h        ; 第二个8位无符号数
    bufZ DB ?          ; 存储较大值
.CODE
MAIN PROC
    ; 初始化数据段
    MOV AX, @DATA
    MOV DS, AX

    ; 比较两个数的大小
    MOV AL, bufX       ; AL ← bufX
    CMP AL, bufY       ; 比较AL与bufY
    JA  storeX         ; 如果AL > bufY，转存储X

    ; bufY >= bufX，存储bufY
    MOV AL, bufY
    MOV bufZ, AL
    JMP done

storeX:
    ; bufX > bufY，存储bufX
    MOV bufZ, AL

done:
    ; 程序结束，返回DOS
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
```

### 代码说明
- `JA` (Jump Above)：无符号数比较时，如果目的操作数大于源操作数则转移
- 使用双分支结构，确保一定有一个值被存入bufZ
- 当两数相等时，第二个分支会执行，将bufY存入bufZ（符合题目要求）

---

## 4.14 有符号数数组分离

### 题目要求
编写程序，将一个包含有20个有符号数据的数组arrayM分成两个数组：正数数组arrayP和负数数组arrayN，并分别把这两个数组中的数据个数显示出来。

### 题目分析
- 需要遍历20个有符号数
- 根据符号位判断是正数还是负数
- 分别统计正数和负数的个数
- 显示统计结果

### 算法设计
1. 初始化指针和计数器
2. 循环遍历数组中的每个元素
3. 测试符号位，判断正负
4. 分别存入对应的数组并计数
5. 显示统计结果

### 完整代码
```asm
.MODEL SMALL
.STACK 100H
.DATA
    ; 原始数组（20个有符号数）
    arrayM DB 12, -34, 56, -78, 90, -12, 34, -56, 78, -90
           DB 23, -45, 67, -89, 10, -32, 54, -76, 98, -21

    ; 正数数组（最多20个）
    arrayP DB 20 DUP(?)
    countP DB 0

    ; 负数数组（最多20个）
    arrayN DB 20 DUP(?)
    countN DB 0

    ; 显示消息
    msgPos DB 'Positive numbers: $'
    msgNeg DB 'Negative numbers: $'
    crlf DB 0DH, 0AH, '$'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; 初始化指针
    LEA SI, arrayM      ; SI指向原始数组
    LEA DI, arrayP      ; DI指向正数数组
    LEA BX, arrayN      ; BX指向负数数组
    MOV CX, 20          ; 循环20次

process_loop:
    MOV AL, [SI]        ; 取出一个数据
    TEST AL, 80H        ; 测试符号位
    JZ is_positive      ; 符号位为0，是正数

is_negative:
    MOV [BX], AL        ; 存入负数数组
    INC BX              ; 负数数组指针后移
    INC countN          ; 负数计数器加1
    JMP next_element

is_positive:
    MOV [DI], AL        ; 存入正数数组
    INC DI              ; 正数数组指针后移
    INC countP          ; 正数计数器加1

next_element:
    INC SI              ; 原始数组指针后移
    LOOP process_loop   ; 继续处理下一个元素

    ; 显示正数个数
    LEA DX, msgPos
    MOV AH, 9
    INT 21H

    MOV AL, countP
    CALL display_digit

    ; 换行
    LEA DX, crlf
    MOV AH, 9
    INT 21H

    ; 显示负数个数
    LEA DX, msgNeg
    MOV AH, 9
    INT 21H

    MOV AL, countN
    CALL display_digit

    ; 程序结束
    MOV AH, 4CH
    INT 21H

MAIN ENDP

; 显示数字子程序（AL中的数字，0-99）
display_digit PROC
    PUSH AX
    PUSH BX
    PUSH DX

    ; 处理十位数
    MOV BL, 10
    DIV BL              ; AL = AL / 10, AH = 余数

    ADD AL, '0'         ; 十位数转ASCII
    MOV DL, AL
    MOV AH, 2
    INT 21H

    ; 处理个位数
    MOV AL, AH
    ADD AL, '0'         ; 个位数转ASCII
    MOV DL, AL
    MOV AH, 2
    INT 21H

    POP DX
    POP BX
    POP AX
    RET
display_digit ENDP

END MAIN
```

### 代码说明
- `TEST AL, 80H`：测试AL寄存器的最高位（符号位）
- 使用三个指针分别管理三个数组
- `display_digit`子程序用于显示两位数
- 统计结果分别存放在countP和countN中

---

## 4.16 搜索DEBUG字符串

### 题目要求
编写程序，判断主存0070H:0开始的1KB中有无字符串"DEBUG"。这是一个字符串包含的问题，可以采用逐个向后比较的简单算法。

### 题目分析
- 需要在1KB内存空间中搜索特定字符串
- 字符串"DEBUG"长度为5个字符
- 使用串操作指令或循环比较
- 找到则显示成功信息，否则显示失败信息

### 算法设计
1. 设置源地址为0070H:0000H
2. 设置搜索范围为1KB-5+1字节
3. 逐个位置比较是否为"DEBUG"
4. 找到则退出，否则继续搜索
5. 显示搜索结果

### 完整代码
```asm
.MODEL SMALL
.STACK 100H
.DATA
    target DB 'DEBUG'   ; 目标字符串
    targetLen EQU $ - target

    msgFound DB 'String "DEBUG" found!', 0DH, 0AH, '$'
    msgNotFound DB 'String "DEBUG" not found!', 0DH, 0AH, '$'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; 设置搜索段地址为0070H
    MOV AX, 0070H
    MOV ES, AX          ; ES = 0070H

    ; 初始化搜索指针
    MOV DI, 0           ; ES:DI = 0070H:0000H
    MOV CX, 1024 - targetLen + 1  ; 搜索范围

    ; 设置目标字符串指针
    LEA SI, target

search_loop:
    PUSH CX             ; 保存外层计数器
    PUSH SI             ; 保存源字符串指针
    PUSH DI             ; 保存当前搜索位置

    ; 内层循环：比较5个字符
    MOV CX, targetLen

compare_loop:
    MOV AL, ES:[DI]     ; 取出内存中的字符
    CMP AL, [SI]        ; 与目标字符比较
    JNE not_match       ; 不匹配，跳出内层循环

    INC SI              ; 目标字符串指针后移
    INC DI              ; 内存指针后移
    LOOP compare_loop   ; 继续比较下一个字符

    ; 全部匹配，找到字符串
    JMP found

not_match:
    POP DI              ; 恢复当前搜索位置
    POP SI              ; 恢复目标字符串指针
    POP CX              ; 恢复外层计数器

    INC DI              ; 移动到下一个搜索位置
    LOOP search_loop    ; 继续搜索

    ; 搜索完仍未找到
    JMP not_found

found:
    POP DI              ; 清理堆栈
    POP SI
    POP CX

    ; 显示找到消息
    LEA DX, msgFound
    MOV AH, 9
    INT 21H
    JMP done

not_found:
    ; 显示未找到消息
    LEA DX, msgNotFound
    MOV AH, 9
    INT 21H

done:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
```

### 代码说明
- 使用双重循环：外层控制搜索位置，内层进行字符比较
- 搜索范围为1024-5+1=1020字节
- 使用堆栈保存和恢复寄存器状态
- 段地址0070H需要加载到ES寄存器

---

## 4.28 大小写转换子程序

### 题目要求
编写一个子程序，根据入口参数AL为0、1、2，分别实现大写字母转换成小写字母、小写字母转换成大写字母或大小写字母互换。欲转换的字符串在string中，用0表示结束。

### 题目分析
- 需要根据AL的值（0/1/2）执行不同的转换逻辑
- AL=0：大写→小写
- AL=1：小写→大写
- AL=2：大小写互换
- 字符串以0结尾

### 算法设计
1. 根据AL值选择转换模式
2. 遍历字符串直到遇到0
3. 对每个字符判断是否为字母
4. 根据模式进行相应转换

### 完整代码
```asm
.MODEL SMALL
.STACK 100H
.DATA
    string DB 'Hello World! Assembly Programming', 0

    msgBefore DB 'Original string: $'
    msgAfter  DB 'Converted string: $'
    crlf     DB 0DH, 0AH, '$'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; 显示原始字符串
    LEA DX, msgBefore
    MOV AH, 9
    INT 21H

    LEA DX, string
    INT 21H

    ; 换行
    LEA DX, crlf
    INT 21H

    ; 测试不同转换模式
    LEA DX, msgAfter
    MOV AH, 9
    INT 21H

    ; 调用转换子程序（AL=2：大小写互换）
    MOV AL, 2
    LEA SI, string
    CALL convert_case

    ; 显示转换后的字符串
    LEA DX, string
    MOV AH, 9
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP

; 大小写转换子程序
; 入口参数：AL = 转换模式 (0=大写转小写, 1=小写转大写, 2=大小写互换)
;           SI = 字符串地址
; 出口参数：无（直接修改原字符串）
convert_case PROC
    PUSH AX
    PUSH BX
    PUSH SI

    MOV BL, AL          ; BL保存转换模式

convert_loop:
    MOV AL, [SI]        ; 取出一个字符
    CMP AL, 0           ; 检查是否为字符串结束符
    JE convert_done     ; 是0，结束转换

    ; 判断是否为大写字母
    CMP AL, 'A'
    JB not_uppercase
    CMP AL, 'Z'
    JA not_uppercase

    ; 是大写字母
    CMP BL, 0           ; 模式0：大写转小写
    JE to_lowercase
    CMP BL, 2           ; 模式2：大小写互换
    JE to_lowercase
    JMP next_char       ; 模式1：不转换大写

not_uppercase:
    ; 判断是否为小写字母
    CMP AL, 'a'
    JB not_lowercase
    CMP AL, 'z'
    JA not_lowercase

    ; 是小写字母
    CMP BL, 1           ; 模式1：小写转大写
    JE to_uppercase
    CMP BL, 2           ; 模式2：大小写互换
    JE to_uppercase
    JMP next_char       ; 模式0：不转换小写

not_lowercase:
    ; 不是字母，跳过
    JMP next_char

to_lowercase:
    ; 转换为小写字母（设置第5位为1）
    OR AL, 20H
    MOV [SI], AL
    JMP next_char

to_uppercase:
    ; 转换为大写字母（清除第5位）
    AND AL, 0DFH        ; 11011111B
    MOV [SI], AL

next_char:
    INC SI              ; 指向下一个字符
    JMP convert_loop

convert_done:
    POP SI
    POP BX
    POP AX
    RET
convert_case ENDP

END MAIN
```

### 代码说明
- 大写字母范围：'A'-'Z' (41H-5AH)
- 小写字母范围：'a'-'z' (61H-7AH)
- 大小写转换原理：大写与小写字母的第5位不同
  - 大写字母：第5位为0
  - 小写字母：第5位为1
- `OR AL, 20H`：设置第5位，大写转小写
- `AND AL, 0DFH`：清除第5位，小写转大写

---

## 4.29 三种参数传递的十六进制显示

### 题目要求
编写一个子程序，把一个16位二进制数用十六进制形式在屏幕上显示出来，分别用如下3种参数传递方法：
1. 采用AX寄存器传递这个16位二进制数
2. 采用堆栈方法传递这个16位二进制数
3. 采用wordTEMP变量传递这个16位二进制数

### 题目分析
- 需要实现三种不同的参数传递方式
- 16位二进制数需要显示为4位十六进制数
- 每位十六进制数需要转换为ASCII字符

### 算法设计
1. 将16位数分解为4个4位的十六进制位
2. 每个十六进制位转换为ASCII字符
3. 使用DOS功能调用显示字符

#### 方法1：寄存器传递参数
```asm
.MODEL SMALL
.STACK 100H
.DATA
    msgReg DB 'Register parameter: $'
    crlf   DB 0DH, 0AH, '$'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; 显示提示信息
    LEA DX, msgReg
    MOV AH, 9
    INT 21H

    ; 调用寄存器传递参数的显示子程序
    MOV AX, 1234H       ; 要显示的数
    CALL display_hex_reg

    ; 换行
    LEA DX, crlf
    MOV AH, 9
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP

; 使用寄存器传递参数的十六进制显示子程序
; 入口参数：AX = 要显示的16位数
display_hex_reg PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV CX, 4           ; 显示4个十六进制位
    MOV BX, AX          ; 保存要显示的数

disp_loop_reg:
    ; 处理高4位
    MOV DL, BH          ; 取高字节
    SHR DL, 4           ; 移到低4位
    CALL hex_to_ascii   ; 转换为ASCII
    MOV AH, 2
    INT 21H             ; 显示

    ; 处理低4位
    MOV DL, BH
    AND DL, 0FH         ; 保留低4位
    CALL hex_to_ascii
    MOV AH, 2
    INT 21H             ; 显示

    ; 处理下一个字节
    MOV BH, BL          ; 低字节移到高字节
    XOR BL, BL          ; 低字节清零
    LOOP disp_loop_reg

    POP DX
    POP CX
    POP BX
    POP AX
    RET
display_hex_reg ENDP

; 十六进制位转ASCII子程序
; 入口参数：DL = 4位十六进制数(0-15)
; 出口参数：DL = ASCII字符
hex_to_ascii PROC
    CMP DL, 9
    JLE is_digit
    ADD DL, 7           ; A-F需要加7
is_digit:
    ADD DL, '0'         ; 转换为ASCII
    RET
hex_to_ascii ENDP

END MAIN
```

#### 方法2：堆栈传递参数
```asm
; 堆栈传递参数的十六进制显示子程序
; 入口参数：堆栈中的16位数
display_hex_stack PROC
    PUSH BP
    MOV BP, SP
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV AX, [BP+6]      ; 从堆栈取出参数

    MOV CX, 4           ; 显示4个十六进制位
    MOV BX, AX          ; 保存要显示的数

disp_loop_stack:
    ; 处理高4位
    MOV DL, BH          ; 取高字节
    SHR DL, 4           ; 移到低4位
    CALL hex_to_ascii   ; 转换为ASCII
    MOV AH, 2
    INT 21H             ; 显示

    ; 处理低4位
    MOV DL, BH
    AND DL, 0FH         ; 保留低4位
    CALL hex_to_ascii
    MOV AH, 2
    INT 21H             ; 显示

    ; 处理下一个字节
    MOV BH, BL          ; 低字节移到高字节
    XOR BL, BL          ; 低字节清零
    LOOP disp_loop_stack

    POP DX
    POP CX
    POP BX
    POP AX
    POP BP
    RET
display_hex_stack ENDP

; 调用示例
    MOV AX, 1234H
    PUSH AX             ; 参数压栈
    CALL display_hex_stack
    ADD SP, 2           ; 平衡堆栈
```

#### 方法3：变量传递参数
```asm
.DATA
    wordTemp DW 1234H   ; 要显示的数
    msgVar  DB 'Variable parameter: $'

.CODE
; 变量传递参数的十六进制显示子程序
; 入口参数：wordTemp变量
display_hex_var PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV AX, wordTemp    ; 从变量取出参数

    MOV CX, 4           ; 显示4个十六进制位
    MOV BX, AX          ; 保存要显示的数

disp_loop_var:
    ; 处理高4位
    MOV DL, BH          ; 取高字节
    SHR DL, 4           ; 移到低4位
    CALL hex_to_ascii   ; 转换为ASCII
    MOV AH, 2
    INT 21H             ; 显示

    ; 处理低4位
    MOV DL, BH
    AND DL, 0FH         ; 保留低4位
    CALL hex_to_ascii
    MOV AH, 2
    INT 21H             ; 显示

    ; 处理下一个字节
    MOV BH, BL          ; 低字节移到高字节
    XOR BL, BL          ; 低字节清零
    LOOP disp_loop_var

    POP DX
    POP CX
    POP BX
    POP AX
    RET
display_hex_var ENDP

; 调用示例
    LEA DX, msgVar
    MOV AH, 9
    INT 21H

    CALL display_hex_var
```

### 代码说明
1. **寄存器传递**：直接使用AX寄存器传递参数，效率最高
2. **堆栈传递**：参数压入堆栈，子程序通过BP寄存器访问
3. **变量传递**：通过共享变量传递参数，需要访问内存
4. 三种方法的显示逻辑相同，只是参数获取方式不同

---

## 4.30 成绩分段统计

### 题目要求
设有一个数组存放学生的成绩（0～100），编写一个子程序，统计0～59分、60～69分、70～79分、80～89分、90～100分的人数，并分别存放到scoreE、scoreD、scoreC、scoreB及score单元中。编写一个主程序与之配合使用。

### 题目分析
- 需要统计5个分数段的人数
- 分数段划分：
  - scoreE: 0-59分（不及格）
  - scoreD: 60-69分（及格）
  - scoreC: 70-79分（中等）
  - scoreB: 80-89分（良好）
  - scoreA: 90-100分（优秀）

### 算法设计
1. 遍历成绩数组的每个元素
2. 使用多重分支判断成绩所属分数段
3. 对应的计数器加1
4. 显示统计结果

### 完整代码
```asm
.MODEL SMALL
.STACK 100H
.DATA
    ; 学生成绩数组
    scores DB 85, 92, 78, 65, 45, 88, 95, 72, 58, 83
           DB 67, 90, 76, 52, 98, 71, 84, 63, 77, 55
    count  EQU $ - scores

    ; 各分数段计数器
    scoreA DB 0  ; 90-100分
    scoreB DB 0  ; 80-89分
    scoreC DB 0  ; 70-79分
    scoreD DB 0  ; 60-69分
    scoreE DB 0  ; 0-59分

    ; 显示消息
    msgA DB '90-100: $'
    msgB DB '80-89:  $'
    msgC DB '70-79:  $'
    msgD DB '60-69:  $'
    msgE DB '0-59:   $'
    crlf DB 0DH, 0AH, '$'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; 调用统计子程序
    LEA SI, scores
    MOV CL, count
    CALL count_scores

    ; 显示统计结果
    LEA DX, msgA
    MOV AH, 9
    INT 21H
    MOV AL, scoreA
    CALL display_digit
    LEA DX, crlf
    INT 21H

    LEA DX, msgB
    MOV AH, 9
    INT 21H
    MOV AL, scoreB
    CALL display_digit
    LEA DX, crlf
    INT 21H

    LEA DX, msgC
    MOV AH, 9
    INT 21H
    MOV AL, scoreC
    CALL display_digit
    LEA DX, crlf
    INT 21H

    LEA DX, msgD
    MOV AH, 9
    INT 21H
    MOV AL, scoreD
    CALL display_digit
    LEA DX, crlf
    INT 21H

    LEA DX, msgE
    MOV AH, 9
    INT 21H
    MOV AL, scoreE
    CALL display_digit
    LEA DX, crlf
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP

; 成绩统计子程序
; 入口参数：SI = 成绩数组地址, CL = 学生人数
; 出口参数：scoreA, scoreB, scoreC, scoreD, scoreE = 各分数段人数
count_scores PROC
    PUSH AX
    PUSH SI
    PUSH CX

count_loop:
    MOV AL, [SI]        ; 取出一个成绩

    ; 判断成绩分数段
    CMP AL, 90
    JAE gradeA          ; >= 90

    CMP AL, 80
    JAE gradeB          ; >= 80

    CMP AL, 70
    JAE gradeC          ; >= 70

    CMP AL, 60
    JAE gradeD          ; >= 60

    JMP gradeE          ; < 60

gradeA:
    INC scoreA
    JMP next_student

gradeB:
    INC scoreB
    JMP next_student

gradeC:
    INC scoreC
    JMP next_student

gradeD:
    INC scoreD
    JMP next_student

gradeE:
    INC scoreE

next_student:
    INC SI              ; 指向下一个成绩
    LOOP count_loop     ; 继续统计

    POP CX
    POP SI
    POP AX
    RET
count_scores ENDP

; 显示数字子程序（AL中的数字）
display_digit PROC
    PUSH AX
    PUSH DX

    ADD AL, '0'         ; 转换为ASCII
    MOV DL, AL
    MOV AH, 2
    INT 21H

    POP DX
    POP AX
    RET
display_digit ENDP

END MAIN
```

### 代码说明
- 使用多重分支结构判断成绩所属分数段
- `JAE` (Jump Above or Equal)：无符号数大于等于则转移
- 统计结果分别存放在5个变量中
- 主程序负责显示统计结果

---

## 4.31 递归计算指数函数

### 题目要求
编写一递归子程序，计算指数函数X^n的值。

### 题目分析
- 指数函数的递归定义：X^n = X × X^(n-1)
- 递归终止条件：n = 0时，结果为1
- 需要考虑参数传递和结果返回
- 注意递归深度和堆栈管理

### 算法设计
1. 判断n是否为0，是则返回1
2. 递归调用计算X^(n-1)
3. 将结果乘以X得到最终结果

### 完整代码
```asm
.MODEL SMALL
.STACK 200H              ; 需要更大的堆栈空间
.DATA
    X       DW 3         ; 底数
    N       DW 4         ; 指数
    RESULT  DW ?         ; 结果

    msgX    DB 'X = $'
    msgN    DB ', N = $'
    msgRes  DB ', X^N = $'
    crlf    DB 0DH, 0AH, '$'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; 显示输入参数
    LEA DX, msgX
    MOV AH, 9
    INT 21H

    MOV AX, X
    CALL display_number

    LEA DX, msgN
    MOV AH, 9
    INT 21H

    MOV AX, N
    CALL display_number

    ; 调用递归计算子程序
    MOV AX, X            ; AX = X
    MOV BX, N            ; BX = N
    CALL power           ; 计算 X^N
    MOV RESULT, AX       ; 保存结果

    ; 显示结果
    LEA DX, msgRes
    MOV AH, 9
    INT 21H

    MOV AX, RESULT
    CALL display_number

    LEA DX, crlf
    MOV AH, 9
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP

; 递归计算指数函数子程序
; 入口参数：AX = X (底数), BX = N (指数)
; 出口参数：AX = X^N
power PROC
    PUSH BX
    PUSH CX
    PUSH DX

    CMP BX, 0           ; 检查指数是否为0
    JNE not_zero

    ; n = 0，返回1
    MOV AX, 1
    JMP power_done

not_zero:
    CMP BX, 1           ; 检查指数是否为1
    JNE recurse

    ; n = 1，返回X
    JMP power_done

recurse:
    ; 递归计算 X^(n-1)
    PUSH AX             ; 保存X

    DEC BX              ; 指数减1
    CALL power          ; 递归调用，计算 X^(n-1)

    ; 此时AX = X^(n-1)
    POP BX              ; 取出X到BX
    MUL BX              ; AX = AX * BX = X^(n-1) * X

power_done:
    POP DX
    POP CX
    POP BX
    RET
power ENDP

; 显示数字子程序（AX中的无符号数）
display_number PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV CX, 0           ; 数字位数计数器
    MOV BX, 10

convert_loop:
    XOR DX, DX          ; 清空DX
    DIV BX              ; AX / 10, 商在AX，余数在DX
    PUSH DX             ; 余数压栈
    INC CX              ; 位数加1
    TEST AX, AX         ; 检查商是否为0
    JNZ convert_loop    ; 不为0，继续转换

display_loop:
    POP DX              ; 取出一位数字
    ADD DL, '0'         ; 转换为ASCII
    MOV AH, 2
    INT 21H             ; 显示
    LOOP display_loop   ; 显示所有位

    POP DX
    POP CX
    POP BX
    POP AX
    RET
display_number ENDP

END MAIN
```

### 代码说明
- **递归过程**：
  - 每次递归调用将指数减1
  - 递归返回时将结果乘以底数
  - 递归终止条件：n=0时返回1，n=1时返回X
- **堆栈管理**：
  - 递归调用需要保护寄存器
  - 递归深度受堆栈大小限制
  - `.STACK 200H` 提供了512字节的堆栈空间
- **参数传递**：
  - 使用AX传递底数X
  - 使用BX传递指数N
  - 返回结果在AX中

---

## 总结

本章的重点题目涵盖了汇编语言程序设计的核心概念：

1. **分支程序设计**：4.6题展示了条件判断和分支结构
2. **循环程序设计**：4.14题、4.16题展示了不同类型的循环结构
3. **子程序设计**：4.28题、4.29题、4.30题、4.31题展示了子程序的设计和调用
4. **参数传递**：4.29题特别展示了三种不同的参数传递方法
5. **递归程序设计**：4.31题展示了递归子程序的实现

这些题目帮助理解汇编语言的基本程序结构，为后续学习打下坚实基础。