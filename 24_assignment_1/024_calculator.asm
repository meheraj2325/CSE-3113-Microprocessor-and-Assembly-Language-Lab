section	.data

	msg1 db "Please enter your choice : ", 0xA,0xD
	len1 equ $- msg1

	msg2 db "	1. Addition", 0xA,0xD
	len2 equ $- msg2

	msg3 db "	2. Subtraction", 0xA,0xD
	len3 equ $- msg3

	msg4 db "	3. Multiplication", 0xA,0xD
	len4 equ $- msg4

	msg5 db "	4. Division", 0xA,0xD
	len5 equ $- msg5

	msg6 db "Enter first digit : ", 0xA,0xD
	len6 equ $- msg6

	msg7 db "Enter second digit : ", 0xA,0xD
	len7 equ $- msg7

	msg8 db "The result is : ", 0xA,0xD
	len8 equ $- msg8

	msg9 db " ", 0xA, 0xD
	len9 equ $- msg9

	msg10 db "Quotient "
	len10 equ $- msg10
	
	msg11 db "Remainder "
	len11 equ $- msg11

segment .bss
	
	digit1   resb 2
	digit2   resb 2
	res      resb 1
	res2	 resb 1
	choice   resb 1



section	.text

	global _start   

_start:	 

	; printing - "Please enter your choice : "
	mov ecx, msg1
	mov edx, len1
	mov ebx, 1		
	mov eax, 4		
	int 0x80

	; printing - "	1. Addition" 
	mov ecx, msg2
	mov edx, len2
	mov ebx, 1	   
	mov eax, 4	    
	int 0x80	     

	; printing - "	2. Subtraction"
	mov ecx, msg3
	mov edx, len3
	mov ebx, 1	   
	mov eax, 4	    
	int 0x80	     
	
	; printing - "	3. Multiplication"
	mov ecx, msg4
	mov edx, len4
	mov ebx, 1	   
	mov eax, 4	    
	int 0x80	     

	; printing - "	4. Division"
	mov ecx, msg5
	mov edx, len5
	mov ebx, 1	   
	mov eax, 4	    
	int 0x80	     

	; takeing input from user and store into variable choice
	mov eax, 3
	mov ebx, 2
	mov ecx, choice
	mov edx, 2
	int 0x80

	; printing - "Enter first digit : "
	mov ecx, msg6
	mov edx, len6
	mov ebx, 1
	mov eax, 4
	int 0x80
	
	; takeing input for first digit from user and store into variable digit1
	mov eax, 3
	mov ebx, 2
	mov ecx, digit1
	mov edx, 2
	int 0x80

	; printing - "Enter second digit : "
	mov ecx, msg7
    	mov edx, len7	
	mov eax, 4
    	mov ebx, 1
    	int 0x80
	
	; takeing input for second digit from user and store into variable digit2
	mov eax, 3
	mov ebx, 2
	mov ecx, digit2
	mov edx, 2
	int 0x80

	cmp byte [choice],'1'
	je addition

	cmp byte [choice],'2'
	je subtraction

	cmp byte [choice],'3'
	je multiplication

	cmp byte [choice],'4'
	je division

	addition:

		mov eax, [digit1]
		sub eax, '0'    ; conversion from ascii to number

		mov ebx, [digit2]
		sub ebx, '0'	; conversion from ascii to number

		add eax,ebx     ;addition of eax and ebx
		add eax, '0'    ;addition of '0' to convert from decimal to ASCII
		mov [res], eax

		; printing - "The result is : "
		mov eax, 4
		mov ebx, 1
		mov ecx, msg8
		mov edx, len8
		int 0x80

		; prining the result of addition
		mov eax, 4
		mov ebx, 1
		mov ecx, res
		mov edx, 1
		int 0x80

		jmp jumpToExit


	subtraction:

		mov eax, [digit1]
		sub eax, '0'	; conversion from ascii to number

		mov ebx, [digit2]
		sub ebx, '0'	; conversion from ascii to number

		sub eax,ebx     ;subtraction of eax and ebx
		add eax, '0'    ;addition of '0' to convert from decimal to ASCII
		mov [res], eax

		; printing - "The result is : "		
		mov eax, 4
		mov ebx, 1
		mov ecx, msg8
		mov edx, len8
		int 0x80
		
		; prining the result of subtraction		
		mov eax, 4
		mov ebx, 1
		mov ecx, res
		mov edx, 1
		int 0x80

		jmp jumpToExit


	multiplication:

		mov al, [digit1]
		sub al, '0'		; conversion from ascii to number	

		mov bl, [digit2]
		sub bl, '0' 	; conversion from ascii to number
		
		mul bl 			; multiplication
		add al, '0' 	; addition of '0' to convert from decimal to ASCII
		mov [res], al

		; printing - "The result is : "			
		mov eax, 4
		mov ebx, 1
		mov ecx, msg8
		mov edx, len8
		int 0x80

		; prining the result of multiplication
		mov eax, 4
		mov ebx, 1
		mov ecx, res   
		mov edx, 1
		int 0x80

		jmp jumpToExit



	division:

		mov al, [digit1]
		sub al, '0'	; conversion from ascii to number	

		mov bl, [digit2]
		sub bl, '0' 	; conversion from ascii to number

		div bl    	;division
		add al, '0'     ; addition of '0' to convert from decimal to ASCII
		mov [res], al
		
		add ah, '0'     ; addition of '0' to convert from decimal to ASCII
		mov [res2], ah
		

		; printing - "The result is : "		
		mov eax, 4
		mov ebx, 1
		mov ecx, msg8  
		mov edx, len8
		int 0x80

		; printing - "Quotient "		
		mov eax, 4
		mov ebx, 1
		mov ecx, msg10     ;shows "The result is"
		mov edx, len10
		int 0x80
		
		; prining the result of division(Quotient)
		mov eax, 4
		mov ebx, 1
		mov ecx, res  
		mov edx, 1
		int 0x80

		;carriage return and line feed
		mov ecx, msg9
		mov edx, len9
		mov ebx, 1		
		mov eax, 4		
		int 0x80
		
		; printing - "Remainder "		
		mov eax, 4
		mov ebx, 1
		mov ecx, msg11     ;shows "The result is"
		mov edx, len11
		int 0x80

		; prining the result of division(Remainder)
		mov eax, 4
		mov ebx, 1
		mov ecx, res2
		mov edx, 1
		int 0x80


	jumpToExit:
		
		;carriage return and line feed
		mov ecx, msg9
		mov edx, len9
		mov ebx, 1		
		mov eax, 4		
		int 0x80
		
		mov eax, 1
		int 0x80



