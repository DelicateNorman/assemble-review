; 例 3：通过堆栈传递参数计算数组校验和 (CHECKSUMC)
; 功能：计算一个数组元素的校验和（不记进位的累加），使用堆栈传递参数。
; 入口参数 (堆栈)：数组偏移地址 (2 字节), 元素个数 (2 字节)。
; 出口参数 (寄存器)：AL (校验和)。

.MODEL SMALL
.STACK 100H ; 确保堆栈足够大

.DATA
    ARRAY   DB 10H, 20H, 30H, 40H, 0FH, 0AH ; 示例数组
    COUNT   DW ($-ARRAY)                     ; 元素个数 (6)
    RESULT  DB ?                             ; 存储校验和结果
    
.CODE
; --- 子程序定义：堆栈传参的关键在于 BP ---
CHECKSUMC PROC NEAR
    ; 1. 建立栈帧，保护调用者的 BP
    PUSH BP             ; 保存旧的 BP 值 (旧 BP 在 [BP])
    MOV BP, SP          ; BP 指向当前栈顶 (BP 指向旧 BP 的地址)
    
    ; 2. 保护过程体中将要修改的通用寄存器
    PUSH BX             ; BX, CX 用于循环和寻址
    PUSH CX

    ; 3. 访问并加载堆栈参数
    ; 堆栈布局 (从低地址到高地址)：
    ; [BP+0] = 旧 BP 值
    ; [BP+2] = 返回地址 (IP)
    ; [BP+4] = 元素个数 (COUNT)
    ; [BP+6] = 数组偏移地址 (OFFSET ARRAY)
    MOV BX, [BP+6]      ; BX ← 数组偏移地址 (作为基址)
    MOV CX, [BP+4]      ; CX ← 元素个数 (作为循环计数器)

    ; 4. 循环初始部分
    XOR AL, AL          ; 累加器 AL 清 0 (用于存放校验和)

SUMC:
    ; 5. 循环体：计算校验和
    ADD AL, [BX]        ; AL ← AL + [DS:BX] (不记进位累加，只关注 AL)
    INC BX              ; BX 指向下一个字节
    LOOP SUMC           ; CX 计数循环 (CX--, JNZ SUMC)

    ; 6. 恢复寄存器
    POP CX              ; 恢复 CX (POP 操作与 PUSH 逆序)
    POP BX
    
    ; 7. 恢复调用者的栈帧
    POP BP              ; 恢复旧的 BP 值 (BP 指针指向返回地址)
    
    RET                 ; 子程序返回 (IP 或 CS:IP 弹出，栈顶恢复到 CALL 之前的状态)
CHECKSUMC ENDP

; --- 主程序 ---
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; 1. 将参数压入堆栈 (从右向左压入)
    MOV AX, COUNT        ; AX ← 元素个数 (2 字节)
    PUSH AX              ; 压入参数 2
    
    MOV AX, OFFSET ARRAY ; AX ← 数组的偏移地址 (2 字节)
    PUSH AX              ; 压入参数 1
    
    ; 2. 调用子程序
    CALL CHECKSUMC       
    
    ; 3. 主程序清理堆栈
    ADD SP, 4            ; 恢复栈平衡：清理 2 个 word (2 * 2 = 4 字节) 的参数
    
    ; 4. 保存出口参数
    MOV RESULT, AL       ; 保存出口参数 AL (校验和)
    
    ; 退出程序
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN