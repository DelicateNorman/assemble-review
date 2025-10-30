; 示例：单分支结构——计算 AX 的绝对值
; 功能：如果 AX < 0，执行 NEG AX (求补)；如果 AX >= 0，跳过 NEG。

.MODEL SMALL
.STACK 100H

.DATA
    RESULT DW ? ; 存储最终的绝对值结果
    
.CODE
.startup 
    ; 假设 AX 中有一个初始值
    MOV AX, -1234H ; 示例：初始 AX = 负数 (例如 -4660)
    ; MOV AX, 5678H ; 示例：初始 AX = 正数 (例如 5678)
    
    ; --- 单分支结构开始 ---
    
    CMP AX, 0       ; 比较 AX 和 0。这会设置 SF, ZF 等标志位。
    
    ; JNS (Jump if Not Sign): 符号标志 SF=0 时转移 (即 AX >= 0)
    JNS nonneg      ; 分支条件：AX >= 0 (非负数则转移，跳过求补)
    
    ; 条件不满足 (AX < 0)，顺序执行分支体
    NEG AX          ; 条件满足：对 AX 求补，即 AX = -AX (取绝对值)
    
nonneg: 
    ; --- 分支结束后的公共汇合点 ---
    MOV RESULT, AX  ; 条件满足或求补后，将最终结果存入 RESULT

    .exit 0
END