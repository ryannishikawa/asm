; ex2_subtraction.asm
; unsigned char num1 = 20000, num2 = 30000;
; signed short dif = 0;
; dif = short(num1 - num2);

section .data
SYS_exit	equ	60
EXIT_SUCCESS	equ	0
num1		dw	20000			
num2		dw	30000			
dif		dd	0			

section .text
	global _start
_start:
        mov     dx, 0
        mov     ax, word[num1]			
        sub     ax, word[num2]			
	sbb	dx, 0				
        mov     word[dif+0], ax			
        mov     word[dif+2], dx			
						
        mov     rax, SYS_exit			;terminate excuting process
        mov     rdi, EXIT_SUCCESS		;exit status
        syscall					;calling system services