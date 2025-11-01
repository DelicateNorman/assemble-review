.model small
.stack 100h
.data
    array dw 1,2,3,4,5,6,7,8,9,10
    count equ 10
    minimal dw ?
    maximum dw ?
    ; DOS输出用字符串
    max_msg db 'Maximum value: $'
    min_msg db 0Dh,0Ah,'Minimum value: $'
.code
.startup
call solve_max
call solve_min
; 调用输出过程显示结果
call output_results
.exit 0
;===============================================
; 查找数组最大值过程
;===============================================
solve_max proc
    push bx
    push cx
    mov bx,offset array
    mov cx,count
    mov ax,[bx]          ; 取第一个元素作为初始最大值
again:
    cmp ax,[bx]
    ja no_process        ; 如果AX大于当前元素，不更新
    mov ax,[bx]          ; 否则更新为更大的值
no_process:
    inc bx
    inc bx
    loop again
    mov maximum,ax
    pop cx
    pop bx
    ret
solve_max endp

;===============================================
; 查找数组最小值过程
;===============================================
solve_min proc
    push bx
    push cx
    mov bx,offset array
    mov cx,count
    mov ax,[bx]          ; 取第一个元素作为初始最小值
again1:
    cmp ax,[bx]
    jbe no_process1      ; 如果AX小于等于当前元素，不更新
    mov ax,[bx]          ; 否则更新为更小的值
no_process1:
    inc bx
    inc bx
    loop again1
    mov minimal,ax
    pop cx
    pop bx
    ret
solve_min endp

;===============================================
; DOS功能调用输出结果过程
;===============================================
output_results proc
    push ax
    push dx

    ; 输出最大值信息
    mov ah,09h
    lea dx,max_msg
    int 21h

    ; 输出最大值（支持多位数）
    mov ax,maximum
    call output_number

    ; 输出最小值信息
    mov ah,09h
    lea dx,min_msg
    int 21h

    ; 输出最小值（支持多位数）
    mov ax,minimal
    call output_number

    pop dx
    pop ax
    ret
output_results endp

;===============================================
; 输出数字过程（支持多位数）
; 输入：AX = 要输出的数字
;===============================================
output_number proc
    push ax
    push bx
    push cx
    push dx

    mov cx, 0              ; 数字位数计数器
    mov bx, 10             ; 除数

divide_loop:
    xor dx, dx             ; 清除DX，用于16位除法
    div bx                 ; AX = AX / 10, DX = AX % 10
    add dl, '0'            ; 将余数转换为ASCII字符
    push dx                ; 保存字符到堆栈
    inc cx                 ; 位数加1
    test ax, ax            ; 检查商是否为0
    jnz divide_loop        ; 如果不为0，继续除

print_loop:
    pop dx                 ; 从堆栈取出字符（高位先出）
    mov ah, 02h            ; DOS功能：显示字符
    int 21h
    loop print_loop

    pop dx
    pop cx
    pop bx
    pop ax
    ret
output_number endp

end