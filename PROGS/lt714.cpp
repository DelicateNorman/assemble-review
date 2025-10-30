// C++程序：lt714.cpp 
#include <iostream.h>
extern "C" {int power2(int num,int power);}
void main(void)
{
    cout<<"2的6次方乘5等于：\t";
    cout<<power2(5,6)<<endl;
}
