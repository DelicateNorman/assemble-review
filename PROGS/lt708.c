/* lt708.c */
int num=0;
extern void incnum(void); 
main()
{    int i;
for(i=0;i<10;i++)
  {	incnum();
	printf("%d",num);  }
}