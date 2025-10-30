// C++程序：lt713.cpp 
#include <iostream.h>
int power2(int,int);
void main(void)
{
    cout<<"2的6次方乘5等于：\t";
    cout<<power2(5,6)<<endl;
}
int power2(int num,int power);
{
__asm
{
     mov eax,num
     mov ecx,power
     shl eax,cl
}
}
