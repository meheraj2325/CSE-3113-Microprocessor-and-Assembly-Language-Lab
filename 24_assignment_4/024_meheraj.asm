segment .data
	startMsg db "Please enter your choice:",0xA,0xD
	strtMsgLen equ $- startMsg

	choiceMsg1 db "   1. Star",0xA,0xD
	chcMsgLen1 equ $- choiceMsg1

	choiceMsg2 db "   2. Digit",0xA,0xD
	chcMsgLen2 equ $- choiceMsg2

	choiceMsg3 db "   3. Star Star Combination",0xA,0xD
	chcMsgLen3 equ $- choiceMsg3

	invalidMsg db "Invalid choice.",0xA,0xD
	invalidMsgLen equ $- invalidMsg

	numberMsg db "Enter number :",0xA,0xD
	numMsgLen equ $- numberMsg

	star db "*"
	starLen equ $- star

	newLine db "",0xA,0xD
	len equ $- newLine

segment .bss
	choice resb 4
	digit resb 4
	inner resb 4
	outer resb 4

segment .text
	global _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, startMsg
	mov edx, strtMsgLen
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, choiceMsg1
	mov edx, chcMsgLen1
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, choiceMsg2
	mov edx, chcMsgLen2
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, choiceMsg3
	mov edx, chcMsgLen3
	int 0x80

	mov eax, 3
	mov ebx, 2
	mov ecx, choice
	mov edx, 4
	int 0x80

	cmp byte[choice], '0'
	je _showInvalidMsg

	cmp byte[choice], '3'
	jg _showInvalidMsg

	mov eax, 4
	mov ebx, 1
	mov ecx, numberMsg
	mov edx, numMsgLen
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

	cmp byte[choice], '1'
	je _call1

	cmp byte[choice], '2'
	je _call2

	cmp byte[choice], '3'
	je _call3

	_call1:
		call _printStarPattern
		jmp _exit

	_call2:
		call _printDigitPattern
		jmp _exit

	_call3:
		call _printStarStarCombinationPattern
		jmp _exit

	_showInvalidMsg:
		mov eax, 4
		mov ebx, 1
		mov ecx, invalidMsg
		mov edx, invalidMsgLen
		int 0x80

	_exit:
		mov eax, 1
		int 0x80

_printStarPattern:

	mov edx, 1
	mov [outer], edx

	_loop11:

		mov edx, 1
		mov [inner], edx

		_loop12:
			mov eax, 4
			mov ebx, 1
			mov ecx, star
			mov edx, starLen
			int 0x80

			mov ecx, [inner]
			cmp ecx, [outer]
			je _increment1
			mov ecx, [inner]
			inc ecx
			mov [inner], ecx

			jmp _loop12

	_increment1:
		mov ecx, [outer]
		inc ecx
		mov [outer], ecx

		mov eax, 4
		mov ebx, 1
		mov ecx, newLine
		mov edx, len
		int 0x80

		mov ecx, [outer]
		cmp ecx, [digit]
		jg _return1

		jmp _loop11
	
	_return1:
		ret

_printDigitPattern:

	mov edx, 1
	mov [outer], edx

	_loop21:

		mov edx, 1
		mov [inner], edx

		_loop22:
			mov ecx, [inner]
			add ecx, '0'
			mov [inner], ecx
			
			mov eax, 4
			mov ebx, 1
			mov ecx, inner
			mov edx, 4
			int 0x80

			mov ecx, [inner]
			sub ecx, '0'
			mov [inner], ecx

			mov ecx, [inner]
			cmp ecx, [outer]
			je _increment2
			mov ecx, [inner]
			inc ecx
			mov [inner], ecx

			jmp _loop22

	_increment2:
		mov ecx, [outer]
		inc ecx
		mov [outer], ecx

		mov eax, 4
		mov ebx, 1
		mov ecx, newLine
		mov edx, len
		int 0x80

		mov ecx, [outer]
		cmp ecx, [digit]
		jg _return2

		jmp _loop21
	
	_return2:
		ret


_printStarStarCombinationPattern:

	_loop31:

		mov edx, 1
		mov [inner], edx

		_loop32:
			mov eax, 4
			mov ebx, 1
			mov ecx, star
			mov edx, starLen
			int 0x80

			mov ecx, [inner]
			cmp ecx, [digit]
			je _decrement3
			mov ecx, [inner]
			inc ecx
			mov [inner], ecx

			jmp _loop32

	_decrement3:
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
		je _return3

		jmp _loop31

	_return3:
		ret

