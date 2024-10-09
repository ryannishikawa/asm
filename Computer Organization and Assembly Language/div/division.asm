;	division.asm
;   unsigned long num1 = 50,000,000,000; 	    // use dq to declare 64-bit variable
;	unsigned int num2 = 3,333,333; 	            // use dd to declare 32-bit variable
;	unsigned int quotient = 0, remainder = 0; 	// use dd to declare 32-bit variable
;	quotient = num1 / num2;
;	remainder = num1 % num2;

section .data
SYS_exit		equ	60
EXIT_SUCCESS	equ	0
num1		    dq	50000000000
num2		    dd	3333333
quotient	    dd	0
remainder       dd  0


section .text
	global _start

_start: 
    mov edx, 0
	mov eax, dword[num1]
    mov edx, dword[num1+4]
	div dword[num2]

    mov dword[quotient], eax
    mov dword[remainder], edx

    mov rax, SYS_exit			;terminate excuting process
    mov rdi, EXIT_SUCCESS		;exit status
    syscall		