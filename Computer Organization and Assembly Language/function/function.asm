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
buffer          resb 4
n               resd 1
sumN            resd 1
ascii           resb 10
ascii_length    resb 1

section .data
LF		        equ	10
NULL		    equ	0
SYS_exit	    equ	60
EXIT_SUCCESS	equ	0
msg1            db "Input a number (004~999): ", NULL
msg2            db  "1 + 2 + 3 +...+ ", NULL
msg3            db  " = ", NULL

section .text
    global _start
_start:
    print   msg1, 26
    scan    buffer, 4

;n = atoi(buffer);
    mov     rbx, buffer
    call    toInteger

; calculates 1+2+3+...+N
    mov     ecx, 0
    mov     edi, dword[n]
    call    calculate

;ascii = itoa(sumN);
	mov	    edi, dword[sumN]
	call	toString

; display message and result
	print	msg2, 16
    print   buffer, 3
    print   msg3, 3
	print	ascii, [ascii_length]

;end
    mov     rax, SYS_exit				;terminate excuting process
    mov     rdi, EXIT_SUCCESS			;exit status
    syscall			

;n = atoi(buffer);
toInteger:
        mov	rax, 0					;clear rax
    	mov	rdi, 10					;rdi = 10
    	mov	rsi, 0					;counter = rsi = 0
    next0:
    	mov dl, byte[rbx+rsi]
        and dl, 0fh
        add al, dl
        adc ah, 0
        cmp rsi, 2
        je skip0
        mul rdi
    skip0:
    	inc	rsi					
	    cmp	rsi, 3
    	jl	next0
	    mov	dword[n], eax
	    ret

;1 + 2 + 3 +...+ n
calculate:
    sumLoop:
	    add	dword[sumN], ecx
    	inc	ecx
	    cmp	ecx, edi
    	jbe	sumLoop
        ret

;ascii = itoa(sumN);
toString:
	; Part A - Successive division
	mov 	eax, edi
	mov 	rcx, 0 			
	mov 	ebx, 10 				
divideLoop:
	mov 	edx, 0
	div 	ebx 			
	push 	rdx 			
	inc 	rcx 		
	cmp 	eax, 0 	
	jne 	divideLoop 	
    inc     cl
    mov     byte[ascii_length], cl
    dec     cl

	; Part B - Convert remainders and store
	mov 	rbx, ascii 		
	mov 	rdi, 0 		
popLoop:
	pop 	rax 		
	add 	al, "0" 
	mov 	byte [rbx+rdi], al 	
	inc 	rdi 		
	loop 	popLoop 		
	mov 	byte[rbx+rdi], LF	
	ret