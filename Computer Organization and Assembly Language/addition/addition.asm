; addition.asm
; unsigned char num1 = 50000, num2 = 40000;
; unsigned short sum = 0;
; sum = int(num1 + num2);

section .data
SYS_exit	equ	60
EXIT_SUCCESS	equ	0
num1		dw	50000			
num2		dw	40000			
sum		dw	0			

section .text
        global _start
_start:
	mov	dx, 0
        mov     ax, word[num1]	
        add     ax, word[num2]		
	adc	dx, 0
        			        	
        mov     word[sum+0], ax   			
        mov     word[sum+2], dx		

        mov     rax, SYS_exit			;terminate excuting process
        mov     rdi, EXIT_SUCCESS		;exit status
        syscall					;calling system services
