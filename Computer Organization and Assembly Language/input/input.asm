section .data
    LF              equ 10
    NULL            equ 0
    SYS_exit	    equ	60
    EXIT_SUCCESS	equ	0
    msg1            db  "Input a number (1~9): "
    msg2            db  " is Multiple of 3.", LF

section .bss
    buffer          resb 1
    num             resb 1
    ascii           resb 10

section .text
    global _start

_start: 
;register int r10 = 0;
    mov r10, 0
;do{
doloop: 

;cout << msg1;
    mov     rax, 1				
    mov     rdi, 1				
    mov     rsi, msg1			
    mov     rdx, 22				
    syscall	

;cin >> buffer;
    mov	rax, 0				
	mov	rdi, 0				
	mov	rsi, buffer			
	mov	rdx, 2				
	syscall		
    			
;ascii[r10] = buffer;
    mov al, byte[buffer]
    mov byte[ascii + r10], al

;r10++;
    inc r10
    cmp r10, 9
    jb doloop
;}while(r10 < 9);

;r10 = 0;
    mov r10, 0

;do {
doloop2:

;num = atoi(ascii[r10]);
    mov al, byte[ascii + r10]
    and al, 0fh
    mov byte[num], al

;if(num%3 == 0) {
    mov ah, 0
    mov al, byte[num]
    mov bl, 3
    div bl
    cmp ah, 0
    jnz next

;cout << ascii[r10] << msg2;
    mov al, byte[ascii + r10]
    mov byte[buffer], al
    mov     rax, 1				
    mov     rdi, 1				
    mov     rsi, buffer
    mov     rdx, 1  		    
    syscall					   

    mov     rax, 1				
    mov     rdi, 1				
    mov     rsi, msg2			
    mov     rdx, 19			
    syscall					    
;}

;r10++;
next:
    inc r10
    cmp r10, 9
    jb  doloop2
;} while(r10 < 9);

    mov     rax, SYS_exit			
    mov     rdi, EXIT_SUCCESS		
    syscall					
