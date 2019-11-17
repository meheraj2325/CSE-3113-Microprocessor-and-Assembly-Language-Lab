segment .data
	startMsg db "Please enter your digit:",0xA,0xD
	inLen equ $- startMsg

	outputMsg1 db " is not prime.",0xA,0XD
	outLen1 equ $- outputMsg1

	outputMsg2 db " is prime.",0xA,0XD
	outLen2 equ $- outputMsg2

segment .bss
	digit resb 4
	temp resb 4
	cnt   resb 4
	temp2 resb 4

segment .text 
	global _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, startMsg
	mov edx, inLen
	int 0x80

	mov eax, 3
	mov ebx, 2
	mov ecx, digit
	mov edx, 4
	int 0x80
	
	mov eax, [digit]
	mov ah, 0
	sub eax, '0'
	mov [digit], eax

	cmp byte[digit], 0
	je _notPrime

	mov eax, 0
	mov [cnt], eax

	mov ecx, 1
	mov [temp], ecx

	_loop:
		mov eax,0
   		mov edx,0
   		mov ebx,0		
		
		mov eax, [digit]
		mov ebx, [temp]
		
		div ebx
		cmp edx, 0
		je _increment		
		
		_again:
			mov ecx, [temp]
			mov [temp], ecx
			cmp ecx, [digit]
			je _check
		
		mov ecx, [temp]
		inc ecx
		mov [temp], ecx
		jmp _loop	

	_increment: 
		mov eax, [cnt]
		inc eax
		mov [cnt], eax
		jmp _again
	

	_check:
		cmp byte [cnt], 2
		je _prime
		jmp _notPrime

	_notPrime:
		mov eax, [digit]
		add eax, '0'
		mov [digit], eax
		
		mov eax, 4
		mov ebx, 1
		mov ecx, digit
		mov edx, 4
		int 0x80

		mov eax, 4
		mov ebx, 1
		mov ecx, outputMsg1
		mov edx, outLen1
		int 0x80

		jmp _exit 

	_prime:
		mov eax, [digit]
		add eax, '0'
		mov [digit], eax

		mov eax, 4
		mov ebx, 1
		mov ecx, digit
		mov edx, 4
		int 0x80

		mov eax, 4
		mov ebx, 1
		mov ecx, outputMsg2
		mov edx, outLen2
		int 0x80

		jmp _exit

	_exit:
		mov eax, 1
		int 0x80  
