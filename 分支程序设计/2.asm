; 示例：单分支结构——无符号数除以 2 (奇数先加 1)
; 功能：奇数 AX = (AX + 1) / 2；偶数 AX = AX / 2。

.MODEL SMALL
.STACK 100H

.CODE
.startup
    
    ; 假设 AX 中有一个初始值
    MOV AX, 15 ; 示例：AX = 15 (奇数)
    ; MOV AX, 10 ; 示例：AX = 10 (偶数)
    ; MOV AX, 0FFFFH ; 示例：AX = 65535 (奇数，边界值)
    
    ; --- 单分支结构开始 ---
    
    TEST AX, 01H    ; 测试 AX 的最低位（判断奇偶性），结果不影响 CF
    
    JZ iseven         ; 最低位为 0 AX 为偶数，转移
    
    ; 条件不满足 (AX 为奇数)，顺序执行分支体
    ADD AX, 1       ; AX = AX + 1。
                    ; 如果 AX 原本是 FFFFH，执行后 AX=0000H 且 **CF=1 (产生了溢出/进位)**
    
iseven:    ; --- 分支结束后的公共汇合点 ---
    ; RCR AX, 1 (Rotate through Carry Right): 连同 CF 标志右移一位
    RCR AX, 1       ; AX 右移一位实现除以 2
                    ; **RCR 的关键作用是：**
                    ; 1. 将 AX 的最低位移入 CF (作为新 CF)
                    ; 2. **将原来的 CF (ADD 指令产生的进位) 移入 AX 的最高位 D15。**
                    ;    这确保了在 AX=FFFFH 发生溢出时，(FFFFH+1) / 2 = (10000H) / 2 = 8000H 的高位 '1' 被保留。

    
    .exit 0
END 