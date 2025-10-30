	TITLE	D:\TEMP\lt716.cpp
	.386P
include listing.inc
if @Version gt 510
.model FLAT
else
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
_DATA	SEGMENT DWORD USE32 PUBLIC 'DATA'
_DATA	ENDS
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
_BSS	SEGMENT DWORD USE32 PUBLIC 'BSS'
_BSS	ENDS
_TLS	SEGMENT DWORD USE32 PUBLIC 'TLS'
_TLS	ENDS
;	COMDAT ??_C@_0BJ@INMF@?$LD?L?P?r?V?$LE?P?P?$LF?D?J?$LB?V?S?V?$NM?F?Z?J?$PN?$KD?$LK?5?5?$AA@
_DATA	SEGMENT DWORD USE32 PUBLIC 'DATA'
_DATA	ENDS
;	COMDAT ?lock@ios@@QAAXXZ
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT ?unlock@ios@@QAAXXZ
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT ?unlockbuf@ios@@QAAXXZ
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT ?gptr@streambuf@@IBEPADXZ
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT ?setf@ios@@QAEJJJ@Z
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT ?rdbuf@ios@@QBEPAVstreambuf@@XZ
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT ??4istream@@IAEAAV0@ABV0@@Z
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT ??6ostream@@QAEAAV0@P6AAAV0@AAV0@@Z@Z
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT ??6ostream@@QAEAAV0@D@Z
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT ?flush@@YAAAVostream@@AAV1@@Z
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT ?endl@@YAAAVostream@@AAV1@@Z
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT ??4iostream@@IAEAAV0@PAVstreambuf@@@Z
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _main
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT ?findArray@@YA_NHQAHH@Z
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	?flush@@YAAAVostream@@AAV1@@Z			; flush
PUBLIC	?findArray@@YA_NHQAHH@Z				; findArray
PUBLIC	_main
PUBLIC	??_C@_0BJ@INMF@?$LD?L?P?r?V?$LE?P?P?$LF?D?J?$LB?V?S?V?$NM?F?Z?J?$PN?$KD?$LK?5?5?$AA@ ; `string'
PUBLIC	??6ostream@@QAEAAV0@P6AAAV0@AAV0@@Z@Z		; ostream::operator<<
EXTRN	??6ostream@@QAEAAV0@H@Z:NEAR			; ostream::operator<<
EXTRN	?cout@@3Vostream_withassign@@A:BYTE		; cout
EXTRN	__chkstk:NEAR
EXTRN	??6ostream@@QAEAAV0@PBD@Z:NEAR			; ostream::operator<<
EXTRN	??6ostream@@QAEAAV0@E@Z:NEAR			; ostream::operator<<
;	COMDAT ??_C@_0BJ@INMF@?$LD?L?P?r?V?$LE?P?P?$LF?D?J?$LB?V?S?V?$NM?F?Z?J?$PN?$KD?$LK?5?5?$AA@
; File D:\Program Files\Microsoft Visual Studio\VC98\INCLUDE\ostream.h
_DATA	SEGMENT
??_C@_0BJ@INMF@?$LD?L?P?r?V?$LE?P?P?$LF?D?J?$LB?V?S?V?$NM?F?Z?J?$PN?$KD?$LK?5?5?$AA@ DB 0b3H
	DB	0ccH, 0d0H, 0f2H, 0d6H, 0b4H, 0d0H, 0d0H, 0b5H, 0c4H, 0caH, 0b1H
	DB	0d6H, 0d3H, 0d6H, 0dcH, 0c6H, 0daH, 0caH, 0fdH, 0a3H, 0baH, ' '
	DB	' ', 00H					; `string'
_DATA	ENDS
;	COMDAT _main
_TEXT	SEGMENT
_array$ = -40008
_temp1$ = -4
_temp2$ = -8
_main	PROC NEAR					; COMDAT

; 5    : {

	push	ebp
	mov	ebp, esp
	mov	eax, 40008				; 00009c48H
	call	__chkstk
	push	edi

; 6    : 	const int SIZE=10000;
; 7    : 	int array[SIZE];
; 8    : 	int temp1,temp2;
; 9    : 	for( int i=0; i<=SIZE; i++) array[i]=0;	//为数组赋值

	mov	ecx, 10001				; 00002711H
	xor	eax, eax
	lea	edi, DWORD PTR _array$[ebp]
	rep stosd

; 10   : 	__asm 	{	//保存当前的时钟周期数
; 11   : 			rdtsc

	rdtsc

; 12   : 			mov temp1,eax

	mov	DWORD PTR _temp1$[ebp], eax

; 13   : 			mov temp2,edx 	}

	mov	DWORD PTR _temp2$[ebp], edx

; 14   : 	findArray(100,array,SIZE);

	lea	eax, DWORD PTR _array$[ebp]
	push	10000					; 00002710H
	push	eax
	push	100					; 00000064H
	call	?findArray@@YA_NHQAHH@Z			; findArray
	add	esp, 12					; 0000000cH

; 15   : 	__asm 	{	//计算程序执行使用的时钟周期数
; 16   : 			rdtsc

	rdtsc

; 17   : 			sub eax,temp1

	sub	eax, DWORD PTR _temp1$[ebp]

; 18   : 			sbb edx,temp2

	sbb	edx, DWORD PTR _temp2$[ebp]

; 19   : 			mov temp1,eax

	mov	DWORD PTR _temp1$[ebp], eax

; 20   : 			mov temp2,edx 	}

	mov	DWORD PTR _temp2$[ebp], edx

; 21   : 	cout<<"程序执行的时钟周期数：  "<<temp1+temp2*(2^32)<<endl;

	mov	eax, DWORD PTR _temp2$[ebp]
	mov	edx, DWORD PTR _temp1$[ebp]
	mov	ecx, eax
	shl	ecx, 4
	add	ecx, eax
	lea	eax, DWORD PTR [edx+ecx*2]
	mov	ecx, OFFSET FLAT:?cout@@3Vostream_withassign@@A
	push	eax
	push	OFFSET FLAT:??_C@_0BJ@INMF@?$LD?L?P?r?V?$LE?P?P?$LF?D?J?$LB?V?S?V?$NM?F?Z?J?$PN?$KD?$LK?5?5?$AA@ ; `string'
	call	??6ostream@@QAEAAV0@PBD@Z		; ostream::operator<<
	mov	ecx, eax
	call	??6ostream@@QAEAAV0@H@Z			; ostream::operator<<
	push	OFFSET FLAT:?flush@@YAAAVostream@@AAV1@@Z ; flush
	push	10					; 0000000aH
	mov	ecx, eax
	call	??6ostream@@QAEAAV0@E@Z			; ostream::operator<<
	mov	ecx, eax
	call	??6ostream@@QAEAAV0@P6AAAV0@AAV0@@Z@Z	; ostream::operator<<
	pop	edi

; 22   : }

	mov	esp, ebp
	pop	ebp
	ret	0
_main	ENDP
_TEXT	ENDS
;	COMDAT ?findArray@@YA_NHQAHH@Z
_TEXT	SEGMENT
_searchVal$ = 8
_array$ = 12
_count$ = 16
?findArray@@YA_NHQAHH@Z PROC NEAR			; findArray, COMDAT

; 25   : 	for( int i=0; i<count; i++)

	mov	edx, DWORD PTR _count$[esp-4]
	xor	eax, eax
	push	esi
	test	edx, edx
	jle	SHORT $L1309
	mov	ecx, DWORD PTR _array$[esp]
	mov	esi, DWORD PTR _searchVal$[esp]
$L1307:

; 26   : 		if( searchVal==array[i] )

	cmp	esi, DWORD PTR [ecx]
	je	SHORT $L1351
	inc	eax
	add	ecx, 4
	cmp	eax, edx
	jl	SHORT $L1307
$L1309:

; 28   : 		return false;

	xor	al, al
	pop	esi

; 29   : }

	ret	0
$L1351:

; 27   : 			return true;

	mov	al, 1
	pop	esi

; 29   : }

	ret	0
?findArray@@YA_NHQAHH@Z ENDP				; findArray
_TEXT	ENDS
;	COMDAT ??6ostream@@QAEAAV0@P6AAAV0@AAV0@@Z@Z
_TEXT	SEGMENT
__f$ = 8
??6ostream@@QAEAAV0@P6AAAV0@AAV0@@Z@Z PROC NEAR		; ostream::operator<<, COMDAT

; 112  : inline ostream& ostream::operator<<(ostream& (__cdecl * _f)(ostream&)) { (*_f)(*this); return *this; }

	push	esi
	mov	esi, ecx
	push	esi
	call	DWORD PTR __f$[esp+4]
	add	esp, 4
	mov	eax, esi
	pop	esi
	ret	4
??6ostream@@QAEAAV0@P6AAAV0@AAV0@@Z@Z ENDP		; ostream::operator<<
_TEXT	ENDS
EXTRN	?flush@ostream@@QAEAAV1@XZ:NEAR			; ostream::flush
;	COMDAT ?flush@@YAAAVostream@@AAV1@@Z
_TEXT	SEGMENT
__outs$ = 8
?flush@@YAAAVostream@@AAV1@@Z PROC NEAR			; flush, COMDAT

; 143  : inline _CRTIMP ostream& __cdecl flush(ostream& _outs) { return _outs.flush(); }

	mov	ecx, DWORD PTR __outs$[esp-4]
	jmp	?flush@ostream@@QAEAAV1@XZ		; ostream::flush
?flush@@YAAAVostream@@AAV1@@Z ENDP			; flush
_TEXT	ENDS
END
