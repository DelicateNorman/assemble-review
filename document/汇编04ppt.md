# 汇编语言程序设计

# Assembly Language Programming

主讲人：鲁宏伟luhw@hust.edu.cn

# 第四章

# 基本汇编语言程序设计

# 教学重点

综合应用第2章硬指令和第3章伪指令，第4章从程序结构角度展开程序设计，重点掌握：

✓ 分支结构程序设计  
循环结构程序设计  
子程序结构程序设计

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/874a4e084ae9547664cec32f67ae931bfec97c5937441e0b81452abc9af00139.jpg)

顺序程序完全按指令书写的前后顺序执行每一条指令，是最基本、最常见的程序结构

分支程序根据条件是真或假决定执行与否  
判断的条件是各种指令，如CMP、TEST等执行后形成的状态标志  
转移指令Jcc和JMP可以实现分支控制；还可以采用MASM6.x提供的条件控制伪指令实现

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/9cfea3645979420d4798ec5e716db50f3df9b5fcf13c4c6751e91c0052f592ca.jpg)

单分支：求绝对值等

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/808ff934ae77533bf122fba948d2eef8666cac0a14ad820517bc513c168acaa8.jpg)

双分支：例 4.3

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/eb2069efcc724a5896fd105a46666d0ac986bc96620db4b7422c29ae19ad6c88.jpg)

多分支：例 4.4

等

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/da5865c17ebf1352d83767e74f89ffd53bf98b4205e79d5ef264c2a6193ac149.jpg)

条件成立跳转，否则顺序执行分支语句体；注意选择正确的条件转移指令和转移目标地址

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/fae643f8a86aec833fffab9e2536ae6c9b45d08e498c84fcd0ac54830b77c338.jpg)

# ; 计算 AX 的绝对值

例题 求绝对值

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/aa6b8ed438074fedd87ff040fd6814665a502de2728444942933f5f64761310a.jpg)

cmp ax,0 ; 注意 cmp 指令影响的符号位

jns nonneg ;分支条件：  $AX \geq 0$

neg ax ;条件不满足，求补

nonneg:

足

mov result,ax ;条件满

# ; 计算 AX 的绝对值

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/8299a1ee62e519599eec2a3fc1f5a05ec665f30b419ff3807bcff2d272a3d93a.jpg)

cmp ax,0

jlyesneg ;分支条件：AX<0

jmp nonneg

yesneg:

nonneg:

足

neg ax ;条件不满足，求补

mov result,ax ;条件满

# 例题 无符号数除以 2

; 将 AX 中存放的无符号数除以 2 , 如果是奇数,则加 1 后除以 2

test ax,01h ;测试 AX 最低位

;最低位为0：AX为偶数

add ax,1

;最低位为  $1: \mathrm{AX}$  为奇数, 需要加 1

even: rcr ax,1 ;AX←AX÷2

;如果采用SHR指令，则不能处理AX = FFFFH的特殊情况，因为 FFFFH+1=10000H，此时 CF=1

>条件成立跳转执行第2个分支语句体，否则顺序执行第1个分支语句体。注意第1个分支体后一定要有一个JMP指令跳到第2个分支体后

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/a9c5b7fe4b28933e4000d9c19818b034e84eea7fc96598b6af8ae43566618b8a.jpg)

# 例题 显示 BX 最高位

```csv
shl bx,1 ;BX最高位移入CFjc one ;CF  $=$  1，即最高位为1，转移mov dl,'0' ;CF  $=$  0，即最高位为0，DL $\leftarrow$  '0'jmp two ;一定要跳过另一个分支体one: mov dl,'1';DL $\leftarrow$  '1'two: mov ah,2int 21h ;显示
```

```txt
shl bx,1 ;BX最高位移入CF jnc one ;CF=0，即最高位为0，转移 mov dl,'1';CF = 1，即最高位为 1，DL←'1'
```

```txt
jmp two ;一定要跳过另一个分支体 one: mov dl,'0';DL←'0'
```

```txt
two: mov ah,2
```

```txt
int 21h ;显示
```

# 例题 显示 BX 最高位

mov dl,'0';DL←'0'

shl bx,1 ;BX最高位移入CF

jnc two ;CF = 0 , 最高位为 0 , 转移

mov dl,'1';CF = 1，最高位为1，DL←'1'

two: mov ah,2

int 21h ;显示

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/2292d742ad3c79139f0ddf21a2d086749f14e551add6cafccdf488337cb3aded.jpg)

双分支程序可以改为单分支程序

# 例题 单分支和双分支

;寄存器AL中是字母Y或y，则令AH=0；否则令AH=-1

cmpal,'Y';AL是大写Y否?

jz next ;是，转移

cmp al,'y';AL 是小写 y 否?

jz next ;是，转移

mov ah,-1 ;不是Y或y，则AH=-1，

结束

jmp done ;一定要跳过另一个分支体

next: mov ah,0 ;是Y或y，则AH = 0，结束

done: …

多个条件对应各自的分支语句体，哪个条件成立就转入相应分支体执行。多分支可以化解为双分支或单分支结构的组合，例如：

or ah,ah

jz function0

decah

jz function1

decah

jz function2

;等效于 cmp ah,0

;ah = 0 , 转向 function0

;等效于 cmp ah,1

;ah = 1, 转向 function1

;等效于 cmp ah,2

;ah = 2 , 转向 function2

需要在数据段事先安排一个按顺序排列的转移地址表  
$\succ$  输入的数字作为偏移量。  
关键是要理解间接寻址方式JMP指令

table dw disp1, disp2, disp3, disp4, ...  

<table><tr><td>地址表</td><td>分支1地址</td><td>分支2地址</td><td>...</td></tr></table>

# 例 4.4 数据段一  $1 / 3$

;数据段

msg db 'Input number(1~8):',0dh,0ah,'$'

msg1 db 'Chapter 1: ...,0dh,0ah,'$'

msg2 db 'Chapter 2: ...,0dh,0ah,'$

#

msg8 db 'Chapter 8: ... ',0dh,0ah,'$'

table dw disp1,disp2,disp3,disp4

dw disp5,disp6,disp7,disp8

;取得各个标号的偏移地址

此处等同于 offset disp1

# 例 4.4 代码段一  $2 / 3$

start1: mov dx,offset msg ;提示输入数字

mov ah,9

int 21h

movah,1 ;等待按键

int 21h

cmp al,'1' ;数字 < 1 ?

jb start1

cmp al,'8' ;数字 > 8 ?

ja start1

and ax,000fh ; 将 ASCII 码转换成数值

# 例 4.4 代码段一 3/3

dec ax

shl ax,1 ; 为什么需要  $a x<-a x+a x$ ?

mov bx,ax

jmp table[bx]

可以改为 call table[bx]

; (段内) 间接转移: IP←[table+bx]

start2: mov ah,9

int 21h

EXIT 0

disp1: mov dx,offset msg1 ;处理程序 1

jmp start2

对应修改为 ret

循环结构一般是根据某一条件判断为真或假来确定是否重复执行循环体  
循环指令和转移指令可以实现循环控制；还可以采用MASM 6.x提供的循环控制伪指令实现

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/6ac351edf5b4c0d3e69c3c165fface0e25d0c29166691ea5f3c852af7501be57.jpg)

循环指令 L00P：例 4.5

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/9e9e08b286f9d06da4a12fb2134e7a64927fc7746d4bac1ddf2ae1c0db874add.jpg)

循环指令 LOOPE：例

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/f6e9fff4360db516d7311a8f0c0e5030b8ca43adcf6fc7b06405353f81dfaf94.jpg)

转移指令：例 4.7

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/b366312dc472318699794a90fa3c0437818d99d720468e02e335d12f7cece900.jpg)

多重循环：例 4.8 等

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/d94619d2fbba561b714262c018a2dc4c727d2cd7bcb71ce0836efff08506c4d4.jpg)

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/4ebc5a0ff85640599baaae1389b342cebea37c83897bd9f7cbd40b456dbf1a6e.jpg)

;数据段

sum dw?

; 代码段

计数控制循

环

循环次数固定

xor ax,ax ;被加数 AX 清 0

mov cx,100

again: add ax,cx

;从  $100,99,\ldots ,2,1$  倒序累加

loop again

mov sum,ax ;累加和送入指定

单元

> 串操作指令是8086指令系统中比较独特的一类指令，采用比较特殊的数据串寻址方式，常用在操作主存连续区域的数据时

主要熟悉： MOVSTOSLODS

CMPS SCAS REP

一般了解：

REPZ/REPE REPNZ/REPNE

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/991de974ac6dca728930606dd6e582b8220d3f9e092ce6fd1fb1d81d099360da.jpg)

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/5aab68d6a2a249c475ca8b2b4c0e8ca594f272f20e42b5bfaa6715c961aa7645.jpg)

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/4741da36d19b974f083ecc6ea25458a9932237d936073634a5804ba11aea555d.jpg)

> 串操作指令的操作数是主存中连续存放的数据串（String）——即在连续的主存区域中，字节或字的序列

> 串操作指令的操作对象是以字 (W) 为单位的字串, 或是以字节 (B) 为单位的字节串

源操作数用寄存器 SI 寻址，默认在数据段 DS 中，即，DS:[SI]，但允许段超越  
目的操作数用寄存器 DI 寻址，默认在附加段 ES 中，ES:[DI]，不允许段超越  
每执行一次串操作指令，SI和DI将自动修改：

- ±1 （对于字节串）或 ±2 （对于字串）  
■执行指令CLD后，DF=0，地址指针+1或2  
■执行指令 STD 后，DF = 1，地址指针 -1 或 2

# 把字节或字操作数从主存的源地址传送至目的地址

# MOVSB

; 字节串传送: ES:[DI]  $\leftarrow$  DS:[SI]  
;  $\mathrm{SI} \leftarrow \mathrm{SI} \pm 1, \quad \mathrm{DI} \leftarrow \mathrm{DI} \pm 1$

# MOVSW

; 字串传送: ES:[DI]←DS:[SI]  
;  $\mathrm{SI} \leftarrow \mathrm{SI} \pm 2, \quad \mathrm{DI} \leftarrow \mathrm{DI} \pm 2$

# 把 AL 或 AX 数据传送至目的地址

# STOSB

; 字节串存储: ES:[DI]←AL

;  $\mathrm{DI} \leftarrow \mathrm{DI} \pm 1$

# STOSW

; 字串存储: ES:[DI]  $\leftarrow$  AX

;  $\mathrm{DI} \leftarrow \mathrm{DI} \pm 2$

# 把指定主存单元的数据传送给 AL 或 AX

# LODSB

; 字节串读取: AL←DS:[SI]  
;  $\mathrm{SI} \leftarrow \mathrm{SI} \pm 1$

# LODSW

; 字串读取: AX←DS:[SI]  
;  $\mathrm{SI} \leftarrow \mathrm{SI} \pm 2$

> 串操作指令执行一次，仅对数据串中的一个字节或字量进行操作。但是串操作指令前，都可以加一个重复前缀，实现串操作的重复执行。重复次数隐含在 CX 寄存器中  
重复前缀分 2 类, 3 条指令:

■配合不影响标志的MOVS、STOS（和LODS）指令的REP前缀  
■配合影响标志的CMPS和SCAS指令的REPZ和REPNZ前缀

REP ; 每执行一次串指令, CX 减  
1  
; 直到  $C X = 0$ , 重复执行结

> REP 前缀可以理解为：当数据串没有结束（CX≠0），则继续传送

mov ax,ds

mov es,ax ;设置附加段ES=DS

mov si,offset srcmsg

mov di,offset dstmsg

mov cx,lengthof srcmsg

cld ; 地址增量传送

rep movsb ; 传送字符串

movah,9 ; 显示字符串

mov dx,offset dstmsg

int 21h

again:

rep movsb

movsb

loop again

; 传送一个字节

; 重复传送

mov dx,cx

shr cx,1

rep movsw

mov cx,dx

and cx,01b

rep movsb

;字符串长度，转存 DX

; 长度除以 2

;以字为单位重复传送

;求出剩余的字符串长度

; 以字节为单位传送剩余字符

# 字符串传送

XORSI,SI ;SI指向首个字符

mov cx,lengthof srcmsg ;CX =

# 长度

again: mov al,srcmsg[si]; 取源字符串的字符

mov dstmsg[si],al; 传送到目的字符串

;指向下一个字符

leong again ，重复练习

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/5889dd6e9f53dce663290baba420e91a37cffc2bb509feaf62925ae6adaac24b.jpg)

不用串指令，需要使用循环结构

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/7ecbd83cc6158946148decd0cd15a22a4839ad628deb5ab472536160f76ab03f.jpg)

不用串指令，没有寄存器限制

# 4.4 子程序设计

把功能相对独立的程序段单独编写和调试，作为一个相对独立的模块供程序使用，就形成子程序  
子程序可以实现源程序的模块化，可简化源程序结构，可以提高编程效率

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/a9774733dff8fcecc82013b4d58657948ad7e103a1d27aa0a7ecc8b827654fbc.jpg)

子程序设计要利用过程定义伪指令

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/3153f4825ea4cf8805c6184eee5845969a25aba10788ecbc456bb1576752b07f.jpg)

参数传递是子程序设计的重点和难点

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/32b769ce27d9ee315b409fb9c513b0f3b2ac77a46c7f65e87c5a46e15f997b91.jpg)

子程序可以嵌套;

一定条件下，还可以递归和重入

过程名 proc [near|far]

#

过程名 endp

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/95087b5d83fac323536d96b9d7d2682621767e6c889d711ce2f267d8f78c2221.jpg)

过程名（子程序名）为符合语法的标识符

NEAR属性（段内近调用）的过程只能被相同代码段的其他程序调用  
■ FAR属性（段间远调用）的过程可以被相同或不同代码段的程序调用

对简化段定义格式，在微型、小型和紧凑存储模型下，过程的缺省属性为near；在中型、大型和巨型存储模型下，过程的缺省属性为far  
对完整段定义格式，过程的缺省属性为near  
用户可以在过程定义时用near或far改变缺省属性

subname proc ;具有缺省属性的 subname 过程

push ax ; 保护寄存器: 顺序压入堆栈

push bx ;ax/bx/cx 仅是示例

push cx

… ; 过程体

pop cx ; 恢复寄存器：逆序弹出堆栈

pop bx

pop ax

ret ; 过程返回

;过程结束

# 无参数传递的子程序

# ;子程序功能：实现光标回车换行

dpcrlf

proc

;过程开始

push ax

; 保护寄存器 AX 和 DX

push dx

mov dl,0dh

;显示回车

mov ah,2

int 21h

mov dl,0ah

;显示换行

mov ah,2

int 21h

pop dx

;恢复寄存器DX和AX

pop ax

ret

;子程序返回

dpcrlf

endp

; 过程结束

# 例 4.15 子程序 - 1/3

<table><tr><td>ALdisp</td><td>proc</td><td>;实现 al 内容的显示</td></tr><tr><td>DX</td><td>push ax</td><td>;过程中使用了 AX、CX 和</td></tr><tr><td></td><td>push cx</td><td></td></tr><tr><td></td><td>push dx</td><td></td></tr><tr><td></td><td>push ax</td><td>;暂存 ax</td></tr><tr><td></td><td>mov dl,al</td><td>;转换 al 的高 4 位</td></tr><tr><td></td><td>mov cl,4</td><td></td></tr><tr><td></td><td>shr dl,cl</td><td></td></tr><tr><td></td><td>or dl,30h</td><td>;al 高 4 位变成 3</td></tr><tr><td></td><td>cmp dl,39h</td><td></td></tr><tr><td></td><td>jbe aldisp1</td><td></td></tr><tr><td></td><td>add dl,7</td><td>;是 0Ah ~ 0Fh , 还要加上 7</td></tr><tr><td>aldisp1:</td><td>mov ah,2</td><td>;显示</td></tr><tr><td></td><td>int 21h</td><td></td></tr></table>

# 例 4.15 子程序 -2/3

pop dx

and dl,0fh

or dl,30h

cmp dl,39h

jbe aldisp2

add dl,7

aldisp2:

mov ah,2

int 21h

pop dx

popcx

pop ax

ret

ALdisp

endp

;恢复原ax值到dx  
;转换al的低4位

; 显示

;过程返回

# 例 4.15 主程序一 3/3

;主程序，同例4.8源程序 mov bx,offset array;调用程序段开始 mov cx,count

displp: mov al,[bx]

call ALdisp ;调用显示过程

mov dl,';显示一个逗号，分隔数据

mov ah,2

int 21h

inc bx

loop displp ;调用程序段结束

EXIT 0

… ;过程定义

end

# 具有多个出口的子程序

# HTOASC proc

;将 AL 低 4 位表达的一位 16 进制数转换为 ASCII 码

and al,0fh

cmpal,9

jbe htoasc1

addal,37h

ret

htoasc1: add al,30h

ret

HTOASC endp

;是  $0 \mathrm{AH} \sim 0 \mathrm{FH}$ , 加  $37 \mathrm{H}$

;子程序返回

;是  $0 \sim 9$ , 加  $30 \mathrm{H}$

;子程序返回

> 入口参数（输入参数）：主程序提供给子程序  
出口参数（输出参数）：子程序返回给主程序  
参数的形式:

(1) 数据本身 (传值)  
(2) 数据的地址 (传址)

传递的方法:

(1) 寄存器

(2) 变量

(3) 栈

子程序计算数组元素的“校验和”  
校验和是指不记进位的累加

入口参数：数组的逻辑地址（传址）

元素个数 (传值)

出口参数： 求和结果（传值）

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/c0dfc53b5d51bf7234a48079741bcfb487fd920ee0d5b2d11b17d460d15d3d23.jpg)

把参数存于约定的寄存器中，可以传值，也可以传址。  
子程序对带有出口参数的寄存器不能保护和恢复（主程序视具体情况进行保护）  
子程序对带有入口参数的寄存器可以保护，也可以不保护；但最好一致

# 例4.16a

入口参数：CX = 元素个数，

DS:BX =数组的段地址：偏移地址

出口参数：AL = 校验和

# 例 4.16a 主程序

# startup

;设置入口参数（含有DS←数组的段地址）

mov bx,offset array

;BX← 数组的偏移地址

mov CX, count ;CX← 数组的元素个数

call checksum; 调用求和过程

mov result,al ;处理出口参数

EXIT 0

# 例 4.16a 子程序

# checksuma

# proc

xor al,al

; 累加器清 0

# suma:

add al,[bx]

;求和

inc bx

;指向下一个字节

loopsuma

ret

# checksuma

end

endp

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/05cff1cab560ca70b820bb4dfcdf7ab2fbd042546ae25636a347a72c48c172a1.jpg)

主程序和子程序直接采用同一个变量名共享同一个变量，实现参数的传递  
> 不同模块间共享时，需要声明

例4.16b

入口参数:

count = 元素个数,

array = 数组名（段地址：偏移地址）

出口参数:

result = 校验和

# 例 4.16b - 1/2

;主程序

call checksum

;子程序

checksumb proc

push ax

push bx

push cx

xora1al; 累加器清0

mov bx,offset array

;BX← 数组的偏移地址

mov cx,count

;CX← 数组的元素个数

# 例 4.16b - 2/2

summ: add al, [bx] ; 求和

inc bx

loop-sumb

mov result,al ; 保存校验和

popcx

pop bx

pop ax

ret

checksumb endp

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/58c6733d0303fe15060a4c9c673ff35e740f3165df7e0c55e8ee9a527224902b.jpg)

主程序将子程序的入口参数压入堆栈，子程序从堆栈中取出参数  
子程序将出口参数压入堆栈，主程序弹出堆栈取得它们

例4.16c

入口参数:

顺序压入偏移地址和元素个数

出口参数:

AL = 校验和

startup

mov ax,offset array

push ax

mov ax,count

push ax

call checksumc

add sp,4

mov result,al

EXIT 0

例 4.16c 主程序

图示

要注意堆栈的分配情况，保证参数存取正确、子程序正确返回，并保持堆栈平衡

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/4db4e59d2d7e6f4a390e14f777b6a8fe9357f6cc4e3a2fac6e21ee9d4428bedc.jpg)

checksumc

proc

例 4.16c 子程序

push bp

mov bp,sp ;利用BP间接寻址存取参数

push bx

push cx

mov bx,[bp+6] ;SS:[BP+6] 指向偏移地址

mov cx,[bp+4] ;SS:[BP+4] 指向元素个数

sumc:

xor al,al

add al,[bx]

inc bx

loop sumc

popcx

pop bx

pop bp

ret

checksumc

endp

图示

子程序内包含有子程序

的调用就是子程序嵌套

没有什么特殊要求

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/e66fdbba25708b679c234ed1c300894c17fac94fd909487baa307bbb080f3d76.jpg)

# 例 4.15 嵌套子程序 - 1/3

# ALdisp

proc

push ax

push c x ;实现 al 内容的显示

push ax ;暂存 ax

mov cl,4

shr al,cl ;转换 al 的高 4 位

callhtoasc ;子程序调用（嵌套）

pop ax ;转换 al 的低 4 位

callhtoasc ;子程序调用（嵌套）

popcx

pop ax

ret

# ALdisp

endp

将 AL 低 4 位表达的一位 16 进制数转换为 ASCII 码

HTOASC proc

push ax  
push bx  
push dx  
mov bx,offset ASCII;BX指向ASCII码  
and al,0fh ;取得一位16进制数  
xlat ASCII

; 换码: AL←CS:[BX + AL], 注意数据在代码段 CS

mov dl,al ;显示

mov ah,2

int 21h

pop dx

pop bx

pop ax

ret ;子程序返回

;子程序的数据区

ASCII db 30h,31h,32h,33h,34h,35h,36h,37h

db 38h,39h,41h,42h,43h,44h,45h,46h

HTOASC endp

当子程序直接或间接地嵌套调用自身时称为递归调用，含有递归调用的子程序称为递归子程序  
递归子程序必须采用寄存器或堆栈传递参数，递归深度受堆栈空间的限制

例 4.17：求阶乘  $N! = \left\{ \begin{array}{ll} N \times (N - 1)! & N > 0 \\ 1 & N = 0 \end{array} \right.$

;数据段

例 4.17 主程序一 1/3

N dw 3

result dw?

; 代码段: 主程序

mov bx,N

图示

push bx ;入口参数：N

call fact ;调用递归子程序

pop result ;出口参数：N！

;计算 N! 的近过程

;入口参数: 压入 N ;出口参数: 弹出 N!

; 代码段: 子程序

fact proc

push ax

push bp

mov bp,sp

mov ax,[bp+6];取入口参数 N

cmp ax,0

jne fact1 ;N > 0, N! = N×(N-1)!

$\mathrm{inc} \quad \mathrm{ax}$ $\mathrm{;N} = 0, \mathrm{N}! = 1$

jmp fact2

fact1:

dec ax

;N-1

图示

push ax

call fact ;调用递归子程序求 (N-1)!

pop ax

fact2:

mul word ptr [bp+6] ;求 N×(N-1)!

mov [bp+6],ax ;存入出口参数 N!

pop bp

pop ax

ret

fact

endp

子程序从键盘输入一个有符号十进制数；子程序还包含将 ASCII 码转换为二进制数的过程  
输入时，负数用“-”引导，正数直接输入或用“+”引导  
子程序用寄存器传递出口参数，主程序调用该子程序输入 10 个数据

;数据段

例题 4.18 - 1/5

count = 10

array dw count dup(0);预留数据存储空间

; 代码段: 主程序

mov cx,count

mov bx,offset array

again: call read ;调用子程序输入一个数据

mov [bx],ax ;将出口参数存放缓冲区

inc bx

inc bx

call dpocrlf

;调用子程序，光标回车换行以便输入下一个数据

loop again

;输入有符号 10 进制数的通用子程序

;出口参数: AX =补码表示的二进制数值

;说明: 负数用 “- ” 引导, 正数用 “+” 引导或直接输入; 数据范围是 +32767 ~ -32768

read

proc

push bx

push cx

push dx

xor bx,bx ;BX 保存结果

Xor CX,CX

;CX 为正负标志，0 为正，-1 为负

movah,1 ;输入一个字符

int 21h

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/7ffcfdddd25ddfe997f63bb67ef2e3bd187df6926556ef55bc096c30d1be0054.jpg)

![](https://cdn-mineru.openxlab.org.cn/result/2025-10-27/21ed7b41-9750-4c35-842c-6ab081fc75ba/e545af73b31c1c855c2394445077e35a40bb66b015fdc5f716084d45b56d74e0.jpg)

read2

cmp al, $^{1+1}$

;是“+”，继续输入字符

jz read1

cmp al,\*

;是“一”，设置-1标志

jnz read2

;非“+”和“-”，转

转换算法

read1:

mov cx,-1

mov ah,1

;继续输入字符

int 21h

read2:

cmp al, $0'$

;不是  $0 \sim 9$  之间的字符, 则输入数据结束

jb read3

cmp al, $^\dagger$ 9

ja read3

sub al,30h

;是  $0 \sim 9$  之间的字符, 则转换为二进制数

;利用移位指令，实现数值乘  $10: BX \leftarrow BX \times 10$

shl bx,1

mov dx,bx

shl bx,1

shl bx,1

add bx,dx

：

mov ah,0

add bx,ax

;已输入数值乘 10 后，与新输入数值相加

jmp read1 ;继续输入字符

转换算法

read3: cmp cx,0

jz read4

neg bx ;是负数，进行求补

read4: mov ax,bx ;设置出口参数

pop dx

pop CX

pop bx

ret ;子程序返回

read endp

;使光标回车换行的子程序

dpcrlf proc

… ;省略

dpcrlf endp

# 第4章 教学要求

# 掌握基本程序结构

- 顺序结构  
分支结构  
循环结构  
- 子程序及其汇编语言程序设计

4.6, 4.14, 4.16, 4.21  
4.28, 4.29