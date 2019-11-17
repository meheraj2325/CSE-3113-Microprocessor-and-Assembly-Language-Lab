; Problem 2 - find the second maximum number along with its index from a given list (array) of numbers


segment .bss
	array resb 12
	total resb 4
	num resb 4
	input resb 1
	temp resb 1
	max resb 1	
	
segment .data
	msg1 db 'Enter number : ',0xA,0xD
	len1 equ $- msg1
	
	msg2 db 'Enter '
	len2 equ $- msg2
	
	msg3 db ' numbers : ',0xA,0xD
	len3 equ $- msg3
	
	msg4 db 'Output : ',0xA,0xD
	len4 equ $- msg4
	
	msg5 db 'Second Maximum : '
	len5 equ $- msg5

	msg6 db 'Index :'
	len6 equ $- msg6
	
	msg7 db 'No second max. All elements are equal.',0xA,0xD
	len7 equ $- msg7
	
	msg8 db 'First Maximum : '
	len8 equ $- msg8
	
	space db ' '
	splen equ $- space
	
	newline db '',0xA,0xD
	newlen equ $- newline
	
	ten db ' 10'
	lenten equ $- ten

	sec_max db '.'

	
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
			je  _find_sec_max
			
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
	
	_find_sec_max:
	
		mov eax, 4
		mov ebx, 1
		mov ecx, msg4
		mov edx, len4
		int 0x80
		
		mov esi, 0
		mov ah, [array+esi]
		mov [max], ah

		inc esi
	
		_loop2:
			cmp esi, dword[total]	
			je  _output_print
			
			mov ah, [array+esi]
			cmp ah, byte[max]
			jg _change_max
			
			mov ah, [array+esi]
			cmp ah, byte[max]
			je _after_change			
			
			mov ah, [array+esi]
			cmp ah, byte[sec_max]
			jg _change_sec_max
		
			_after_change:
			
				inc esi
				jmp _loop2
			
		_change_max:
			mov ah, [max]
			mov [sec_max],ah

			mov ah, [array+esi]
			mov [max], ah
			jmp _after_change
			
		 _change_sec_max:
		 	mov ah, [array+esi]
			mov [sec_max], ah
			jmp _after_change
			
		_output_print:
			
			mov eax, 4
			mov ebx, 1
			mov ecx, msg5
			mov edx, len5
			int 0x80
			
			mov ah, [sec_max]
			cmp ah, '.'
			je _no_sec_max
			
			mov eax, 4
			mov ebx, 1
			mov ecx, sec_max
			mov edx, 1
			int 0x80
			
			mov eax, 4
			mov ebx, 1
			mov ecx, newline
			mov edx, newlen
			int 0x80
			
			mov eax, 4
			mov ebx, 1
			mov ecx, msg6
			mov edx, len6
			int 0x80
			
			mov esi, 0
			
			_loop3:
				cmp esi, dword[total]	
				je  _end
				
				mov ah, [array+esi]
				cmp ah, byte[sec_max]
				je _index_print
			
				_after_print:
					inc esi
					jmp _loop3
				
			_index_print:
				cmp esi, 9
				je _print_ten
			
				mov [num], esi
				mov eax, [num]
				inc eax
				add eax, '0'
				mov [num],eax
				
				mov eax, 4
				mov ebx, 1
				mov ecx, space
				mov edx, splen
				int 0x80
				
				mov eax, 4
				mov ebx, 1
				mov ecx, num
				mov edx, 4
				int 0x80
				
				jmp _after_print
				
			_print_ten:
				mov eax, 4
				mov ebx, 1
				mov ecx, ten
				mov edx, lenten
				int 0x80
				
				jmp _after_print
			
			
			_no_sec_max:
				mov eax, 4
				mov ebx, 1
				mov ecx, msg7
				mov edx, len7
				int 0x80
				
				mov eax, 4
				mov ebx, 1
				mov ecx, msg8
				mov edx, len8
				int 0x80
				
				mov eax, 4
				mov ebx, 1
				mov ecx, max
				mov edx, 1
				int 0x80
				
				mov eax, 4
				mov ebx, 1
				mov ecx, newline
				mov edx, newlen
				int 0x80
				
		_end: 
			mov eax, 4
			mov ebx, 1
			mov ecx, newline
			mov edx, newlen
			int 0x80
			
			mov eax, 1
			int 0x80
			
		
