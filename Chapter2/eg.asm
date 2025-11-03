;4.28 大小写转换子程序
;题目要求
;编写一个子程序，根据入口参数AL为0、1、2，分别实现大写字母转换成小写字母、
;小写字母转换成大写字母或大小写字母互换。欲转换的字符串在string中，用0表示结束。
.MODEL SMALL
.STACK 100H
.DATA
    STRING DB 'HELLO,WORLD',0
.CODE
.STARTUP
    MOV AL,2 ;在这里填入0或者1或者2
    CALL Exchange
.EXIT 0

Exchange proc
  push bx
  push cx
  push dx
  mov bx, offset string
again:
  mov dl, [bx]
  cmp dl, 0
  jz done1
  cmp al, 1
  jz exlarge
  cmp dl, 41h
  jb done0
  cmp dl, 5Bh
  ja exlarge
  add dl, 20h
  jmp done0
exlarge:
  cmp al, 0
  jz done0
  cmp dl, 61h
  jb done0
  cmp dl, 7Bh
  ja done0
  sub dl,20h
done0:
  inc bx
  loop again
  done1:
  pop dx
  pop cx
  pop bx
  RET
Exchange endp
end