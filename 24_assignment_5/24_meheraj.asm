section .data                           
	userMsg db 'Before Sorting : ' 
	lenUserMsg equ $-userMsg

	userMsg2 db 'After Sorting : ' 
	lenUserMsg2 equ $-userMsg2 

	userMsg3 db 'Before Swapping : ' 
	lenUserMsg3 equ $-userMsg3

	userMsg4 db 'After Swapping : ' 
	lenUserMsg4 equ $-userMsg4 

	space db ' '                
	len equ $- space

	newline db '',0xA,0xD
	len2 equ $- newline

	array db 8,2,9,0,5,3,6,5,9,4

section .bss          
	num1 resb 1
	num2 resb 1

	temp1 resb 1
	temp2 resb 1
	
section .text          
   global _start

	
_start:               
	mov eax, 4
	mov ebx, 1
	mov ecx, userMsg
	mov edx, lenUserMsg
	int 80h

	call _print

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, len2
	int 80h

	call _bubble_sort

	mov eax, 4
	mov ebx, 1
	mov ecx, userMsg2
	mov edx, lenUserMsg2
	int 80h

	call _print

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, len2
	int 80h
    
    
_exit:
   mov eax, 1
   mov ebx, 0
   int 80h


_print:
	mov edi, 0
	
	_loop: 
	
		mov eax, [array+edi]
		add eax, '0'
		mov [num1], eax

		mov eax, 4
		mov ebx, 1
		mov ecx, num1
		mov edx, 1
		int 80h

		mov eax, 4
		mov ebx, 1
		mov ecx, space
		mov edx, len
		int 80h

		inc edi
		cmp edi, 10
		je _return

		jmp _loop
		
	_return:
		ret		


_bubble_sort:
	mov edi,0	

	_loop2:
		mov esi,0
		
		_loop3:
			
			mov ah, [array+esi]
			mov bh, [array+esi+1]
			cmp ah,bh
			jg _call_sp

			after_call:
				inc esi
				cmp esi,9
				je _call_loop2
					
				jmp _loop3

			_call_sp:
				call _swap
				jmp after_call
				
			_call_loop2:
				inc edi
				cmp edi,9
				je _return2
				
				jmp _loop2
			
			_return2:
				ret

_swap:
	
	;mov eax, 4
	;mov ebx, 1
	;mov ecx, userMsg3
	;mov edx, lenUserMsg3
	;int 80h

	;mov eax, [array+esi]
	;add eax, '0'
	;mov [num1], eax

	;mov eax, 4
	;mov ebx, 1
	;mov ecx, num1
	;mov edx, 1
	;int 80h

	;mov eax, 4
	;mov ebx, 1
	;mov ecx, space
	;mov edx, len
	;int 80h

	;mov eax, [array+esi+1]
	;add eax, '0'
	;mov [num2], eax

	;mov eax, 4
	;mov ebx, 1
	;mov ecx, num2
	;mov edx, 1
	;int 80h

	;mov eax, 4
	;mov ebx, 1
	;mov ecx, newline
	;mov edx, len2
	;int 80h

	mov ah,[array+esi]
	mov bh,[array+esi+1]
	mov [array+esi+1],ah
	mov [array+esi],bh

	;mov eax, 4
	;mov ebx, 1
	;mov ecx, userMsg4
	;mov edx, lenUserMsg4
	;int 80h

	;mov eax, [array+esi]
	;add eax, '0'
	;mov [num1], eax

	;mov eax, 4
	;mov ebx, 1
	;mov ecx, num1
	;mov edx, 1
	;int 80h

	;mov eax, 4
	;mov ebx, 1
	;mov ecx, space
	;mov edx, len
	;int 80h

	;mov eax, [array+esi+1]
	;add eax, '0'
	;mov [num2], eax

	;mov eax, 4
	;mov ebx, 1
	;mov ecx, num2
	;mov edx, 1
	;int 80h

	;mov eax, 4
	;mov ebx, 1
	;mov ecx, newline
	;mov edx, len2
	;int 80h

	
	ret
