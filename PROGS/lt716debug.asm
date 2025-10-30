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
$$SYMBOLS	SEGMENT BYTE USE32 'DEBSYM'
$$SYMBOLS	ENDS
$$TYPES	SEGMENT BYTE USE32 'DEBTYP'
$$TYPES	ENDS
_TLS	SEGMENT DWORD USE32 PUBLIC 'TLS'
_TLS	ENDS
;	COMDAT ??_C@_0BJ@INMF@?$LD?L?P?r?V?$LE?P?P?$LF?D?J?$LB?V?S?V?$NM?F?Z?J?$PN?$KD?$LK?5?5?$AA@
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
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
;	COMDAT _findArray
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	?endl@@YAAAVostream@@AAV1@@Z			; endl
PUBLIC	_findArray
PUBLIC	_main
PUBLIC	??_C@_0BJ@INMF@?$LD?L?P?r?V?$LE?P?P?$LF?D?J?$LB?V?S?V?$NM?F?Z?J?$PN?$KD?$LK?5?5?$AA@ ; `string'
PUBLIC	??6ostream@@QAEAAV0@P6AAAV0@AAV0@@Z@Z		; ostream::operator<<
EXTRN	??6ostream@@QAEAAV0@H@Z:NEAR			; ostream::operator<<
EXTRN	?cout@@3Vostream_withassign@@A:BYTE		; cout
EXTRN	__chkstk:NEAR
EXTRN	__chkesp:NEAR
EXTRN	??6ostream@@QAEAAV0@PBD@Z:NEAR			; ostream::operator<<
;	COMDAT ??_C@_0BJ@INMF@?$LD?L?P?r?V?$LE?P?P?$LF?D?J?$LB?V?S?V?$NM?F?Z?J?$PN?$KD?$LK?5?5?$AA@
; File D:\TEMP\lt716.cpp
CONST	SEGMENT
??_C@_0BJ@INMF@?$LD?L?P?r?V?$LE?P?P?$LF?D?J?$LB?V?S?V?$NM?F?Z?J?$PN?$KD?$LK?5?5?$AA@ DB 0b3H
	DB	0ccH, 0d0H, 0f2H, 0d6H, 0b4H, 0d0H, 0d0H, 0b5H, 0c4H, 0caH, 0b1H
	DB	0d6H, 0d3H, 0d6H, 0dcH, 0c6H, 0daH, 0caH, 0fdH, 0a3H, 0baH, ' '
	DB	' ', 00H					; `string'
CONST	ENDS
;	COMDAT _main
_TEXT	SEGMENT
_SIZE$ = -4
_array$ = -40004
_temp1$ = -40008
_temp2$ = -40012
_i$ = -40016
_main	PROC NEAR					; COMDAT

; 5    : {

	push	ebp
	mov	ebp, esp
	mov	eax, 40080				; 00009c90H
	call	__chkstk
	push	ebx
	push	esi
	push	edi
	lea	edi, DWORD PTR [ebp-40080]
	mov	ecx, 10020				; 00002724H
	mov	eax, -858993460				; ccccccccH
	rep stosd

; 6    : 	const long SIZE=10000;

	mov	DWORD PTR _SIZE$[ebp], 10000		; 00002710H

; 7    : 	long array[SIZE];
; 8    : 	int temp1,temp2;
; 9    : 	for( int i=0; i<=SIZE; i++) array[i]=0;

	mov	DWORD PTR _i$[ebp], 0
	jmp	SHORT $L1298
$L1299:
	mov	eax, DWORD PTR _i$[ebp]
	add	eax, 1
	mov	DWORD PTR _i$[ebp], eax
$L1298:
	cmp	DWORD PTR _i$[ebp], 10000		; 00002710H
	jg	SHORT $L1300
	mov	ecx, DWORD PTR _i$[ebp]
	mov	DWORD PTR _array$[ebp+ecx*4], 0
	jmp	SHORT $L1299
$L1300:

; 10   : 	__asm 	{
; 11   : 			rdtsc

	rdtsc

; 12   : 			mov temp1,eax

	mov	DWORD PTR _temp1$[ebp], eax

; 13   : 			mov temp2,edx 	}

	mov	DWORD PTR _temp2$[ebp], edx

; 14   : 	findArray(100,array,SIZE);

	push	10000					; 00002710H
	lea	edx, DWORD PTR _array$[ebp]
	push	edx
	push	100					; 00000064H
	call	_findArray
	add	esp, 12					; 0000000cH

; 15   : 	__asm 	{
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

	push	OFFSET FLAT:?endl@@YAAAVostream@@AAV1@@Z ; endl
	mov	eax, DWORD PTR _temp2$[ebp]
	imul	eax, 34					; 00000022H
	mov	ecx, DWORD PTR _temp1$[ebp]
	add	ecx, eax
	push	ecx
	push	OFFSET FLAT:??_C@_0BJ@INMF@?$LD?L?P?r?V?$LE?P?P?$LF?D?J?$LB?V?S?V?$NM?F?Z?J?$PN?$KD?$LK?5?5?$AA@ ; `string'
	mov	ecx, OFFSET FLAT:?cout@@3Vostream_withassign@@A
	call	??6ostream@@QAEAAV0@PBD@Z		; ostream::operator<<
	mov	ecx, eax
	call	??6ostream@@QAEAAV0@H@Z			; ostream::operator<<
	mov	ecx, eax
	call	??6ostream@@QAEAAV0@P6AAAV0@AAV0@@Z@Z	; ostream::operator<<

; 22   : }

	pop	edi
	pop	esi
	pop	ebx
	add	esp, 40080				; 00009c90H
	cmp	ebp, esp
	call	__chkesp
	mov	esp, ebp
	pop	ebp
	ret	0
_main	ENDP
_TEXT	ENDS
;	COMDAT _findArray
_TEXT	SEGMENT
_searchVal$ = 8
_array$ = 12
_count$ = 16
_i$ = -4
_findArray PROC NEAR					; COMDAT

; 24   : {

	push	ebp
	mov	ebp, esp
	sub	esp, 68					; 00000044H
	push	ebx
	push	esi
	push	edi
	lea	edi, DWORD PTR [ebp-68]
	mov	ecx, 17					; 00000011H
	mov	eax, -858993460				; ccccccccH
	rep stosd

; 25   : 	for( int i=0; i<count; i++)

	mov	DWORD PTR _i$[ebp], 0
	jmp	SHORT $L1308
$L1309:
	mov	eax, DWORD PTR _i$[ebp]
	add	eax, 1
	mov	DWORD PTR _i$[ebp], eax
$L1308:
	mov	ecx, DWORD PTR _i$[ebp]
	cmp	ecx, DWORD PTR _count$[ebp]
	jge	SHORT $L1310

; 26   : 		if( searchVal==array[i] )

	mov	edx, DWORD PTR _i$[ebp]
	mov	eax, DWORD PTR _array$[ebp]
	mov	ecx, DWORD PTR _searchVal$[ebp]
	cmp	ecx, DWORD PTR [eax+edx*4]
	jne	SHORT $L1311

; 27   : 			return true;

	mov	al, 1
	jmp	SHORT $L1306
$L1311:

; 28   : 		return false;

	jmp	SHORT $L1309
$L1310:
	xor	al, al
$L1306:

; 29   : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_findArray ENDP
_TEXT	ENDS
;	COMDAT ??6ostream@@QAEAAV0@P6AAAV0@AAV0@@Z@Z
_TEXT	SEGMENT
__f$ = 8
_this$ = -4
??6ostream@@QAEAAV0@P6AAAV0@AAV0@@Z@Z PROC NEAR		; ostream::operator<<, COMDAT

; 112  : inline ostream& ostream::operator<<(ostream& (__cdecl * _f)(ostream&)) { (*_f)(*this); return *this; }

	push	ebp
	mov	ebp, esp
	sub	esp, 68					; 00000044H
	push	ebx
	push	esi
	push	edi
	push	ecx
	lea	edi, DWORD PTR [ebp-68]
	mov	ecx, 17					; 00000011H
	mov	eax, -858993460				; ccccccccH
	rep stosd
	pop	ecx
	mov	DWORD PTR _this$[ebp], ecx
	mov	esi, esp
	mov	eax, DWORD PTR _this$[ebp]
	push	eax
	call	DWORD PTR __f$[ebp]
	add	esp, 4
	cmp	esi, esp
	call	__chkesp
	mov	eax, DWORD PTR _this$[ebp]
	pop	edi
	pop	esi
	pop	ebx
	add	esp, 68					; 00000044H
	cmp	ebp, esp
	call	__chkesp
	mov	esp, ebp
	pop	ebp
	ret	4
??6ostream@@QAEAAV0@P6AAAV0@AAV0@@Z@Z ENDP		; ostream::operator<<
_TEXT	ENDS
PUBLIC	?flush@@YAAAVostream@@AAV1@@Z			; flush
PUBLIC	??6ostream@@QAEAAV0@D@Z				; ostream::operator<<
;	COMDAT ?endl@@YAAAVostream@@AAV1@@Z
_TEXT	SEGMENT
__outs$ = 8
?endl@@YAAAVostream@@AAV1@@Z PROC NEAR			; endl, COMDAT

; 144  : inline _CRTIMP ostream& __cdecl endl(ostream& _outs) { return _outs << '\n' << flush; }

	push	ebp
	mov	ebp, esp
	sub	esp, 64					; 00000040H
	push	ebx
	push	esi
	push	edi
	lea	edi, DWORD PTR [ebp-64]
	mov	ecx, 16					; 00000010H
	mov	eax, -858993460				; ccccccccH
	rep stosd
	push	OFFSET FLAT:?flush@@YAAAVostream@@AAV1@@Z ; flush
	push	10					; 0000000aH
	mov	ecx, DWORD PTR __outs$[ebp]
	call	??6ostream@@QAEAAV0@D@Z			; ostream::operator<<
	mov	ecx, eax
	call	??6ostream@@QAEAAV0@P6AAAV0@AAV0@@Z@Z	; ostream::operator<<
	pop	edi
	pop	esi
	pop	ebx
	add	esp, 64					; 00000040H
	cmp	ebp, esp
	call	__chkesp
	mov	esp, ebp
	pop	ebp
	ret	0
?endl@@YAAAVostream@@AAV1@@Z ENDP			; endl
_TEXT	ENDS
EXTRN	??6ostream@@QAEAAV0@E@Z:NEAR			; ostream::operator<<
;	COMDAT ??6ostream@@QAEAAV0@D@Z
_TEXT	SEGMENT
__c$ = 8
_this$ = -4
??6ostream@@QAEAAV0@D@Z PROC NEAR			; ostream::operator<<, COMDAT

; 115  : inline  ostream& ostream::operator<<(char _c) { return operator<<((unsigned char) _c); }

	push	ebp
	mov	ebp, esp
	sub	esp, 68					; 00000044H
	push	ebx
	push	esi
	push	edi
	push	ecx
	lea	edi, DWORD PTR [ebp-68]
	mov	ecx, 17					; 00000011H
	mov	eax, -858993460				; ccccccccH
	rep stosd
	pop	ecx
	mov	DWORD PTR _this$[ebp], ecx
	mov	al, BYTE PTR __c$[ebp]
	push	eax
	mov	ecx, DWORD PTR _this$[ebp]
	call	??6ostream@@QAEAAV0@E@Z			; ostream::operator<<
	pop	edi
	pop	esi
	pop	ebx
	add	esp, 68					; 00000044H
	cmp	ebp, esp
	call	__chkesp
	mov	esp, ebp
	pop	ebp
	ret	4
??6ostream@@QAEAAV0@D@Z ENDP				; ostream::operator<<
_TEXT	ENDS
EXTRN	?flush@ostream@@QAEAAV1@XZ:NEAR			; ostream::flush
;	COMDAT ?flush@@YAAAVostream@@AAV1@@Z
_TEXT	SEGMENT
__outs$ = 8
?flush@@YAAAVostream@@AAV1@@Z PROC NEAR			; flush, COMDAT

; 143  : inline _CRTIMP ostream& __cdecl flush(ostream& _outs) { return _outs.flush(); }

	push	ebp
	mov	ebp, esp
	sub	esp, 64					; 00000040H
	push	ebx
	push	esi
	push	edi
	lea	edi, DWORD PTR [ebp-64]
	mov	ecx, 16					; 00000010H
	mov	eax, -858993460				; ccccccccH
	rep stosd
	mov	ecx, DWORD PTR __outs$[ebp]
	call	?flush@ostream@@QAEAAV1@XZ		; ostream::flush
	pop	edi
	pop	esi
	pop	ebx
	add	esp, 64					; 00000040H
	cmp	ebp, esp
	call	__chkesp
	mov	esp, ebp
	pop	ebp
	ret	0
?flush@@YAAAVostream@@AAV1@@Z ENDP			; flush
_TEXT	ENDS
END
