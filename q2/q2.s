.global nCr 

nCr:
    push %r12
    push %r13

    mov %rdi, %r12  
    mov %rsi, %r13

    cmp $0, %rsi      
    je .basecase  
    cmp %rdi, %rsi
    je .basecase  

    jmp .recursion        

.basecase:
    mov $1, %rax
    jmp .done

.recursion:

    mov %rdi, %r12  
    mov %rsi, %r13  
    dec %rdi
    dec %rsi
    call nCr
    imul %r12, %rax
    mov $0, %rdx
    idiv %r13

.done:
    pop %r13
    pop %r12
    ret 
