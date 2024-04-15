.global nCr

nCr:
    push %r12          # Save the value of %r12
    push %r13          # Save the value of %r13
    cmp $0, %rsi       # Compare r with 0
    je .basecase       # Jump to base case if r == 0
    cmp %rdi, %rsi     # Compare n with r
    je .basecase       # Jump to base case if n == r
    jmp .recursion     # Jump to the recursion part if not in base case

.basecase:
    mov $1, %rax      # Set return value to 1 (nCr = 1 if r == 0 or n == r)
    jmp .done         # Jump to done

.recursion:             # nCr(n,r) = (nCr(n-1, r-1)*n)/r
    mov %rdi, %r12      # Move the value of n into %r12
    mov %rsi, %r13      # Move the value of r into %r13
    dec %rdi            # Decrement n
    dec %rsi            # Decrement r
    call nCr            # Call nCr recursively with decremented values of n and r
    imul %r12, %rax     # Multiply the result of the recursive call by n
    xor %rdx, %rdx      # Clear %rdx before division
    idiv %r13           # Divide the result by r

.done:
    pop %r13     # Restore the value of %r13
    pop %r12     # Restore the value of %r12
    ret          # Return the value of nCr that is stored in %rax
