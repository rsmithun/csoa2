.global binarysearch

binarysearch:
    xor %r8, %r8      # Initialise left pointer to 0
    mov $31, %r9      # Initialise right pointer to 31
    mov $15, %r10     # Initialise value of mid
    xor %r11, %r11    # Initialise iterations counter to 0

.whileloop:
    inc %r11         # Increment iterations counter
    cmp %r9, %r8     # Compare left and right pointer
    jg .notfound     # If left > right, exit loop

    mov %r8, %r14    # Save left pointer
    mov %r9, %r15    # Save right pointer

    add %r14, %r15   # Calculate mid value (mid=(r+l)/2)
    sar $1, %r15
    mov %r15, %r10   # Store mid value in %r10

    mov (%rdi, %r10, 8), %rbx    # Access element at mid

    cmp %rsi, %rbx     # Compare element with search value
    je .found          # Jump to found if element found
    jl .updateleft     # Update left pointer if element less than search value
    jg .updateright    # Update right if element greater than search value

.found:
    mov %r10, %rax    # Store mid index in %rax (return value)
    mov %r11, %rcx    # Store iterations count in %rcx (optional)
    jmp .checkleft    # Continue to check if there are duplicates on the left

.notfound:
    mov $-1, %rax   # Set return value to -1 (not found)
    jmp .done       # Jump to end of function

.updateleft:
    mov %r10, %r8    # Update left pointer to mid + 1
    inc %r8
    jmp .whileloop   # Repeat the loop

.updateright:
    mov %r10, %r9    # Update right pointer to mid - 1
    dec %r9
    jmp .whileloop   # Repeat the loop

.checkleft:
    cmp $0, %r10                 # Check if mid pointer is at the beginning
    je .done                     # If so, all elements to the left have been checked
    dec %r10                     # Move to the left element
    mov (%rdi, %r10, 8), %rbx    # Access left element
    cmp %rsi, %rbx               # Compare left element with search value
    je .updateindex              # Update index if left element is equal to search value
    jmp .done                    # If not, jumo to end of function

.updateindex:
    mov %r10, %rax     # Update return value to index of left element
    jmp .checkleft     # Continue checking for more duplicates to the left

.done:
    mov %rcx, (%rdx)    # Store iterations count to the address in %rdx
    ret                 # Return, with return value in %rax
