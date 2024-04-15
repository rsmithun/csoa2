.global postFix

postFix:
    xor %r15, %r15    # Initialize %r15 to 0 to use as a loop counter

.loop:
    cmp %rsi, %r15               # Compare %r15 with the length of the string
    je .done                     # Jump to .done if the end of the string is reached
    mov (%rdi, %r15, 1), %r8b    # Load the byte at address (%rdi + %r15) into %r8b
    movzbq %r8b, %r11            # Zero-extend the byte in %r8b to a quadword in %r11
    inc %r15                     # Increment %r15 to move to the next character

    cmp $32, %r11     # Compare the character with ASCII 32 (space)
    je .loop          # If it's a space, continue to the next iteration

    cmp $48, %r11     # Compare the character with ASCII 48 ('0')
    jle .operation    # If it is an operator (+, -, *, /) jump to .operation
    jg .number        # If it is a number, jump to .number

.operation:
    pop %r9         # Pop the top operand from the stack
    pop %r10        # Pop the second operand from the stack

    cmp $43, %r11   # Compare the character with ASCII 43 ('+')
    je .add         # If it's '+', jump to .add
    cmp $45, %r11   # Compare the character with ASCII 45 ('-')
    je .subtract    # If it's '-', jump to .subtract
    cmp $42, %r11   # Compare the character with ASCII 42 ('*')
    je .multiply    # If it's '*', jump to .multiply
    cmp $47, %r11   # Compare the character with ASCII 47 ('/')
    je .divide      # If it's '/', jump to .divide

.add:
    add %r9, %r10    # Add the two operands
    push %r10        # Push the result back to the stack
    jmp .loop        # Jump back to the beginning of the loop

.subtract:
    sub %r10, %r9    # Subtract the second operand from the first
    push %r9         # Push the result back to the stack
    jmp .loop        # Jump back to the beginning of the loop

.multiply:
    imul %r9, %r10   # Multiply the two operands
    push %r10        # Push the result back to the stack
    jmp .loop        # Jump back to the beginning of the loop

.divide:
    mov %r10, %rax   # Move the second operand to %rax for division
    xor %rdx, %rdx   # Clear %rdx for division
    idiv %r9         # Divide %rax by the first operand
    push %rax        # Push the result back to the stack
    jmp .loop        # Jump back to the beginning of the loop

.number:
    sub $48, %r11    # Convert ASCII digit to integer
    push %r11        # Push the integer onto the stack
    jmp .loop        # Jump back to the beginning of the loop

.done:
    pop %rax        # Pop the final result from the stack into %rax
    ret             # Return from the function
