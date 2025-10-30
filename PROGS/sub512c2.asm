;sub512c2.asm
    .model small
    .code
    public sorting
sorting    proc
    cmp cx,0
    je sortend
    cmp cx,1
    je sortend
    push ax
    push dx
    push si
    mov si,bx
    dec cx
outlp:	mov dx,cx
    mov bx,si
inlp:	mov al,[bx]
    cmp al,[bx+1]
    jna next
    xchg al,[bx+1]
    mov [bx],al
next:	inc bx
    dec dx
    jnz inlp
    loop outlp
    pop si
    pop dx
    pop ax
sortend:    ret
sorting endp
    end
