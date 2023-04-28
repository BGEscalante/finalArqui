;operaciones ciclicas por linea de comandos
;by:bg3
;28.04.23

%include	'stdio32.asm'


	SECTION		.bss
	opcion:	resb	1
	n1:		resq 	1	;Reserva de un doble para las variables
    n2:		resq 	1
    respu:  resq 	1
    n11: 	resb 	1
    n21:	resb	1
    r1:		resb	1

SECTION		.text
;---------suma de floatsxd
	suma:
		call 	recuadro			;Crea el recuadro
		push 	ebp
		mov 	ebp, esp

		mov		ah, 9d		
		mov		al, 30d
		call	gotoxy				;Llama a gotoxy
		push 	numero1				;Le pasa la cadena a mostrar
	    
		mov		ah, 10d
		mov		al, 40d
		call	gotoxy
	    push 	n1
	    push 	fmt
	   

	    mov		ah, 11d
		mov		al, 30d
		call	gotoxy
		push 	numero2 			;
		mov		ah, 12d
		mov		al, 40d
		call	gotoxy
	    push 	n2
	    push 	fmt
	    
	    fld 	qword 	[n1]
	    fadd 	qword 	[n2] 		;suma los dos primeros números del vector
	    fstp 	qword 	[respu]

		mov		ah, 13d
		mov		al, 32d
		call	gotoxy

	    push 	dword 	[respu + 4]	;convierte el número a double
	    push 	dword 	[respu + 0]
	    push 	resul 				;Pasa el formato del resultado			
	    ;Llamar a print solo para que muestre la cadena
	    push 	nula1 				;Le pasa la cadena a mostrar
	    			
	    mov 	esp, ebp
	    pop 	ebp
	    call 	repeat
	    ret

;---resta-------------		
	resta:
		call 	recuadro
		push 	ebp
		mov 	ebp, esp

		mov		ah, 9d
		mov		al, 30d
		call	gotoxy
		push 	numero1
		mov		ah, 10d
		mov		al, 40d
		call	gotoxy
	    push 	n1
	    push 	fmt
	    
	
	    mov		ah, 11d
		mov		al, 30d
		call	gotoxy
		push 	numero2
	    
		mov		ah, 12d
		mov		al, 40d
		call	gotoxy
	    push 	n2
	    push 	fmt
	
	    fld 	qword 	[n1]
	    fsub 	qword 	[n2]
	    fstp 	qword 	[respu]

	    mov		ah, 13d
		mov		al, 32d
		call	gotoxy

	    push 	dword 	[respu + 4]
	    push 	dword 	[respu + 0]
	    push 	resul
	   
	;printf solo para que muestre cadena
	    push 	nula1 				;pasa la cadena a mostrar
	    mov 	esp, ebp
	    pop 	ebp
	    call 	repeat
	    ret

;----multi-------------
	multiplicacion:
		call 	recuadro
		push 	ebp
		mov 	ebp, esp
	
		mov		ah, 9d
		mov		al, 30d
		call	gotoxy
		push 	numero1
		mov		ah, 10d
		mov		al, 40d
		call	gotoxy
	    push 	n1
	    push 	fmt
	    
	
	    mov		ah, 11d
		mov		al, 30d
		call	gotoxy
		push 	numero2
	    
		mov		ah, 12d
		mov		al, 40d
		call	gotoxy
	    push 	n2
	    push 	fmt
	    

	    fld 	qword 	[n1]
	    fmul 	qword 	[n2]
	    fstp 	qword 	[respu]

	    mov		ah, 13d
		mov		al, 32d
		call	gotoxy

	    push 	dword 	[respu + 4]
	    push 	dword 	[respu + 0]
	    push 	resul
	
	    push 	nula1 				
	    mov 	esp, ebp
	    pop 	ebp
	    call 	repeat
	    ret

;----div---		
	divisionR:
		call 	recuadro
		push 	ebp
		mov 	ebp, esp

		mov		ah, 9d
		mov		al, 30d
		call	gotoxy
		push 	numero1
		mov		ah, 10d
		mov		al, 40d
		call	gotoxy
	    push 	n1
	    push 	fmt
	    

	    mov		ah, 11d
		mov		al, 30d
		call	gotoxy
		push 	numero2
		mov		ah, 12d
		mov		al, 40d
		call	gotoxy
	    push 	n2
	    push 	fmt
	   
	    fld 	qword 	[n1]
	    fdiv 	qword 	[n2]
	    fstp 	qword 	[respu]

	    mov		ah, 13d
		mov		al, 32d
		call	gotoxy

	    push 	dword 	[respu + 4]
	    push 	dword 	[respu + 0]
	    push 	resul
	   
	    ;printf
	    push 	nula1 				
	    ;printf
	    mov 	esp, ebp
	    pop 	ebp
	    call 	repeat
	    ret

	modulo:
		call 	cls
		call 	recuadro
		mov 	ah, 9d
		mov 	al, 30d
		call 	gotoxy
		mov 	eax, numero1
		call	printStr

		mov 	ah, 10d
		mov 	al, 39d
		call 	gotoxy
		mov		eax, 3		;Invoca el SYS_READ (Kernel opcode 3)
		mov		ebx, 0		;Escribe al archivo STDIN
		mov		ecx, n11
		mov		edx, 8
		int 	80H
		mov		ecx, n11
		mov		edx, n11
		call	chartoint
		mov		eax, edx
		push	eax

		mov 	ah, 11d
		mov 	al, 30d
		call 	gotoxy
		mov 	eax, numero2
		call	printStr

		mov 	ah, 12d
		mov 	al, 39d
		call 	gotoxy

		mov		eax, 3		;Invoca el SYS_READ (Kernel opcode 3)
		mov		ebx, 0		;Escribe al archivo STDIN
		mov		ecx, n21
		mov		edx, 8
		int 	80H
		mov		ecx, n21
		mov		edx, n21
		call	chartoint
		mov 	eax, edx
		mov 	ebx, eax
		mov 	ecx, 0000
		mov 	edx, 0000
		pop		eax
		idiv	ebx
		push 	edx
		mov 	ecx, edx
		push 	eax

		mov 	ah, 14d
		mov 	al, 30d
		call 	gotoxy
		mov 	eax, modul
		call 	printStr
		pop 	eax
		call 	printInt
		;pop 	edx
		mov 	ah, 15d
		mov 	al, 30d
		call 	gotoxy
		mov 	eax, resi
		call 	printStr
		pop 	edx
		mov 	eax, edx
		call 	printInt
		call	gotoxy
		call 	repeat
		ret	
