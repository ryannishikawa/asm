%macro	print 	2
    mov     rax, 1					;SYS_write
    mov     rdi, 1					;where to write
    mov     rsi, %1					;address of strint
    mov     rdx, %2					;number of character
    syscall						    ;calling system services
%endmacro

%macro	scan 	2
    mov     rax, 0					;SYS_read
    mov     rdi, 0					;standard input device
    mov     rsi, %1					;input buffer address
    mov     rdx, %2					;number of character
    syscall				     		;calling system services
%endmacro

section .bss
    buffer resb 4
    n      resd 1
    sumN   resd 1
    ascii  resb 10
    ascii_length resb 1

section .data
    LF		        equ	10
    NULL		    equ	0
    SYS_exit	    equ	60
    EXIT_SUCCESS	equ	0
    msg1            db  "Input a number (004~999): ", NULL
    msg2            db  "1 + 2 + 3 +...+ ", NULL
    msg3            db  " = ", NULL

section .text
    global _start
_start:
    print msg1, 26
    scan  buffer, 4

;n = atoi(buffer);
    mov eax, 0
    mov ebx, 10
    mov rsi, 0
inputLoop:
    mov dl, byte[buffer+rsi]
    and dl, 0fh
    add al, dl
    adc ah, 0
    cmp rsi, 2
    je skipMul
    mul ebx
skipMul:
    inc rsi
    cmp rsi, 3
    jl inputLoop
    mov dword[n], eax

;counter to zero;
    mov ecx, 0
;1 + 2 + 3 +...+ n
sumLoop:
	add	dword[sumN], ecx
	inc	ecx
	cmp	ecx, dword[n]
	jbe	sumLoop	

;ascii = itoa(sumN);
    mov eax, dword[sumN]
    mov cl, 0
    mov ebx, 10
divideLoop:
    mov edx, 0
    div ebx
    push rdx
    inc cl
    cmp eax, 0
    jne divideLoop
    movzx rcx, cl
    mov byte[ascii_length], cl

    mov rbx, ascii
    mov rdi, 0
popLoop:
    pop rax
    add al, "0"
    mov byte[rbx+rdi], al
    inc rdi
    loop popLoop
    mov byte[rbx+rdi], LF

    print msg2, 16
    print buffer, 3
    print msg3, 3
    print ascii, [ascii_length]

    mov     rax, SYS_exit				;terminate excuting process
    mov     rdi, EXIT_SUCCESS			;exit status
    syscall						        ;calling system services

