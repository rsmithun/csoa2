.global binarysearch

binarysearch:
    mov $0, %r8     # left
    mov $31, %r9    # right
    mov $15, %r10   # mid
    mov $0, %r11    # iterations

.whileloop:
    inc %r11
    cmp %r9, %r8
    jg .notfound  # end if left > right

    mov %r8, %r14   # save left
    mov %r9, %r15   # save right

    add %r14, %r15
    sar $1, %r15
    mov %r15, %r10

    mov (%rdi, %r10, 8), %rbx  # accesssing nth element

    cmp %rsi, %rbx
    je .found
    jl .updateleft
    jg .updateright

.found:
    mov %r10, %rax
    mov %r11, %rcx
    jmp .done

.notfound:
    mov $-1, %rax
    jmp .done

.updateleft:
    mov %r10, %r8
    inc %r8
    jmp .whileloop

.updateright:
    mov %r10, %r9
    dec %r9
    jmp .whileloop

.done:
    mov %rcx, (%rdx)
    ret

