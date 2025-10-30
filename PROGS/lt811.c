/* lt811.c */
#include <stdio.h>
#include <stdlib.h>
extern int froot(double a,double b,double c,double *x1,double *x2);
void main()
{   char instr[256];
    double a,b,c;
    double x1,x2;
printf("Input the coefficients of quadratic:\n");
printf(" a = "); gets(instr);  a = atof(instr);
printf(" b = "); gets(instr);  b = atof(instr);
printf(" c = "); gets(instr);  c = atof(instr);
if (froot(a,b,c,&x1,&x2)==1)
    printf("Roots are %f and %f\n",x1,x2);
else
    printf("No real roots.\n");
}
