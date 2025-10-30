;lt714f.asm
    .386p
    .model flat,c
    PUBLIC power2
    .code
power2 PROC
     push ebp
     mov ebp,esp
     mov eax,[ebp+8]
     mov ecx,[ebp+12]
     shl eax,cl
     pop ebp
     ret
power2 ENDP
    end
