;lt513.asm
	.model tiny
	.code
	.startup
	call speaker_on
	mov ah,1
	int 21h
	call speaker_off
	.exit 0

speaker_on proc
	push ax
	in al,61h
	or al,03h
	out 61h,al
	pop ax
	ret
speaker_on endp
speaker_off proc
	push ax
	in al,61h
	and al,0fch
	out 61h,al
	pop ax
	ret
speaker_off endp
	end
