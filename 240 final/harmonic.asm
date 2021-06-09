;Nicholas Ayson
;nick.ayson@csu.fullerton.edu


;Declare the names of functions called in this file whose source code is not in this file.
extern printf
extern scanf
extern gettime

global harmonic                    ; Makes function callable from other linked files.

section .data
    instructions db "Please enter the number of terms desired:  ", 0

    frequency db "Enter the frequency of the processor as positive integer: ", 10 , 0

    intialClock db 10, "The time is now %ld tics", 10, 10, 0
    finalClock db 10, "The time is now %ld tics.", 10, 0

    terms db "k = %10ld              sum = %.13lf",10, 0

    time db "The harmonic algorithm executed for a total time = %ld tics, on a %ld Hz Machine", 10, 10, 0

    stringFormat db "%s", 0
    floatFormat db "%lf",0

section .bss
section .text

harmonic:

; Back up all registers and set stack pointer to base pointer
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

;===========================================================================================================================
push qword -1                   ; Extra push to create even number of pushes

;INITIALIZE PARAMETERS
mov r15, 0x0000000000000000
movq xmm15, r15                 ; Reserved xmm15 register for Harmonic sum.

mov rax, 0x3ff0000000000000     ; Copy 1.0 float into rax to mov into xmm14 iterator.
movq xmm14, rax                 ; Reserved xmm14 register to iterate loop start at 1.

movq xmm12, r15                 ; Reserve xmm12 for input value set to 0.0

;instruction prompt
mov rax, 0
mov rdi, stringFormat
mov rsi, instructions           ;"Please enter the number of terms desired:  "
call printf

push qword -1
mov rax, 1
mov rdi, floatFormat            ; "%lf"
mov rsi, rsp
call scanf

movsd xmm12, [rsp]              ; Input value saved as float in xmm12


;frequency prompt
mov rax, 0
mov rdi, stringFormat
mov rsi, frequency            ;"Enter the frequency of the processor as positive integer: "
call printf


mov rax, 1
mov rdi, floatFormat          ; "%lf"
mov rsi, rsp
call scanf
movsd xmm8, [rsp]             ;frequency now in xmm8


;Calculate term increments
mov r8, 0x4024000000000000      ; Number 10.0 in hex IEEE754
movq xmm1, r8
movq xmm11, xmm12
divsd xmm11, xmm1               ; Divide input value by 10.0 to use for incremented printing
roundsd xmm11, xmm11, 2         ; Save input value Divided by 10 and rounded up into xmm11.

;initial clock prompt
mov rax, 0
call gettime                    ; Call gettime function to get current cpu tics.
mov r14, rax                    ; Save initial clock time in r14 (tics).

mov rax, 0
mov rdi, intialClock            ;"The time is now %ld tics "
mov rsi, r14                    ; Initial clock tics retrieved from gettime function.
call printf

mov rax, 0x3ff0000000000000     ; 1.0 in hex for Harmonic sum division.
movq xmm10, rax

cvtsd2si r13, xmm11             ; Convert Rounded value to integer for Print intervals.
mov r15, r13                    ; Copy rounded value to be added to itself in loop.

mov r12, 0                      ; Iterator to compare and indicate when to print, set = 0.
movsd xmm13, xmm12              ; Copy input value to xmm13 for end of loop comparison.
addsd xmm13, xmm10              ; Increment xmm13 to 1.0 more then input value

;==============================BEGIN LOOP===================================================
begin_loop:

ucomisd xmm14, xmm13            ; Compare iterator to 1.0 more than input value
je end_loop                     ; Exit loop if iterations > input value.

cmp r12, r13                    ; Compare
je print                        ; If iteration is multiple of rounded value print sum & term
inc r12                         ; Increment iterator.

movsd xmm9, xmm10               ; Copy value 1.0 into xmm9
divsd xmm9, xmm14               ; Divide 1.0 by current iteration (xmm14)
addsd xmm15, xmm9               ; Add to harmonic sum

addsd xmm14, xmm10              ; Add 1.0 to iterator

jmp begin_loop



;print current term and sum
print:
mov rax, 1                      ; Pass 1 to rax for floating point.
mov rdi, terms                  ; "k = %10ld              sum = %.13lf"
movsd xmm0, xmm15               ; Pass Harmonic sum (float) at current term
mov rsi, r12
call printf

add r13, r15                    ; Increment term (r13) by rounded value in r15.

jmp begin_loop                  ; Restart loop

end_loop:
;================================End loop===================================================

;print the final term and sum
mov rax, 1
mov rdi, terms                  ; "k = %10ld              sum = %.13lf"
movsd xmm0, xmm15               ; Pass Final Harmonic sum to be printed.
mov rsi, r12                    ; Pass Input value to print term correlating to final Sum
call printf


;print the final clock
mov rax, 0
call gettime                    ; Retrieve final cpu clock time (tics).
mov r15, rax                    ; Save final clock time in r15 (tics).

mov rax, 0
mov rdi, finalClock             ; "The clock is now %ld tics."
mov rsi, r15                    ; Clock time retrieved from gettime function.
call printf                     ; Print Final clock after Calculating Harmonic Sum.

;PRINT  TIME
cvtsi2sd xmm10, r15             ; Convert final clock to float
cvtsi2sd xmm7, r14              ; Convert Initial clock to float
subsd xmm10, xmm7               ; Subtract Final clock from intial clock.

cvtsd2si r15, xmm10             ; Convert Elapsed time to long integer for print.

mov rax, 1
mov rdi, time                   ; "The harmonic algorithm executed for a total time = %ld tics, on a %ld Hz Machine"
mov rsi, r15                    ; Pass Final clock time minus Initial clock time.
movsd xmm0, xmm8                ; frequency to time statement
call printf

;sum to the main

movq xmm0, xmm15                ; Pass final Harmonic sum of input value to driver.

;================================END OF FILE================================================

pop rax                         ; Extra pop to align stack to 16 bytes.
pop rax                         ; Remove extra push of -1 from stack.


;=================================================================================================================================
; Restores all registers to their original state.
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
