; 例 3.1：信息显示程序 - 最基础的顺序结构示例
; 功能：使用 DOS 21H 中断的 09H 功能显示一个字符串
; 学习要点：顺序程序的执行流程、DOS功能调用、数据段初始化

.MODEL SMALL         ; 小型存储模型：代码段和数据段各64KB
.STACK 100H          ; 定义堆栈段大小为256字节

.DATA
; 定义要显示的字符串
; 0DH = 回车符(CR), 0AH = 换行符(LF), '$' = DOS字符串结束标志
STRING DB 'Hello, Everybody!', 0DH, 0AH, '$'

.CODE
MAIN PROC
    ; === 第一步：初始化数据段寄存器 ===
    ; @DATA 是数据段的段地址，必须先加载到AX再传给DS
    MOV AX, @DATA     ; 将数据段地址加载到AX寄存器
    MOV DS, AX        ; 将AX中的地址传送到DS寄存器

    ; === 第二步：准备DOS功能调用的参数 ===
    ; DOS 09H功能要求：DX = 字符串的偏移地址
    MOV DX, OFFSET STRING  ; OFFSET操作符获取字符串的偏移地址

    ; === 第三步：设置DOS功能号 ===
    ; AH = 09H 表示调用字符串显示功能
    MOV AH, 9          ; 将功能号09H加载到AH寄存器

    ; === 第四步：执行DOS中断调用 ===
    ; INT 21H 触发DOS系统中断，根据AH中的功能号执行相应操作
    INT 21H            ; 显示DS:DX指向的字符串，直到遇到'$'字符

    ; === 第五步：程序正常退出 ===
    ; AH = 4CH 表示程序终止功能，AL = 返回码(0表示正常退出)
    MOV AH, 4CH        ; 设置程序终止功能号
    INT 21H            ; 执行程序终止，返回DOS操作系统

MAIN ENDP             ; 主程序过程结束
END MAIN              ; 整个程序结束，MAIN是入口点