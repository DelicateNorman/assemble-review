/* lt702.c */
#include <stdio.h>
void uppers(char *dest,char *src)
{	asm mov si,src
	asm mov di,dest
	asm cld
loop:	asm lodsb
	asm cmp al,'a'
	asm jb copy
	asm cmp al,'z'
	asm ja copy
	asm sub al,20h
  copy:	asm stosb
	asm and al,al
	asm jnz loop
}
main()
{
char str[]="This Started Out As Lowercase!";
char chr[100];
uppers(chr,str);
printf("Origin string:\n%s\n",str);
printf("Uppercase String:\n%s\n",chr);
}
