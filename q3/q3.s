.global postFix

postFix:
    mov $0, %r15

.loop:
    cmp %rsi, %r15
    je .done
    mov (%rdi, %r15, 1), %r8b
    movzbq %r8b, %r11
    inc %r15

    cmp $32, %r11
    je .loop

    cmp $48, %r11
    jle .operation
    jg .number

.operation:
    pop %r9
    pop %r10

    cmp $43, %r11  # +
    je .add
    cmp $45, %r11  # -
    je .subtract
    cmp $42, %r11  # *
    je .multiply
    cmp $47, %r11  # /
    je .divide

.add:
    add %r9, %r10
    push %r10
    jmp .loop

.subtract:
    sub %r10, %r9
    push %r9
    jmp .loop

.multiply:
    imul %r9, %r10
    push %r10
    jmp .loop

.divide:
    mov %r10, %rax
    xor %rdx, %rdx
    idiv %r9
    push %rax
    jmp .loop

.number:  
    sub $48, %r11
    push %r11
    jmp .loop

.done:
    pop %rax
    ret