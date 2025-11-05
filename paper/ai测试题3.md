# 汇编语言程序设计期末考试试题（三）

**考试时间：** 120分钟
**总分：** 100分

---

## 一、单选题（10道题，每题2分，共20分）

**请将正确答案的选项填入题号前的括号内。**

1. **( )** 8086CPU中，下列哪个标志位属于控制标志？
   A. CF
   B. ZF
   C. DF
   D. SF

2. **( )** 执行指令LEA SI, [BX+DI+4]后，SI寄存器的内容是：
   A. [BX+DI+4]单元的内容
   B. BX+DI+4的值
   C. [BX+DI+4]单元的地址
   D. BX+DI+4的物理地址

3. **( )** 在8086指令系统中，下列哪条指令会影响所有状态标志位？
   A. MOV
   B. ADD
   C. JMP
   D. PUSH

4. **( )** 串操作指令CMPSW执行后，如果DI和SI指向的字相等，则ZF标志位为：
   A. 0
   B. 1
   C. 不确定
   D. 保持原值

5. **( )** 在MASM中，DUP操作符的作用是：
   A. 复制变量
   B. 重复定义数据
   C. 定义指针
   D. 连接字符串

6. **( )** 下列哪条指令用于实现多分支转移的最有效方式？
   A. 多个JMP指令
   B. 跳转表+JMP间接寻址
   C. 多个条件转移指令
   D. 循环结构

7. **( )** 执行指令NEG AX后，如果AX=0000H，则标志位CF的状态是：
   A. 0
   B. 1
   C. 不变
   D. 取决于AX的原值

8. **( )** 在简化段定义格式中，.CODE伪指令后面可以跟的参数是：
   A. 段名
   B. 段长度
   C. 对齐方式
   D. 存储类型

9. **( )** 下列关于PE文件格式的说法中，正确的是：
   A. PE文件只能在Windows NT系统运行
   B. PE文件头包含DOS存根和PE签名
   C. PE文件不支持动态链接
   D. PE文件格式与ELF文件格式相同

10. **( )** 在反汇编分析中，识别函数边界的重要依据是：
    A. 变量定义
    B. CALL/RET指令对
    C. 数据引用
    D. 注释信息

---

## 二、填空题（10个，每空2分，共20分）

1. 8086CPU的标志寄存器FLAGS中，TF表示______标志，用于______。

2. 在逻辑地址FFFF:0000中，段地址为______H，偏移地址为______H。

3. 指令AND AX, 00FFH的作用是______AX的高8位，这称为______操作。

4. 在MASM中，TYPE操作符返回变量的______，SIZEOF操作符返回变量占用的______。

5. 执行指令DEC CX后，如果CX=0000H，则ZF=______，这表示______。

6. 子程序调用时，CALL指令会自动将______地址压入堆栈，RET指令会从堆栈弹出______地址。

7. 在ELF文件格式中，程序头表描述了______信息，节区头表描述了______信息。

8. DOS功能调用INT 21H的功能号为01H时，功能是从键盘______一个字符，功能号为02H时，功能是向显示器______一个字符。

9. 基于反汇编的程序分析中，数据流分析用于跟踪______的传播，控制流分析用于理解______结构。

10. 汇编语言中，立即数寻址的操作数直接包含在______中，寄存器寻址的操作数存放在______中。

---

## 三、指令正确与错误判断题（5条指令，每条2分，共10分）

**请判断下列指令是否正确，错误的指令请指出错误原因。**

1. `CMP [BX], [SI]`
   - 判断：______
   - 错误原因（如错误）：______

2. `SAR AX, 4`
   - 判断：______
   - 错误原因（如错误）：______

3. `MUL WORD PTR [BX]`
   - 判断：______
   - 错误原因（如错误）：______

4. `JGE FAR PTR label`
   - 判断：______
   - 错误原因（如错误）：______

5. `LEA AX, [1234H]`
   - 判断：______
   - 错误原因（如错误）：______

---

## 四、简答题（2题，每题8分，共16分）

1. **请简述8086CPU的标志寄存器FLAGS中各个标志位的分类和功能。**

2. **请简述PE文件和ELF文件格式的主要区别，以及在反汇编分析中的意义。**

---

## 五、程序阅读题（4段代码，每题5分，共20分）

**请补全下列代码片段中缺失的指令或操作数，并分析代码段的作用。**

### 1. 数据统计程序（5分）

```assembly
.model small
.stack 100h
.data
numbers db 10, 20, -5, 15, -8, 0
count   equ ($-numbers)
positive db ?
negative db ?
zero    db ?
.code
startup
    mov ax, @data
    mov ds, ax
    xor bx, bx         ; 正数计数器
    xor cx, cx         ; 负数计数器
    xor dx, dx         ; 零计数器
    mov si, offset numbers
    mov di, ______     ; 设置循环次数
check_loop:
    mov al, [si]
    cmp al, 0
    jz is_zero
    ______ al, 0       ; 判断正负
    js is_negative
    inc bx            ; 正数计数加1
    jmp next_num
is_zero:
    inc dx            ; 零计数加1
    jmp next_num
is_negative:
    inc cx            ; 负数计数加1
next_num:
    inc si
    dec di
    jnz check_loop
    mov positive, bl
    mov negative, cl
    mov ______, dl    ; 保存零的个数
    exit 0
end
```

**代码段作用：** ________________________________________________

### 2. 位操作程序（5分）

```assembly
.model small
.stack 100h
.data
value   db 0F5H        ; 11110101B
bit_num db 3
result  db ?
msg     db '第3位状态: $'
.code
startup
    mov ax, @data
    mov ds, ax
    mov al, ______     ; 取操作数
    mov cl, bit_num    ; 取位数
    ______ al, cl      ; 测试指定位
    jz bit_is_zero
    mov result, 1      ; 位为1
    jmp display
bit_is_zero:
    mov ______, 0      ; 位为0
display:
    mov dx, offset msg
    mov ah, 9
    int 21h
    mov dl, result
    add dl, '0'
    mov ah, 2
    int 21h
    exit 0
end
```

**代码段作用：** ________________________________________________

### 3. 字符转换程序（5分）

```assembly
.model small
.stack 100h
.data
string  db 'Assembly Language$'
length  equ $-string-1
buffer  db length dup(?)
.code
startup
    mov ax, @data
    mov ds, ax
    mov es, ax
    lea si, ______     ; 源字符串地址
    lea di, buffer     ; 目标缓冲区
    mov cx, length     ; 字符串长度
convert_loop:
    mov al, [si]
    cmp al, 'a'
    jb not_lower
    cmp al, 'z'
    ja not_lower
    ______ al, 20h     ; 转换为大写
not_lower:
    mov [di], al
    inc si
    inc di
    loop convert_loop
    mov byte ptr [di], '$'
    lea dx, ______     ; 显示转换结果
    mov ah, 9
    int 21h
    exit 0
end
```

**代码段作用：** ________________________________________________

### 4. 数组搜索程序（5分）

```assembly
.model small
.stack 100h
.data
array   dw 12, 34, 56, 78, 90
n       equ ($-array)/2
target  dw 56
index   db -1           ; 未找到标志
found   db '找到，索引: $'
not_found db '未找到$'
.code
startup
    mov ax, @data
    mov ds, ax
    mov ax, ______     ; 搜索目标
    xor cx, cx         ; 索引计数器
search_loop:
    cmp cx, n
    jae not_found_msg
    cmp ax, ______     ; 比较数组元素
    je found_target
    inc cx
    jmp search_loop
found_target:
    mov index, cl
    lea dx, found
    mov ah, 9
    int 21h
    mov dl, index
    add dl, '0'
    mov ______, 2      ; 显示索引
    int 21h
    jmp done
not_found_msg:
    lea dx, not_found
    mov ah, 9
    int 21h
done:
    exit 0
end
```

**代码段作用：** ________________________________________________

---

## 六、程序设计题（14分）

**请使用简化段格式设计一个16位汇编程序（不超过50行），要求如下：**

**题目：** 设计一个简单的计算器程序，能够进行两个8位无符号数的加法运算。要求用户输入两个数字（0-9），计算它们的和，如果和大于9则显示进位标志。

**具体要求：**
1. 使用简化段定义格式（.model small, .stack, .data, .code）
2. 程序提示用户输入第一个数字（0-9）
3. 程序提示用户输入第二个数字（0-9）
4. 计算两个数字的和
5. 显示计算结果和进位信息
6. 添加必要的注释说明程序功能
7. 代码总行数不超过50行

**请在下方设计完整的汇编程序代码：**

```assembly
; 请在此处编写完整的汇编程序代码（不超过50行）


```