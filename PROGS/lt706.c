/* lt706.c */
extern int plus(int *);
main()
{    int n=100;
printf("Befor call: n=%d\n",n);
plus(&n); 
printf("After call: n=%d\n",n);
}