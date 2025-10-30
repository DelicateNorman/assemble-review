;sub512c1.asm
    .model small
    .code
    public aldisp
ALdisp proc
    push ax
    push dx
    push ax
    mov dl,al
    shr dl,1
    shr dl,1
    shr dl,1
    shr dl,1
    or dl,30h
    cmp dl,39h
    jbe aldisp1
    add dl,7
aldisp1:    mov ah,2
    int 21h
    pop ax
    mov dl,al
    and dl,0fh
    or dl,30h
    cmp dl,39h
    jbe aldisp2
    add dl,7
aldisp2:    mov ah,2
    int 21h
    pop dx
    pop ax
    ret
ALdisp	endp
    end
