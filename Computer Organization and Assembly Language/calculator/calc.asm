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
buffer    resb 63
bufferLen resb 1
op        resb 1
num2      resb 1
total     resb 1
ascii     resb 4
asciiLen  resb 1

section .data
LF		        equ	10
NULL		    equ	0
SYS_exit	    equ	60
EXIT_SUCCESS	equ	0
msg1            db "Enter Operations String: ", NULL
msg2            db " = ", NULL

section .text
    global _start
_start:                      
    print   msg1, 25
    scan    buffer, 63                         ;get equation (to change max size change .bss and this)
    mov     r10, 0                             ;initialize counter
    mov     al, byte[buffer + r10]
    and     al, 0fh                            ;total = atoi(buffer[r10])
    mov     byte[total], al                    ;get first num of set
    inc     r10
calcLoop:
    mov     al, byte[buffer + r10]
    mov     byte[op], al                       ;get op of set
    inc     r10

    mov     al, byte[buffer + r10]             ;get second num of set
    and     al, 0fh                            ;num2 = atoi(buffer[r10])
    mov     byte[num2], al
    inc     r10
checkAdd:
    cmp     byte[op], '+'                      ;if op is '+'
    jne     checkSub                           ;[total] += num2
    mov     dil, byte[total]
    mov     sil, byte[num2]
    call    addition
    jmp     calcLoop
checkSub:
    cmp     byte[op], '-'                      ;if op is '-'
    jne     checkMult                          ;[total] -= num2
    mov     dil, byte[total]
    mov     sil, byte[num2]
    call    subtract
    jmp     calcLoop
checkMult:
    cmp     byte[op], '*'                      ;if op is '*'
    jne     checkDiv                           ;[total] *= num2
    mov     dil, byte[total]
    mov     sil, byte[num2]
    call    mult
    jmp     calcLoop
checkDiv:
    cmp     byte[op], '/'                      ;if op is '/'
    jne     next1                              ;[total] /= num2
    mov     dil, byte[total]                   ;if op is not divide we reached the end of the equation
    mov     sil, byte[num2]
    call    divide
    jmp     calcLoop
next1:
    dec     r10                                ;dec r10 to match the size of eqn
    dec     r10
    print   buffer, r10                        ;print the buffer without null chars
    print   msg2, 3                            ;print the " = "
    call    toString                           ;ascii = itoa(total)
    print   ascii, [asciiLen]                  ;print the total without null chars
;end
    mov     rax, SYS_exit			           ;terminate excuting process
    mov     rdi, EXIT_SUCCESS			       ;exit status
    syscall	


addition:
    mov al, dil
    add al, sil
    mov byte[total], al
    ret
subtract:
    mov al, dil
    sub al, sil
    mov byte[total], al
    ret
mult:
    mov al, dil
    mul sil
    mov byte[total], al
    ret
divide:
    mov al, dil
    div sil
    mov byte[total], al
    ret

;ascii = itoa(total); convert total from int to string
toString:
	; Part A - Successive division
	    mov 	al, byte[total]
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
    	ret