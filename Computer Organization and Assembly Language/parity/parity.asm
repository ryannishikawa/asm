;unsigned short array[7] = {12, 1003, 6543, 24680, 789, 30123, 32766};	// use dw for 16-bit array
;unsigned short even[7]; 	                                            // use dw to declare 16-bit variable
;register long rsi = 0, rdi = 0; 	                                    // no need to declare register rsi and rdi
;do {
;	if(array[rsi] % 2 == 0) {
;		even[rdi] = array[rsi];
;		rdi++;
;	}
;	rsi++;
;} while(rsi < 7);

section .data
    SYS_exit	    equ	60
    EXIT_SUCCESS	equ	0
    array		    dw	12, 1003, 6543, 24680, 789, 30123, 32766
    even            dw  0, 0, 0, 0, 0, 0, 0
    mod_2           dw  2

section .text
    global _start

_start:
    mov rsi, 0
    mov rdi, 0
doloop:
    mov dx, 0
    mov ax, word[array + (rsi*2)]
    div word[mod_2]
    cmp dx, 0
    jne not_zero
    mov ax, word[array + (rsi*2)]
    mov word[even + (rdi*2)], ax
    inc rdi
not_zero:
    inc rsi
    cmp rsi, 7
    jb doloop

    mov     rax, SYS_exit			;terminate excuting process
    mov     rdi, EXIT_SUCCESS		;exit status
    syscall
