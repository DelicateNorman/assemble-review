/* lt709.c */
extern int num;
extern void incnum(void); 
main()
{    int i;
for(i=0;i<10;i++)
  {	incnum();
	printf("%d",num);  }
}