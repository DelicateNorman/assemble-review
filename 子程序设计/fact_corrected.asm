.model small
.stack 200h
.data
    N dw 3
    result dw ?
    msg_result db 'Factorial result: $'
.code
.startup
    mov bx, N
    push bx
    call fact
    pop result

    ; 显示结果
    mov dx, offset msg_result
    mov ah, 9
    int 21h

    mov ax, result
    call display_number

.exit 0

; 递归计算阶乘的子程序
; 入口参数：堆栈中的N
; 出口参数：堆栈中的N!
fact proc
    push ax
    push bp
    mov bp, sp
    mov ax, [bp+6]     ; 取参数N

    cmp ax, 0
    jne fact1          ; N ≠ 0，递归
    inc ax             ; N = 0，返回1（0! = 1）
    jmp fact2

fact1:
    dec ax             ; ax = N-1
    push ax            ; 传入N-1
    call fact          ; 递归调用fact(N-1)
    pop ax             ; 取回fact(N-1)的结果
    mul word ptr [bp+6] ; ax = (N-1)! × N

fact2:
    mov [bp+6], ax     ; 将结果放回堆栈
    pop bp
    pop ax
    ret
fact endp

; 显示数字的子程序（简化版）
display_number proc
    push ax
    push bx
    push cx
    push dx

    mov cx, 0
    mov bx, 10

convert_loop:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz convert_loop

display_loop:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop display_loop

    pop dx
    pop cx
    pop bx
    pop ax
    ret
display_number endp

end