global sum                             ; Makes function callable from other linked files.

section .data

section .bss

section .text

sum:
;=====================================================================================================

; Back up all registers to stack and set stack pointer to base pointer
push rbp
mov rbp, rsp
push rdi
push rsi
push rdx
push rcx
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
push rbx
pushf

push qword -1                           ; Extra push onto stack to make even # of pushes.

mov r15, rdi                            ; Copies array that was passed to r15.
mov r14, rsi                            ; Copies number of elements in the array to r14.
mov r13, 0                              ; Sum register to add elements of array to.
mov r12, 0                              ; Counter to to iterate through array.

;=========================================== Start of Loop ==========================================
begin_loop:

; Compares the counter (r12) to the number of elements in the array (r14).
cmp r12, r14
jge outofloop

;======================================= Copy into array ===========================================
; Adds element of array at index of r12 to the Sum of register r13.
add r13, [r15 + 8 * r12]
inc r12                                 ; Increments counter r12 by 1.

; Restarts loop
jmp begin_loop

;======================================= End of loop =================================================
outofloop:

; Restores all backed up registers to their original state.
pop rax                                ; Remove extra push of -1 from stack.
mov qword rax, r13                     ; Copies sum (r13) to rax.
popf
pop rbx
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rcx
pop rdx
pop rsi
pop rdi
pop rbp

ret
