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
    num1        resb 1
    num2        resb 1
    num3        resb 1
    sum         resb 1
    quotient    resb 1
    buffer      resb 2
    ascii       resb 10
    asciiLen    resb 1
    argument    resb 1

section .data
    LF		        equ	10
    NULL		    equ	0
    SYS_exit	    equ	60
    EXIT_SUCCESS	equ	0
    msg1            db  "Input 1st number (0~9): ", NULL
    msg2            db  "Input 2nd number (0~9): ", NULL
    msg3            db  "Input 3rd number (0~9): ", NULL
    msg4            db  "sum = ", NULL
    msg5            db  "quotient = ", NULL

section .text
    global _start
_start:
    print   msg1, 24
    scan    buffer, 2
    mov     al, byte[buffer]
    and     al, 0fh
    mov     byte[num1], al

    print   msg2, 24
    scan    buffer, 2
    mov     al, byte[buffer]
    and     al, 0fh
    mov     byte[num2], al

    print   msg3, 24
    scan    buffer, 2
    mov     al, byte[buffer]
    and     al, 0fh
    mov     byte[num3], al

    mov     dil, byte[num1]
    mov     sil, byte[num2]
    call    calculate

    print   msg4, 6
    mov 	al, byte[sum]
    call    toString

    print   msg5, 11
    mov 	al, byte[quotient]
    call    toString

;end
    mov     rax, SYS_exit			           ;terminate excuting process
    mov     rdi, EXIT_SUCCESS			       ;exit status
    syscall	


calculate:
    mov al, dil
    add al, sil
    mov byte[sum], al

    mov bl, byte[num3]
    cmp bl, 0
    jnz div0
    mov byte[quotient], bl
    jmp done1
div0:
    div bl
    mov byte[quotient], al
done1:
    ret

toString:
	; Part A - Successive division
    	mov 	rcx, 0 			
    	mov 	rbx, 10 				
    divideLoop:
	    mov 	edx, 0
    	div 	rbx			
    	push 	dx 			
    	inc 	rcx 		
    	cmp 	eax, 0 	
    	jne 	divideLoop 
        inc     cl
        mov     byte[asciiLen], cl
        dec     cl

	; Part B - Convert remainders and store
	    mov 	rbx, ascii 		
    	mov 	rdi, 0 		
    popLoop:
    	pop 	ax 		
    	add 	al, "0" 
    	mov 	byte [rbx+rdi], al 	
    	inc 	rdi 		
    	loop 	popLoop
        mov 	byte[rbx+rdi], LF
        print   ascii, [asciiLen]
    	ret
