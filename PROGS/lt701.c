/* lt701.c */
int min(int var1,int var2)
{	asm mov ax,var1
	asm cmp ax,var2
	asm jle minexit
	asm mov ax,var2
minexit:	return(_AX);
}
main()
{ 
min(100,200);
}
