/* lt711.c */
#include <math.h>
#define PI 3.1415926
extern void asub(void);
main()
{ asub();  }
void sincall(int angle)
{    double radian;
radian=PI*angle/180.0;
printf("%f\n",sin(radian));
}