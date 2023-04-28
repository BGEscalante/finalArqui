;concatenacion de cadenas recibidas
;by: bg3
;28.04.23

 %include 'stdio32.asm'

SECTION .data
	msg1	db	'escriba la cadena 1 a utilizar:',0h
	msg2	db	'escriba la cadena 2 a utilizar:',0h
	msg3	db	'cadena copiada: ', 0h
	
SECTION .bss
	cad1	resb 255			;resb reservabyte
	cad2	resb 255			;resb reservabyte

SECTION .text
	global _start

_start:
	mov	eax,msg1
	call	printStr

	mov	edx, 255	;numero de bytes a leer
	mov	ecx, cad1		;nombre de variable a leer
	mov	ebx,0		;leer desde STDIN file la entrada estandar del sistema
	mov	eax, 3		;llamada al SYS_READ (kernel opcode 3)
	
	int	80h

	mov	eax,msg2
	call	printStr

	 mov	edx, 255	;numero de bytes a leer
	mov	ecx, cad2		;nombre de variable a leer
	mov	ebx,0		;leer desde STDIN file la entrada estandar del sistema
	mov	eax, 3		;llamada al SYS_READ (kernel opcode 3)
	
	int	80h

	mov	eax,msg3
	call	printStr

	mov	eax, cad1
	call	printStr
	mov	eax, cad2
	call	printStr
	call	endP
