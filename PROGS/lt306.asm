;lt306.asm
stackseg segment stack
    db 256 dup(?)
stackseg ends
data1	segment word public 'const'
const1	dw 100
data1	ends
data2	segment word public 'vars'
var1	dw ?
data2	ends
datagroup group data1,data2
codeseg 	segment para public 'code'
	assume cs:codeseg,ds:datagroup,ss:stackseg
start:	mov ax,datagroup
	mov ds,ax
	mov ax,const1	;ax=100
	mov var1,ax	;[var1]=100
	mov ax,offset var1
	mov ax,offset data2
	mov ax,offset data1
	assume ds:data2
	mov ax,data2
	mov ds,ax
	mov ax,var1
	mov ax,offset var1
	mov ax,4c00h
	int 21h
codeseg 	ends
	end start
