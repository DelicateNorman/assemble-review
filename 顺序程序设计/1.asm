; 例 3.1：信息显示程序 - 最基础的顺序结构示例
; 功能：使用 DOS 21H 中断的 09H 功能显示一个字符串
; 学习要点：顺序程序的执行流程、DOS功能调用、数据段初始化

.MODEL SMALL          ; 小型存储模型：代码段和数据段各64KB
.STACK 100H           ; 定义堆栈段大小为256字节

.DATA
; 定义要显示的字符串
; 0DH = 回车符(CR), 0AH = 换行符(LF), '$' = DOS字符串结束标志
STRING DB 'Hello, Everybody!', 0DH, 0AH, '$'

.CODE
.STARTUP ; 程序入口点，自动完成 DS/ES 初始化 (替代了手动初始化 DS)

    ; === 第二步：准备DOS功能调用的参数 ===
    ; DOS 09H功能要求：DX = 字符串的偏移地址
    MOV DX, OFFSET STRING ; OFFSET操作符获取字符串的偏移地址

    ; === 第三步：设置DOS功能号 ===
    ; AH = 09H 表示调用字符串显示功能
    MOV AH, 9             ; 将功能号09H加载到AH寄存器

    ; === 第四步：执行DOS中断调用 ===
    ; INT 21H 触发DOS系统中断，根据AH中的功能号执行相应操作
    INT 21H               ; 显示DS:DX指向的字符串，直到遇到'$'字符

    ; === 第五步：程序正常退出 ===
    ; .EXIT 0 自动生成 MOV AH, 4CH / INT 21H 代码
.EXIT 0

END ; 整个程序结束