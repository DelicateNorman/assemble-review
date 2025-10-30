;sub512a.asm
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
    pop dx
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
;
convert macro
    local input21,input22
    local input24,input25
    cmp dl,0
    je input25
    cmp dl,'9'
    jbe input21
    sub dl,7
input21:and dl,0fh
    cmp dh,0
    je input24
    cmp dh,'9'
    jbe input22
    sub dh,7
input22:    shl dh,1
   shl dh,1
   shl dh,1
   shl dh,1
   or dl,dh
input24:    mov [bx],dl
   inc bx
   inc cx
input25:
    endm
 input	proc
    push ax
    push dx
    xor cx,cx
input01:	xor dx,dx
input02:	mov ah,1
    int 21h
input10:    cmp al,0dh
    je input30
    cmp al,' '
    je input20
    cmp al,','
    je input20
    cmp al,08h
    je input17
    cmp al,'0'
    jb input17
    cmp al,'f'
    ja input17
    cmp al,'a'
    jb input11
    sub al,20h
    jmp input12
input11:cmp al,'F'
    ja input17
    cmp al,'A'
    jae input12
    cmp al,'9'
    ja input17
input12:    cmp dl,0
    jne input13
    mov dl,al
    jmp input02
input13:cmp dh,0
    jne input17
    mov dh,dl
    mov dl,al
    jmp input02
input17:mov dl,7
    mov ah,2
    int 21h
    mov dl,'?'
    mov ah,2
    int 21h
    jmp input01
input20:convert
    jmp input01
input30:convert
    pop dx
    pop ax
    ret
input	 endp
