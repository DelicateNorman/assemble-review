; 示例：双分支结构——显示 BX 最高位 (MSB)
; 功能：检查 BX 的最高位 (D15)，如果为 1 显示 '1'，否则显示 '0'。

.MODEL SMALL
.STACK 100H

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; 假设 BX 中有一个初始值
    MOV BX, 8000H  ; 示例：最高位为 1
    ; MOV BX, 1234H  ; 示例：最高位为 0
    
    ; --- 双分支结构开始 ---
    
    ; SHL BX, 1：将 BX 逻辑左移一位，最高位 (D15) 移入 CF 标志
    SHL BX, 1       ; BX 最高位移入 CF 标志位
    
    ; JC (Jump if Carry): CF=1 时转移
    JC one          ; CF = 1 (最高位为 1)，转移到 one 分支
    
    ; --- 分支体 1：最高位为 0 (顺序执行) ---
    MOV DL, '0'     ; CF = 0，即最高位为 0，设置待显示字符 DL = '0'
    JMP two         ; 无条件跳转到程序汇合点，跳过第二个分支体
    
one: 
    ; --- 分支体 2：最高位为 1 (转移执行) ---
    MOV DL, '1'     ; CF = 1，即最高位为 1，设置待显示字符 DL = '1'
    
two: 
    ; --- 分支结束后的公共汇合点 (显示结果) ---
    MOV AH, 2       ; DOS 功能 2H：显示 DL 中的字符
    INT 21H         ; 执行显示操作
    
    ; 退出程序也可以写.exit 0
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN