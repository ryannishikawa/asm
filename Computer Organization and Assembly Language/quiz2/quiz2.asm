;signed short shortArr[10] = {-3012, 623, -1234, 2345, 3456, 1267, -89, 6232, -231, 0};
;signed short evenSum;
;register long rsi = 0	//64-bit register
;register long rdi = 0	//64-bit register
;while (num[rsi] != 0) {
;	if(shortArr[rsi] < 0 && shortArr[rsi]%2 == 0) {
;		evenSum += shortArr[rsi];
;	}
;	rsi++;
;}

section .data
    SYS_exit	    equ	60
    EXIT_SUCCESS	equ	0
    shortArr        dw  -3012, 623, -1234, 2345, 3456, 1267, -89, 6232, -231, 0
    
section .bss
    evenSum		resw	1

section .text
    global _start

_start:
    mov word[evenSum], 0
    mov rsi, 0
    mov rdi, 0
while: 
    cmp word[shortArr + (rsi*2)], 0
    je done
    jg next

    mov ax, word[shortArr + (rsi*2)]
    cwd
    mov bx, 2
    idiv bx
    cmp dx, 0
    jne next

    mov ax, word[shortArr + (rsi*2)]
    add word[evenSum], ax
next:
    inc rsi
    jmp while
done: 
    mov     rax, SYS_exit			;terminate excuting process
    mov     rdi, EXIT_SUCCESS		;exit status
    syscall