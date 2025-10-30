// lt716.cpp
# include <iostream.h>
bool findArray(int searchVal, int array[], int count);
void main (void)
{
	const int SIZE=10000;
	int array[SIZE];
	int temp1,temp2;
	for( int i=0; i<=SIZE; i++) array[i]=0;
	__asm 	{
			rdtsc
			mov temp1,eax
			mov temp2,edx 	}
	findArray(100,array,SIZE);
	__asm 	{
			rdtsc
			sub eax,temp1
			sbb edx,temp2
			mov temp1,eax
			mov temp2,edx 	}
	cout<<"程序执行的时钟周期数：  "<<temp1+temp2*(2^32)<<endl;
}
bool findArray(int searchVal, int array[], int count)
{
	for( int i=0;i<count;i++)
		if( searchVal==array[i])
			renturn true;
		return false;
}