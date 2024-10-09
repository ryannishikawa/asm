;unsigned short num1 = 50000;			//data type: 16 bits
;unsigned short num2 = 30000;			//data type: 16 bits
;unsigned short num3 = 60000;			//data type: 16 bits
;unsigned int sum = 0					//data type: 32 bits
;unsigned long product = 0;				//data type: 64 bits

;sum = int(num1 + num2);
;product = int(num3) * sum;

section .data
    num1      dw      50000				;unsigned short num1 = 50000
    num2      dw      30000				;unsigned short num2 = 30000
    num3      dw      60000				;unsigned short num3 = 60000
	sum       dd      0					;unsigned int sum = 0
	product   dq      0					;unsigned long product = 0

section .text
        global _start
_start:
;sum = int(num1+num2)
    mov     dx, 0
	mov		ax, word[num1]
	add		ax, word[num2]
	adc     dx, 0	
    mov     word[sum], ax
    mov     word[sum+2], dx
    
;product = int(num3) * sum
    mov     edx, 0
    movzx   eax, word[num3]
    mul     dword[sum]
    mov     dword[product], eax
    mov     dword[product+4], edx

	mov     rax, 60						;terminate excuting process
	mov     rdi, 0						;exit status
	syscall			