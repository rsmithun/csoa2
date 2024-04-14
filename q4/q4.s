.global solve

solve:
    xor %r15, %r15
    xor %r14, %r14
    xor %rax, %rax

.loop:
    cmp %rsi, %r15
    je .total
    mov (%rdi, %r15, 1), %r8b
    movzbq %r8b, %r11
    add $1, %r15

    cmp $67, %r11 
    je .C
    cmp $68, %r11 
    je .D
    cmp $43, %r11 
    je .sum

    sub $48, %r11
    push %r11
    inc %r14
    jmp .loop

.C:
    pop %rcx
    dec %r14
    jmp .loop

.D:
    movq (%rsp), %r12
    sal $1, %r12
    push %r12
    inc %r14
    jmp .loop
.sum:
    movq (%rsp), %r12
    movq 8(%rsp), %r13
    add %r12, %r13
    push %r13
    inc %r14
    jmp .loop

.total:
    pop %rbx
    add %rbx, %rax
    dec %r14
    cmp $0, %r14
    jnz .total

    ret


