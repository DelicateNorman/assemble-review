/* lt712.c */
#include <stdio.h>
extern void get_cpu_type(void);
extern char cpu_type;
main() {
get_cpu_type();
printf("%d\n",cpu_type);
printf("Your Personel Computer Has a");
switch(cpu_type){
	case 0: printf("n 8086/8088 Processor !\n");break;
	case 2: printf("n 80286 Processor !\n");break;
	case 3: printf("n 80386 Processor !\n");break;
	case 4: printf("n 80486 Processor !\n");break;
	case 5: printf(" Pentium Processor !\n");break;
	case 6: printf(" Pentium Pro Processor !\n");break;
	default: printf("n unknown Processor !\n"); }
}
