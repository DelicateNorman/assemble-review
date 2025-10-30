;lt606.asm
	.model small
	.386
	.stack
	.data
count	equ 10
darray	dd 20,4500h,3f40h,-1,7f000080h
	dd 81000000h,0fffffff1h,-45000011,12345678,87654321
	.code
	.startup
	mov esi,offset darray
	mov ecx,count
start1:	mov eax,[esi]
	call EAXdisp
	add esi,4
	dec ecx
	jz start2
	mov dl,','
	mov ah,2
	int 21h
	jmp start1
start2:	mov dl,0dh
	mov ah,2
	int 21h
	mov dl,0ah
	mov ah,2
	int 21h
	mov esi,offset darray
	mov ecx,count
	call sorting
	mov esi,offset darray
	mov ecx,count
start3:	mov eax,[esi]
	call EAXdisp
	add esi,4
	dec ecx
	jz start4
	mov dl,','
	mov ah,2
	int 21h
	jmp start3
start4:	.exit 0
sorting	proc
	push eax
	push edx
	dec ecx
outlp:	mov edx,0
inlp:	cmp edx,ecx
	jae short botm
	mov eax,[esi+edx*4+4]
	cmp [esi+edx*4],eax
	jge short nswap
	xchg [esi+edx*4],eax
	mov [esi+edx*4+4],eax
nswap:	inc edx
	jmp inlp
botm:	loop outlp
	pop edx
	pop eax
	ret
sorting	endp
EAXdisp	proc
	push ebx
	push edx
	test eax,eax
	jns eaxdisp1
	neg eax
	mov ebx,eax
	mov dl,'-'
	mov ah,2
	int 21h
	mov eax,ebx
eaxdisp1:	mov ebx,10
	push bx
eaxdisp2:	cmp eax,0
	jz eaxdisp3
	sub edx,edx
	div ebx
	add dl,30h
	push dx
	jmp eaxdisp2
eaxdisp3:	pop dx
	cmp dl,10
	je eaxdisp4
	mov ah,2
	int 21h
	jmp eaxdisp3
eaxdisp4:	pop edx
	pop ebx
	ret
EAXdisp	endp
	end
