;	multiplication.asm
;   unsigned int num1 = 300,000; 	; use dd to declare 32-bit variable
;	unsigned int num2 = 400,000; 	; use dd to declare 32-bit variable
;	unsigned long product = 0; 		; use dq to declare 64-bit variable
;	product = long(num1 * num2);

section .data
SYS_exit		equ	60
EXIT_SUCCESS	equ	0
num1			dd	300000			;num1 = 25 = 19h
num2			dd	400000			;num2 = 35 = 23h
mult			dq	0				;mult = 0000h

section .text
	global _start

_start: 
    mov edx, 0
	mov eax, dword[num1]
	mul dword[num2]

    mov dword[mult], eax
    mov dword[mult+4], edx

    mov rax, SYS_exit			;terminate excuting process
    mov rdi, EXIT_SUCCESS		;exit status
    syscall		