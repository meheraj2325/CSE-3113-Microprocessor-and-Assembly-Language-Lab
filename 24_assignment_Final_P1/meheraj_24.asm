; Problem no 1 - find the number of occurrences (frequency)


segment .bss
	array resb 12
	total resb 4
	num resb 1
	input resb 1
	temp resb 1
	freq resb 4
	
	
segment .data
	msg1 db 'Enter number : ',0xA,0xD
	len1 equ $- msg1
	
	msg2 db 'Enter '
	len2 equ $- msg2
	
	msg3 db ' numbers : ',0xA,0xD
	len3 equ $- msg3
	
	msg4 db 'Enter n : ',0xA,0xD
	len4 equ $- msg4
	
	msg5 db 'Frequency : ',0xA,0xD
	len5 equ $- msg5
	
	space db ' '
	splen equ $- space
	
	newline db '',0xA,0xD
	newlen equ $- newline
	
	ten db '10'
	lenten equ $- ten

	
segment .text
	global _start
	
_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, len1
	int 0x80
	
	mov eax, 3
	mov ebx, 2
	mov ecx, total
	mov edx, 4
	int 0x80
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, len2
	int 0x80
	
	mov eax, 4
	mov ebx, 1
	mov ecx, total
	mov edx, 4
	int 0x80
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, len3
	int 0x80
	
	mov eax, [total]
	cmp eax, '10'
	jl _lessthan10
	
	mov eax, 10
	mov [total], eax
	mov esi, 0
	jmp _loop
	
	_lessthan10:
		mov eax, [total]
		mov ah,0
		sub eax, '0'
		mov [total],eax
		mov esi, 0
		
		_loop:
			cmp esi, dword[total]	
			je  _frequncyCount
			
			mov eax, 3
			mov ebx, 2
			mov ecx, num
			mov edx, 1
			int 0x80
			
			mov eax, 3
			mov ebx, 2
			mov ecx, temp
			mov edx, 1
			int 0x80
			
			mov ah, [num]
			mov [array+esi], ah
		
			inc esi
			jmp _loop
	
	_frequncyCount:
	
		mov eax, 4
		mov ebx, 1
		mov ecx, msg4
		mov edx, len4
		int 0x80
		
		mov eax, 3
		mov ebx, 2
		mov ecx, input
		mov edx, 1
		int 0x80
		
		mov esi, 0 
		mov edi, 0
	
		_loop2:
			cmp esi, dword[total]	
			je  _freq_print
			
			mov ah, [array+esi]
			cmp ah, byte[input]
			je _increment
		
			after_increment:
				inc esi
				jmp _loop2
			
		_increment:
			inc edi
			jmp after_increment
			
		_freq_print:
			cmp edi, 10
			je _freq_is_10
			
			add edi, '0'
			mov [freq], edi
			
			mov eax, 4
			mov ebx, 1
			mov ecx, msg5
			mov edx, len5
			int 0x80
			
			mov eax, 4
			mov ebx, 1
			mov ecx, freq
			mov edx, 4
			int 0x80
			
			jmp _end
			
		_freq_is_10:
			mov eax, 4
			mov ebx, 1
			mov ecx, msg5
			mov edx, len5
			int 0x80
			
			mov eax, 4
			mov ebx, 1
			mov ecx, ten
			mov edx, lenten
			int 0x80
			
			jmp _end
		
		_end: 
			mov eax, 4
			mov ebx, 1
			mov ecx, newline
			mov edx, newlen
			int 0x80
			
			mov eax, 1
			int 0x80
			
		
