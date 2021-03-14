extern printf
extern scanf
extern control
global fill

segment .data

prompt1 db "Please enter floating point numbers separated by ws.",10,0

prompt2 db "When finished press enter followed by cntl+D.",10,0

floatformat db "%lf",0




segment .bss

segment .text

fill:

;=============================================================================================
push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf

push qword 0


;Initialize the parameters
mov r15, rdi      ;r15 is the array
mov r14, rsi      ;r14 is maximum amount of elements in array
mov r13, 0        ;set counter to 0

;====================Prompt 1  and 2 Display===============================================================

push qword 0
mov rax, 0
mov rdi, prompt1          ;"Please enter floating point numbers separated by ws."
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, prompt2          ;"When finished press enter followed by cntl+D."
call printf
pop rax

;========================Begin Loop===========================================================

begin_loop:       ;begins to fill the loop

;Scanf funtion to take the user input
mov rax, 0
mov rdi, floatformat

push qword 0
mov rax, 0
mov rsi, rsp
call scanf
pop rax

;tests to see if cntl d is pushed
cdqe
cmp rax, -1
je end_of_loop          ;if cntl d is entered exit the loop

;input in r12
mov [r15 + 8 *r13], r12         ;copies user input into array at index of r13
inc r13                         ;increments r13 by 1.

;check to see if aren't adding outside the loop
cmp r13, r14          ;r13 = count
je exit               ;r14 = max

jmp begin_loop        ;goes back to beginning

;================================End of Loop=========================================================================

;after cntl D is entered the loop is skipped to the end
end_of_loop:
mov rax, 13

;===========================Exit==========================================================================
exit:
pop rax

;restores all backed up registers to original
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp


ret

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
