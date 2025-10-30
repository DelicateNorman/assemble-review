;lt301a.asm
stack	segment stack
	db 1024 dup(?)
stack	ends
data	segment
string	db 'Hello, Everybody !',0dh,0ah,'$'
data 	ends
code	segment 'code'
	assume cs:code,ds:data,ss:stack
start:	mov ax,data
	mov ds,ax 
	mov dx,offset string
	mov ah,9
	int 21h
	mov ax,4c00h
	int 21h
code	ends
	end start