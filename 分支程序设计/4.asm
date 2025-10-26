; 例4.4：地址表多分支程序
; 功能：根据用户输入 1~8 的数字，通过地址表 TABLE 实现多分支跳转。

.MODEL SMALL ; 内存模式：SMALL，程序使用一个代码段和一个数据段
.STACK 100H  ; 定义堆栈大小

.DATA
    ; 提示信息
    msg     DB 'Input number(1~8):',0DH,0AH,'$'
    
    ; 8个分支对应的显示信息
    msg1    DB 'Chapter 1 : This is Branch 1.',0DH,0AH,'$'
    msg2    DB 'Chapter 2 : This is Branch 2.',0DH,0AH,'$'
    msg3    DB 'Chapter 3 : This is Branch 3.',0DH,0AH,'$'
    msg4    DB 'Chapter 4 : This is Branch 4.',0DH,0AH,'$'
    msg5    DB 'Chapter 5 : This is Branch 5.',0DH,0AH,'$'
    msg6    DB 'Chapter 6 : This is Branch 6.',0DH,0AH,'$'
    msg7    DB 'Chapter 7 : This is Branch 7.',0DH,0AH,'$'
    msg8    DB 'Chapter 8 : This is Branch 8.',0DH,0AH,'$'
    
    ; 地址表：存储8个分支处理程序段的偏移地址 (DW = Define Word, 2字节)
    TABLE   DW disp1, disp2, disp3, disp4
            DW disp5, disp6, disp7, disp8
    
.CODE
; 程序入口点
MAIN PROC
    ; 初始化数据段寄存器 DS
    MOV AX, @DATA   ; 获取数据段的地址
    MOV DS, AX      ; 将地址加载到 DS
    
start1: 
    ; 1. 提示用户输入数字
    MOV DX, OFFSET msg     ; 设置提示信息地址
    MOV AH, 09H            ; DOS功能：显示字符串
    INT 21H
    
    ; 2. 等待键盘按键输入
    MOV AH, 01H            ; DOS功能：等待按键输入，结果存入AL
    INT 21H                ; AL = 输入的ASCII码 (例如 '3')
    
    ; 3. 判断输入是否在 1 到 8 之间
    CMP AL, '1'            ; 数字 < '1' (ASCII 49)？
    JB start1              ; 是，则重新提示输入 (Jmp Below)
    CMP AL, '8'            ; 数字 > '8' (ASCII 56)？
    JA start1              ; 是，则重新提示输入 (Jmp Above)
    
    ; 4. 将输入的ASCII码转换为地址表偏移量
    ; a) 转换为数值 (例如 '3' -> 3)
    SUB AL, '0'            ; 将ASCII码转换为数值 (等效于 AND AL, 0FH) 很重要！！！重点看
    MOV AH, 00H            ; 清除 AH，使得 AX 成为完整数值
    
    ; b) 调整基址 (例如 3 -> 2)
    DEC AX                 ; 数值减1，对应地址表零位移量 (输入1对应偏移0)
    
    ; c) 计算偏移量 (例如 2 -> 4)
    SHL AX, 1              ; 逻辑左移1位，实现 AX 乘以 2 (地址偏移量 = (输入值-1) * 2)
                           ; 因为地址在地址表中占2字节 (DW)
    MOV BX, AX             ; 将计算出的偏移量存入变址寄存器 BX
    
    ; 5. 间接寻址跳转
    JMP TABLE[BX]          ; 段内间接转移：IP <- [TABLE + BX]

; --- 分支处理程序段 ---
    
disp1: 
    MOV DX, OFFSET msg1    ; 设置待显示信息1的地址
    JMP start2             ; 跳转到公共出口
    
disp2: 
    MOV DX, OFFSET msg2    ; 设置待显示信息2的地址
    JMP start2             ; 跳转到公共出口
    
disp3: 
    MOV DX, OFFSET msg3    ; 设置待显示信息3的地址
    JMP start2             ; 跳转到公共出口

disp4: 
    MOV DX, OFFSET msg4    ; 设置待显示信息4的地址
    JMP start2             ; 跳转到公共出口

disp5: 
    MOV DX, OFFSET msg5    ; 设置待显示信息5的地址
    JMP start2             ; 跳转到公共出口

disp6: 
    MOV DX, OFFSET msg6    ; 设置待显示信息6的地址
    JMP start2             ; 跳转到公共出口

disp7: 
    MOV DX, OFFSET msg7    ; 设置待显示信息7的地址
    JMP start2             ; 跳转到公共出口

disp8: 
    MOV DX, OFFSET msg8    ; 设置待显示信息8的地址
    JMP start2             ; 跳转到公共出口

; --- 程序公共出口 ---

start2: 
    ; 显示分支程序设置好的信息（DX 已包含信息地址）
    MOV AH, 09H            ; DOS功能：显示字符串
    INT 21H
    
    ; 退出程序也可以写.exit 0
    MOV AH, 4CH            ; DOS功能：终止程序并返回DOS
    INT 21H

MAIN ENDP
END MAIN