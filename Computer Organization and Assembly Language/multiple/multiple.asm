;unsigned short num = 225; 	            // use dw to declare 16-bit variable
;unsigned short mul_3 = 0, other = 0; 	// use dw to declare 16-bit variable
;if(num % 3 == 0 && num % 5 != 0) {
;    mul_3++;
;} else {
;    other++;
;}

section .data
SYS_exit	    equ	60
EXIT_SUCCESS	equ	0
num         	dw	225
mul_3		    dw	0
other	        dw	0
mod_3           dw  3
mod_5           dw  5

section .text
    global _start
_start: 
        mov bx, 0
        mov ax, word[num]
        div word[mod_3]
        cmp bx, 0
        je  and1
        jne else
and1:
        mov bx, 0
        mov ax, word[num]
        div word[mod_5]
        cmp bx, 0
        jne if
        je else
if:
        inc word[mul_3]
        jmp end
else:
        inc word[other]
        jmp end
end: 
        mov     rax, SYS_exit			;terminate excuting process
        mov     rdi, EXIT_SUCCESS		;exit status
        syscall				        	;calling system services