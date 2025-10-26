# 汇编语言程序设计期末考试试题（二）

**考试时间：** 120分钟
**总分：** 100分

---

## 一、单选题（10道题，每题2分，共20分）

**请将正确答案的选项填入题号前的括号内。**

1. **( )** 8086CPU中，用于存放堆栈段基地址的寄存器是：
   A. CS
   B. DS
   C. ES
   D. SS

2. **( )** 在下列指令中，属于合法的8086指令的是：
   A. MOV [SI], [DI]
   B. MOV CX, BL
   C. ADD DS, AX
   D. SUB [BX], 1234H

3. **( )** 执行指令SUB AX, BX后，如果AX=7FFFH，BX=8000H，则标志位OF和CF的状态是：
   A. OF=0, CF=0
   B. OF=0, CF=1
   C. OF=1, CF=0
   D. OF=1, CF=1

4. **( )** 串操作指令STOSW的功能是：
   A. 将ES:[DI]的内容传送到AX
   B. 将AX的内容传送到ES:[DI]
   C. 将DS:[SI]的内容传送到ES:[DI]
   D. 将ES:[DI]的内容传送到DS:[SI]

5. **( )** 在MASM中，用于定义双字变量的伪指令是：
   A. DB
   B. DW
   C. DD
   D. DQ

6. **( )** 下列转移指令中，转移范围最大的是：
   A. JMP SHORT label
   B. JMP NEAR PTR label
   C. JMP FAR PTR label
   D. JZ label

7. **( )** 执行指令MUL BL后，结果的乘积存放在：
   A. AX
   B. BX
   C. DX:AX
   D. AL:AH

8. **( )** 在简化段定义格式中，用于定义微型模型的伪指令是：
   A. .MODEL SMALL
   B. .MODEL TINY
   C. .MODEL COMPACT
   D. .MODEL LARGE

9. **( )** 下列指令中，可以改变DF标志位的是：
   A. CLD
   B. CLI
   C. STI
   D. CMC

10. **( )** 子程序返回指令RET 4的功能是：
    A. 从堆栈弹出返回地址，然后SP加4
    B. 从堆栈弹出返回地址，然后SP加4
    C. 从堆栈弹出返回地址，然后SP减4
    D. 从堆栈弹出返回地址，然后SP减4

---

## 二、填空题（10个，每空2分，共20分）

1. 8086CPU的20位地址总线可以寻址的最大存储空间是______MB，地址范围从00000H到______H。

2. 在8086指令系统中，LOOP指令的功能是CX减1，如果CX≠0则转移到______，该指令影响______寄存器。

3. 标志寄存器FLAGS中，OF表示______标志，SF表示______标志。

4. 在MASM中，EQU伪指令用于定义______，ORG伪指令用于设置______。

5. 执行指令TEST AX, 8000H后，如果AX的最高位为1，则ZF=______，SF=______。

6. 串操作指令CMPSB的功能是比较DS:[SI]和______的内容，比较结果影响______标志。

7. 在PE文件格式中，节区表包含______个节区头，每个节区头描述一个节区的______信息。

8. DOS功能调用中，AH=09H的功能是______，AH=4CH的功能是______。

9. 反汇编分析中，通过分析指令的______模式和______模式可以理解程序的执行流程。

10. 汇编语言中，变量可以具有______属性和______属性，分别表示变量的地址和类型。

---

## 三、指令正确与错误判断题（5条指令，每条2分，共10分）

**请判断下列指令是否正确，错误的指令请指出错误原因。**

1. `MOV [1000H], 1234H`
   - 判断：______
   - 错误原因（如错误）：______

2. `ADD AL, BX`
   - 判断：______
   - 错误原因（如错误）：______

3. `PUSH CS`
   - 判断：______
   - 错误原因（如错误）：______

4. `JMP WORD PTR [BX]`
   - 判断：______
   - 错误原因（如错误）：______

5. `DIV BL, AL`
   - 判断：______
   - 错误原因（如错误）：______

---

## 四、简答题（2题，每题8分，共16分）

1. **请简述8086CPU的存储器分段管理机制，包括段地址、偏移地址和物理地址的关系。**

2. **请简述子程序参数传递的常用方法，并比较各种方法的优缺点。**

---

## 五、程序阅读题（4段代码，每题5分，共20分）

**请补全下列代码片段中缺失的指令或操作数，并分析代码段的作用。**

### 1. 字符串查找程序（5分）

```assembly
.model small
.stack 100h
.data
string db 'This is a test string$'
char   db 't'
count  dw ?
.code
startup
    mov ax, @data
    mov ds, ax
    mov cx, lengthof string
    lea si, ______     ; 指向字符串
    mov al, ______     ; 要查找的字符
    cld
xor bx, bx         ; 计数器清零
search:
    scasb            ; 比较字符
    je found         ; 找到转移
    loop search
    jmp done
found:
    inc bx           ; 计数加1
    cmp di, offset string + lengthof string
    jb search
done:
    mov ______, bx   ; 保存查找结果
    exit 0
end
```

**代码段作用：** ________________________________________________

### 2. 数据排序程序（5分）

```assembly
.model small
.stack 100h
.data
array dw 15, 3, 8, 12, 7
n     equ ($-array)/2
.code
startup
    mov ax, @data
    mov ds, ax
    mov cx, n-1       ; 外层循环次数
outer:
    push cx
    mov si, 0         ; 内层循环索引
inner:
    mov ax, array[si]
    cmp ax, array[si+2]
    jle next          ; 不需要交换
    xchg ax, array[si+2]
    mov array[si], ax
next:
    add si, 2
    loop inner
    pop cx
    loop outer
    exit 0
end
```

**代码段作用：** ________________________________________________

### 3. 数制转换程序（5分）

```assembly
.model small
.stack 100h
.data
binary dw 10110101B
decimal db ?
.code
startup
    mov ax, @data
    mov ds, ax
    mov ax, ______     ; 取二进制数
    mov bx, 10         ; 除数
    xor cx, cx         ; 计数器清零
convert:
    xor dx, dx         ; 清零DX
    div bx             ; 除以10
    push dx            ; 余数压栈
    inc cx             ; 计数加1
    test ax, ax        ; 商是否为0
    jnz convert
    lea di, ______     ; 指向结果缓冲区
store:
    pop dx
    add dl, '0'        ; 转换为ASCII码
    mov [di], dl
    inc di
    loop store
    mov byte ptr [di], '$'
    exit 0
end
```

**代码段作用：** ________________________________________________

### 4. 条件分支程序（5分）

```assembly
.model small
.stack 100h
.data
score  dw 85
grade  db ?
msg1   db 'Excellent$'
msg2   db 'Good$'
msg3   db 'Pass$'
msg4   db 'Fail$'
.code
startup
    mov ax, @data
    mov ds, ax
    mov ax, ______     ; 取分数
    cmp ax, 90
    jae level1         ; 大于等于90
    cmp ax, 80
    jae level2         ; 大于等于80
    cmp ax, 60
    jae level3         ; 大于等于60
    mov grade, 'D'
    jmp display
level1:
    mov grade, 'A'
    jmp display
level2:
    mov grade, 'B'
    jmp display
level3:
    mov ______, 'C'    ; 设置等级
display:
    mov dl, grade
    mov ah, ______     ; 显示字符
    int 21h
    exit 0
end
```

**代码段作用：** ________________________________________________

---

## 六、程序设计题（14分）

**请使用简化段格式设计一个16位汇编程序，要求如下：**

**题目：** 设计一个程序，实现两个字符串的连接功能。要求从键盘输入两个字符串，将第二个字符串连接到第一个字符串的末尾，并显示连接后的结果。

**具体要求：**
1. 使用简化段定义格式（.model small, .stack, .data, .code）
2. 程序包含输入功能：从键盘读取两个字符串
3. 程序包含字符串连接功能：将第二个字符串连接到第一个字符串后面
4. 程序包含输出功能：显示连接后的字符串
5. 使用子程序结构，包含字符串输入子程序、字符串连接子程序和字符串输出子程序
6. 处理字符串长度检测，避免缓冲区溢出
7. 添加必要的注释说明程序功能

**请在下方设计完整的汇编程序代码：**

```assembly
; 请在此处编写完整的汇编程序代码


```