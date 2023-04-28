;Compilacion de subrutinas para entrada y salida estandar, arquitectura de 32 bits 
;creado  bge
;08/03/23
;subrutinas


SECTION	.data
	nula	db	0Ah,0h		;salto de linea,0hcaracternulo
	vacia	db	' ',0Ah, 0h	;cadena vacia
	escSeq 	db 	27,"[2J"	;escapesecuence para borrar pantalla
   	escLen 	equ 	4		;escapelength
    	prin 	db 	27		
    	goto    db 	27,"[00;00H"	;posiciona cursor a la izquierda
   	longi   equ 	8		;
   	posyx	db 	1Bh, '[01;01H', 0h	;posiciona cursor en primerfilaycolum
;------------------------------------------------------


;-------calculo de longitud de cadena------
; strLen(eax=cadena) -> eax in n=longitud

strLen:
	push ebx			;ebx en pila
	mov ebx, eax			;mueve la direccion de la cadena a ebx 

sigChar:
	cmp 	byte[eax],0 		;if msg[eax] == 0 
	jz 	finLen			;saltar al final 
	inc 	eax			; eax++
	jmp 	sigChar
finLen:
	sub 	eax, ebx
	pop 	ebx 	;saca valor de ebx 
	ret
; --------fin del codigo------

;-----impresion de pantalla------------
;void printStr (eax = cadena)

printStr:

	push 	edx
	push 	ecx
	push 	ebx 
	push 	eax 
	;llamada a calculo de longitud 
	; eax <- strLen(eax =cadena)
	call 	strLen

	mov 	edx, eax
    pop 	eax ; devuelve registro a 
    mov 	ecx, eax
    mov 	ebx, 1
    mov 	eax, 4
    int 	80h
    ;saca datos de la pila en orden inverson 
    pop 	ebx
    pop 	ecx 
    pop 	eax 
    ret 
;------fin impresion------------

;-----imprirmir cadenda con salto de linea------------
;void printStrLn(eax = cadena)
;imprime la cadena en pantalla seguida por la impresion de un salto de linea

printStrLn: 
    call	printStr
    push	eax
    mov		eax, 0Ah 
    push 	eax
    mov 	eax, esp        ;stackpointer
    call 	printStr
    pop 	eax 
    pop 	eax 
    ret
;---------------------

;--------imprimir entero----------------
printInt:
	push	eax
	push 	ecx
	push	edx
	push	esi
	mov	ecx, 0

divLoop:
	inc 	ecx			; Conteo de digitos
	mov 	edx, 0		; Limpiar parte alta del dividendo
	mov	esi, 10		; esi = 10  ; divisor
	idiv	esi			; Division entera entre edx y eax <edx:eax> / esi(10)
	add	edx, 48		; Sumarle 48
	push	edx
	cmp	eax, 0		; compara si es igual a 0
	jnz	divLoop

printLoop:
	dec 	ecx
	mov 	eax, esp
	call 	printStr
	pop	eax
	cmp	ecx, 0
	jnz 	printLoop
	pop	esi
	pop 	edx
	pop	ecx
	pop 	eax
	ret
;----------------

;----------imprimir entero con salto de linea------
printIntLn
	call 	printInt
	push	eax
	mov 	eax, 0Ah
	push 	eax
	call	printStr
	pop	eax
	pop	eax
	ret
;---------------------

;-----------min a mayus------------
strUpcase:
	push	ebx
	mov	ebx, eax
nextcharUp:
	cmp	byte [eax], 0
	je	finalUC
	cmp	byte [eax], 97
	jl	incUP
	cmp	byte [eax], 122
	jg	incUP
	sub	byte [eax], 32
incUP:
	inc	eax
	jmp	nextcharUp
finalUC:
	mov	eax, ebx
	pop	ebx
	ret
;--------------------
;------------mayus a min------------
strLocase:
	push	ebx
	mov	ebx, eax
nextcharLo:
	cmp	byte [eax], 0
	je	finalLC
	cmp	byte [eax], 65
	jl	incLC
	cmp	byte [eax], 90
	jg	incLC
	add	byte [eax], 32
incLC:
	inc	eax
	jmp	nextcharLo
finalLC:
	mov	eax, ebx
	pop	ebx
	ret
;-------------------------

;----------cadena a int---------
chartoint:
	push	eax
	push	ebx
	xor	eax, eax
compara:
	movzx	ecx, byte[edx]
	inc 	edx
	cmp 	ecx, 30h
	jb	fincomp
	cmp 	ecx, 39h
	ja	fincomp
	sub	ecx, 30h
	imul	eax, 10
	add	eax, ecx
	jmp	compara
fincomp:
	mov 	edx, eax
	pop 	ebx
	pop 	eax
	ret
;-------------

;--------gotxy de x a y :v ---------
gotoxy:
	push	eax
	push	ebx
	push	ecx
	push	edx
;----inicializa variables
	mov 	bh, ah
	mov 	bl, al
	mov 	esi, 10
	mov 	ecx, posyx
;-----coordenada y
	xor	eax, eax
	xor	edx, edx
	mov 	al, bh
	idiv	esi
	add	eax, 48
	add	edx, 48
	mov 	byte [ecx + 2], al  
	mov 	byte [ecx + 3], dl  
;----coordenada x
	xor	eax, eax
	xor	edx, edx
	mov 	al, bl
	idiv 	esi
	add	eax, 48
	add	edx, 48
	mov 	byte [ecx + 5], al 
	mov 	byte [ecx + 6], dl 
;--------------
	mov 	eax, posyx
	call	printStr
	pop 	eax
	pop 	ebx
	pop 	ecx
	pop 	edx
	ret
;-----------------------

;-------cls-----------------limpia la pantalla
cls:
   	mov 	eax,4
   	mov 	ebx,1
   	mov 	ecx, escSeq
   	mov 	edx, escLen
   	int 	80h
xy:;va a 0,0
	mov 	eax,4
   	mov 	ebx,1
   	mov 	ecx, goto
   	mov 	edx, longi
   	int 	80h
   	ret
;-------

;-------endrpogram----------
endP: 
	mov 	ebx, 0		;return 0
	mov	eax, 1		    ;llamar a SYS_EXIT (kernerl opcode 1)
	int	80h
;-----------
