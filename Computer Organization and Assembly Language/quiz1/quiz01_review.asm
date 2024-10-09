;quiz01_9.asm
;unsigned char num1 = 225;			//data type: 8 bits
;unsigned char num2 = 125;				//data type: 8 bits
;unsigned char num3 = 133;				//data type: 8 bits
;unsigned short product = 0				//data type: 16 bits
;unsigned char quotient = 0;			//data type: 8 bits
;unsigned char remainder = 0;			//data type: 8 bits
;product = num1 * num2;
;quotient = product / num3;
;remainder = product % num3;

section .data
    num1      db      225				;num1 = 0xE1
    num2      db      125				;num2 = 0x7D
    num3      db      133				;num3 = 0x85
	product   dw      0					;product = 0x0000
	quotient  db      0					;quotient = 0x00
	remainder db      0					;remainder = 0x00

section .text
        global _start
_start:
	mov		al, byte[num1]				;al = num1 = 0xE1
	mul		byte[num2]					;ax = al*num2 = 0xE1*0x7D = 0x6DDD
	mov		word[product], ax			;product = ax = 0x6DDD = 28125
	div		byte[num3]					;ah=ax%num3=0xD3, al=ax/num3=0x3E
	mov     byte[quotient], al			;quotient = al = 0xD3 = 211
	mov     byte[remainder], ah			;remainder = ah = 0x3E = 62

	mov     rax, 60						;terminate excuting process
	mov     rdi, 0						;exit status
	syscall								;calling system services