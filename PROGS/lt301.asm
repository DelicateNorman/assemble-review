;lt301.asm
        .model small
        .stack
        .data
string  db 'Hello, Everybody !',0dh,0ah,'$'
        .code
        .startup
        mov dx,offset string
        mov ah,9
        int 21h
        .exit 0
        end