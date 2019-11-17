segment .data
	startMsg db "Please enter your digit:",0xA,0xD
	inLen equ $- startMsg

	star db "*"
	starLen equ $- star

	newLine db "",0xA,0xD
	len equ $- newLine	

segment .bss
	digit resb 4
	cnt resb 4

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

	mov ecx, [digit]
	mov ch, 0
	sub ecx, '0'
	mov [digit], ecx

	cmp byte[digit], 0
	je _exit

	_loop1:

		mov edx, 1
		mov [cnt], edx	
		
		_loop2:
			mov eax, 4
			mov ebx, 1
			mov ecx, star
			mov edx, starLen
			int 0x80
			
			mov ecx, [cnt]
			cmp ecx, [digit]
			je _decrement
			mov ecx, [cnt]
			inc ecx
			mov [cnt], ecx

			jmp _loop2 
		 
	_decrement:
		mov ecx, [digit]
		dec ecx
		mov [digit], ecx

		mov eax, 4
		mov ebx, 1
		mov ecx, newLine
		mov edx, len
		int 0x80
		
		mov ecx, [digit]
		cmp ecx, 0
		je	_exit 

		jmp _loop1
			
	_exit:
		mov eax, 1
		int 0x80
