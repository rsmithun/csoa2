.global solve

solve:
    xor %r15, %r15      # Initialize %r15 to 0 to use as a loop counter
    xor %r14, %r14      # Initialize %r14 to 0 to keep track of the number of scores
    xor %rax, %rax      # Initialize %rax to 0 to store the total sum

.loop:
    cmp %rsi, %r15                # Compare %r15 with the length of the string
    je .total                     # Jump to .total if the end of the string is reached
    mov (%rdi, %r15, 1), %r8b     # Load the byte at address (%rdi + %r15) into %r8b
    movzbq %r8b, %r11             # Zero-extend the byte in %r8b to a quadword in %r11
    add $1, %r15                  # Increment %r15 to move to the next character

    cmp $67, %r11   # Compare the character with ASCII 67 ('C')
    je .C           # If it's 'C', jump to .C
    cmp $68, %r11   # Compare the character with ASCII 68 ('D')
    je .D           # If it's 'D', jump to .D
    cmp $43, %r11   # Compare the character with ASCII 43 ('+')
    je .sum         # If it's '+', jump to .sum
                    # Else it is a number
    sub $48, %r11   # Convert ASCII digit to integer
    push %r11       # Push the integer onto the stack
    inc %r14        # Increment the count of scores
    jmp .loop       # Jump back to the beginning of the loop

.C:
    pop %rcx        # Remove the last recorded score from the stack
    dec %r14        # Decrement the count of scores
    jmp .loop       # Jump back to the beginning of the loop

.D:
    movq (%rsp), %r12   # Get the last recorded score from the stack
    sal $1, %r12        # Double the score
    push %r12           # Push the doubled score onto the stack
    inc %r14            # Increment the count of scores
    jmp .loop           # Jump back to the beginning of the loop

.sum:
    movq (%rsp), %r12      # Get the last recorded score from the stack
    movq 8(%rsp), %r13     # Get the second last recorded score from the stack
    add %r12, %r13         # Add the last two scores
    push %r13              # Push the sum onto the stack
    inc %r14               # Increment the count of scores
    jmp .loop              # Jump back to the beginning of the loop

.total:
    pop %rbx          # Get the last score from the stack
    add %rbx, %rax    # Add it to the total sum
    dec %r14          # Decrement the count of scores
    cmp $0, %r14      # Check if there are more scores
    jnz .total        # If yes, jump back to .total

    ret               # Return from the function
