;lt610.asm
.model small,c
.386P
public cpu_type, get_cpu_type
CPU_ID	MACRO
	DB 0FH,0A2H
	ENDM
.data
cpu_type db 0
intel_id db "GenuineIntel"
.code
get_cpu_type proc
get8086:	pushf
	pop ax
	and ax,0fffh
	push ax
	popf
	pushf
	pop ax
	and ax,0f000h
	cmp ax,0f000h
	jnz get286
	mov cpu_type,0
	ret
get286:	pushf
	pop ax
	or ax,0f000h
	push ax
	popf
	pushf
	pop ax
	and ax,0f000h
	jnz get386
	mov cpu_type,2
	ret
get386:	pushfd
	pop eax
	mov ecx,eax
	xor eax,40000h
	push eax
	popfd
	pushfd
	pop eax
	xor eax,ecx
	mov cpu_type,3
	jz end_type
	push ecx
	popfd
get486:	mov cpu_type,4
	mov eax,ecx
	xor eax,200000h
	push eax
	popfd
	pushfd
	pop eax
	xor eax,ecx
	jz end_type
get586:	mov eax,0
	CPU_ID
	cmp dword ptr intel_id,ebx
	jne end_type
	cmp dword ptr intel_id[+4],edx
	jne end_type
	cmp dword ptr intel_id[+8],ecx
	jne end_type
	cmp eax,1
	jl end_type
	mov eax,1
	CPU_ID
	and eax,0f00h
	mov cpu_type,ah
end_type:	ret
get_cpu_type endp
	end
