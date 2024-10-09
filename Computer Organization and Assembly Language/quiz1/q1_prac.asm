section .data
    num1      dd      30000				;num1 = 0xE1
    num2      dd      40000				;num2 = 0x7D
    num3      dd      33333				;num3 = 0x85
	product   dq      0					;product = 0x0000
	quotient  dd      0					;quotient = 0x00
	remainder dd      0					;remainder = 0x00

section .text
        global _start
_start:
    mov     ebx, 0
	mov		eax, dword[num1]				;al = num1 = 0xE1
	mul		dword[num2]					;ax = al*num2 = 0xE1*0x7D = 0x6DDD
	mov		dword[product], eax	
    mov     dword[product+4], ebx		;product = ax = 0x6DDD = 28125
	div		dword[num3]					;ah=ax%num3=0xD3, al=ax/num3=0x3E
	mov     dword[quotient], eax			;quotient = al = 0xD3 = 211
	mov     dword[remainder], edx			;remainder = ah = 0x3E = 62

	mov     rax, 60						;terminate excuting process
	mov     rdi, 0						;exit status
	syscall			