/* lt707.c */
#include <stdio.h>
extern int upper(char *dest,char *src);
main()  {
int strnumber;
char str[]="This Started Out As Lowercase!";
char chr[100];
strnumber=upper(chr,str);
printf("Origin string:\n%s\n",str);
printf("Uppercase String:\n%s\n",chr);
printf("String Length:  %d\n",strnumber);
}
