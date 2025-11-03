; 例 3.15：基于图片中代码的汇编程序示例
; 功能：演示数据段定义和寄存器操作
; 根据图片中的代码结构编写

.MODEL SMALL
.STACK 100H

.DATA
.CODE
.STARTUP   ; 程序入口点
mydata SEGMENT   
        ORG 100H                    ; 起始地址设为100H
        varw    DW 1234H, 5678H
        varb    DB 3, 4             ; 定义字节变量
        ALIGN   4                   ; 4字节对齐
        vard    DD 12345678H        ; 定义双字变量
        EVEN                        ; 偶地址对齐
        buff    DB 10 DUP(?)        ; 定义10个字节的缓冲区
        mess    DB 'Hello'          ; 定义字符串
    mydata ENDS
begin:
    ; 基于图片中的MOV指令序列
    MOV AX, OFFSET mess         ; AX ← mess的偏移地址
    MOV AX, TYPE buff + TYPE mess + TYPE vard    ; AX ← 类型大小之和
    MOV AX, SIZEOF varw + SIZEOF buff + SIZEOF mess  ; AX ← 大小之和
    MOV AX, LENGTHOF varw + LENGTHOF vard       ; AX ← 长度之和
    MOV AX, LENGTHOF buff + SIZEOF varw         ; AX ← 长度和大小组合
    MOV AX, TYPE begin                          ; AX ← begin的类型
    MOV AX, OFFSET begin                        ; AX ← begin的偏移地址

    ; 程序功能演示：显示一些计算结果
    ; 这里可以添加更多的功能代码
    
    ; 示例：将计算结果存储到寄存器中进行验证
    MOV BX, AX                  ; 保存最后的计算结果
    
    ; 可以添加输出功能来显示结果
    ; 例如：调用DOS中断来显示字符串
    MOV AH, 09H                 ; DOS功能号：显示字符串
    MOV DX, OFFSET mess         ; DX指向要显示的字符串
    INT 21H                     ; 调用DOS中断

.EXIT 0     ; 退出程序

END         ; 汇编结束