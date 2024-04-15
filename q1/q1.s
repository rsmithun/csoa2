.global solve

solve:
    xor %r15, %r15                  # Initialize counter to 0
    movq $0, (%r8, %r15, 8)         # Initialize prefix sum array at index 0 to 0

.prefixSum:
    mov (%rcx, %r15, 8), %r13      # Load arr[%r15] into %r13
    mov (%r8, %r15, 8), %r12       # Load prefix sum at index %r15 into %r12
    add %r12, %r13                 # Add prefix sum to arr[%r15]
    inc %r15                       # Increment counter (%r15)
    mov %r13, (%r8, %r15, 8)       # Store updated prefix sum at index %r15
    cmp %r15, %rdi                 # Compare counter with array length
    je .subArray                   # Jump to .subArray if all elements are processed
    jmp .prefixSum                 # Continue processing elements

.subArray:
    xor %r10, %r10                   # Initialize left index to 0
    mov %rsi, %r11                   # Initialize right index to array length - 1
    dec %r11                         # Decrement right index to start from the last element
    mov $-9223372036854775808, %rax  # Initialize max_sum to INT_MIN

.whileLoop:
    cmp %r11, %rdi                 # Compare right index with array length
    jle .endLoop                   # Exit loop if right index is less than or equal to array length
    inc %r11                       # Increment right index
    mov (%r8, %r11, 8), %r12       # Load prefix sum at right + 1 index into %r12
    sub (%r8, %r10, 8), %r12       # Calculate subarray sum (subarray_sum = prefix_sum[right + 1] - prefix_sum[left])
    cmp %rax, %r12                 # Compare subarray sum with max_sum
    jl .skipMaxUpdate              # Jump if subarray sum is less than max_sum
    mov %r12, %rax                 # Update max_sum if subarray sum is greater

.skipMaxUpdate:
    mov %r10, %r13                 # Store left index in %r13
    mov %r11, %r14                 # Store right index in %r14
    sub %r13, %r14                 # Calculate subarray length
    inc %r14                       # Increment subarray length by 1
    cmp %rdx, %r14                 # Compare subarray length with desired subarray length
    jl .updateRight                # Jump to updateRight if subarray length is less than desired length
    inc %r10                       # Increment left index
    cmp %r11, %r10                 # Compare left index with right index
    jle .whileLoop                 # Continue loop if left index is less than or equal to right index
    mov %r10, %r13                 # Store left index in %r13
    mov %r11, %r14                 # Store right index in %r14
    add %rsi, %r13                 # Add L to left index
    dec %r13                       # Decrement left index
    mov %r13, %r10                 # Update right index (right = left + L - 1)
    jmp .whileLoop                 # Continue loop

.updateRight:
    inc %r11                       # Increment right index
    jmp .whileLoop                 # Continue loop

.endLoop:
    ret                            # Return from function
