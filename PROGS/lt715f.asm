;lt715f.asm
.386p
.model flat,c
   .code
isum	  proc uses ecx esi, \
	count:dword,darray:PTR
    mov ecx,count
    xor edx,edx
    xor eax,eax
    jecxz sumexit
    mov esi,darray
    mov eax,[esi]
    dec ecx
    jecxz sumexit
sumlp:	add esi,4
    add eax,[esi]
    adc edx,0
    loop sumlp
sumexit:	ret
isum	  endp
end
