// C++程序：lt715.cpp 
#include <iostream.h>
extern "C" {long isum(int,int *);}
int imin(int,int *);
void main(void)
{
    const int SIZE=10;
    int array[SIZE];
    int temp;
	cout<<"请输入10个整数（-2147483648 ~ 2147483647之间）："<<endl;
    for(temp=0;temp<SIZE;temp++)
    cin>>array[temp];
   	cout<<endl;
    cout<<"整数数据之和为：\t"<<isum(SIZE,array)<<endl;
    cout<<"其中最小值为：\t"<<imin(SIZE,array)<<endl;
}
int imin(int itmp,int iarray[])
{
__asm {
	mov ecx,itmp
	jecxz minexit
	dec ecx
	mov esi,iarray
	mov eax,[esi]
	jecxz minexit
minlp:	add esi,4
	cmp eax,[esi]	;比较两个数据的大小
	jle nochange
	mov eax,[esi]	;取得较小值
nochange:	loop minlp
minexit: 
	}
}