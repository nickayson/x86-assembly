;********************************************************************************************
; Program name:          interview                                                          *
; Programming Language:  x86 Assembly                                                       *
; Program Description:   This program asks a user to play the role of an interviewee asking for salary*
;                       returns the salary the company is willing to give.                   *
; Built on: Tuffix 2020
;                                                                                            *
; ********************************************************************************************
;  Author Information:                                                                       *
;  Name:         Nicholas Ayson                                                              *
;  Email:        nick.ayson@csu.fullerton.edu                                                *
;  Institution:  California State University - Fullerton                                     *
;  Course:       CPSC 240-05 Assembly Language                                               *
;                                                                                            *
; ********************************************************************************************
;  Copyright (C) 2020 Nicholas Ayson                                                         *
;  This program is free software: you can redistribute it and/or modify it under the terms   *
;  of the GNU General Public License version 3 as published by the Free Software Foundation. *
;  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY  *
;  without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. *
;  See the GNU General Public License for more details. A copy of the GNU General Public     *
;  License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;                                                                                            *
; ********************************************************************************************
;  Program information                                                                       *
;    Program name: interview                                                                 *
;    Programming languages: One module in C++, One in asm, three txt files                   *
;    Files in this program: interview.asm, main.cpp, chris.txt, csmajor.txt,social.txt       *
;                                                                                            *
; ********************************************************************************************
;  This File                                                                                 *
;     Name:     interview.asm                                                                *
;     Purpose:   displays and accepts the values of salary, comsci major and name            *
;                   Later called on to display offer willing to give by company             *
;                                                                                            *
; ********************************************************************************************

; run with:
; sh r.sh < chris.txt
; sh r.sh < csmajor.txt
; sh r.sh < social.txt


extern printf
extern scanf

global interview

segment .data

stringFormat db "%s", 0            ; Format for strings
floatFormat db "%lf", 0             ; Format for floats

welcome db "Hello %s. I am Ms Fenster. The interview will begin now.", 10, 0                                ; Welcome Message
salary db "Wow! $%1.2lf That's a lot of cash. Who do you think you are, Chris Sawyer (y or n)?", 10, 0      ; Salary Message
circuit db "Alright. Now we will work on your electricity.", 10, 0                                          ; Circuit Test Message

circuit1 db "Please enter the resistance of circuit #1 in ohms: ", 0                                  ; Circuit Question 1
circuit2 db "What is the resistance of circuit #2 in ohms: ", 0                                       ; Circuit Question 2

circuitDone db "The total resistance is %1.3lf Ohms.", 10, 0                                                  ; Resistance message

comsci db "Were you a computer science major (y or n)? ", 0                                          ; Comp Sci Major Question
bye db "Thank you.  Please follow the exit signs to the front desk.", 10, 0                            ; Bye Message

section .bss

segment .text

interview:

;Back up the general purpose registers for the sole purpose of protecting the data of the caller.
push rbp                                                    ;Backup rbp
mov  rbp,rsp                                                ;The base pointer now points to top of stack
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
pushf                                                       ;Backup rflags


push qword -1                                               ;Now the number of pushes is even

;Registers rax, rip, and rsp are usually not backed up.

mov r15, rdi      ; Store name array
movsd xmm15, xmm0 ; Store salary

; Welcome Message =======================================================================================
push qword 0
mov rax, 0
mov rdi, welcome        ;"Hello %s. I am Ms Fenster. The interview will begin now."
mov rsi, r15
call printf
pop rax

; Print out salary message ===================================================================================
push qword 0
mov rax, 1
mov rdi, salary     ;"Wow! $%1.2lf That's a lot of cash. Who do you think you are, Chris Sawyer (y or n)?"
movsd xmm0, xmm15
call printf
pop rax

; Get Question Answer y/n ====================================================================================
push qword 0
mov rdi, stringFormat
mov rsi, rsp
call scanf
pop rax

mov r14, 'y'
cmp rax, r14
jne ResistanceTest          ; If answer is not 'y' go to test

mov rax, 0x412E848000000000   ; Put 1000000 into rax
movq xmm14, rax               ; Put 1000000.00 into xmm14
jmp end                       ; Jump to the end

;========================================================================================================
ResistanceTest:
push qword 0
mov rax, 0
mov rdi, circuit        ;"Alright. Now we will work on your electricity."
call printf
pop rax

;Ask first question==================================================================================
push qword 0
mov rax, 0
mov rdi, circuit1       ;"Please enter the resistance of circuit #1 in ohms: "
call printf
pop rax

;Take the first input and enter it into xmm10 ========================================================
mov rax, 1
mov rdi, floatFormat  ;%lf
push qword 0
mov rsi, rsp
call scanf
movsd xmm10, [rsp]    ;first input float now in xmm10
pop rax

;Ask second question ==================================================================================
push qword 0
mov rax, 0
mov rdi, circuit2     ;"What is the resistance of circuit #2 in ohms:
call printf
pop rax

;Take the second input and enter it into xmm11  =======================================================
mov rax, 1
mov rdi, floatFormat  ;%lf
push qword 0
mov rsi, rsp
call scanf
movsd xmm11, [rsp]  ;second input float now in xmm11
pop rax

;Get the inverse of the resistances ===================================================================
mov r8, 1               ;r8 = 1
cvtsi2sd xmm8, r8       ;xmm8=1
divsd xmm8, xmm10       ; xmm8 = xmm8/xmm10          ex: 1/8
movsd xmm10, xmm8       ; xmm10 = xmm8

cvtsi2sd xmm8, r8   ;xmm8=1
divsd xmm8, xmm11   ;xmm8 = xmm8/xmm11          ex: 1/8
movsd xmm11, xmm8   ;xmm11 = xmm8

; Add the inverse resistances into xmm13 ===============================================================
movsd xmm13, xmm10    ;xmm13 = xmm10
addsd xmm13, xmm11    ;xmm13 = xmm13+xmm11

;Both ohms inverses have been added

; Inverse the result to get the resistance  ==============================================================
mov r8, 1
cvtsi2sd xmm8, r8   ;xmm8 = 1
divsd xmm8, xmm13   ;xmm8 = xmm8/xmm13
movsd xmm13, xmm8   ;xmm13 = xmm8

; Print out circuitDone message =======================================================================
push qword 0
mov rax, 1
mov rdi, circuitDone    ;"The total resistance is %1.3lf Ohms."
movsd xmm0, xmm13
call printf
pop rax

; Ask if CS Major?======================================================================================
push qword 0
mov rax, 0
mov rdi, comsci
call printf
pop rax

; Get Question Answer y/n =============================================================================
push qword 0
mov rdi, stringFormat   ;%s
mov rsi, rsp
call scanf
pop rax

mov r14, 'y'
cmp rax, r14
je csMajor ; If answer is not 'y' go to test

mov rax, 0x4092C07AE147AE14   ; Put 1200.12 into rax
movq xmm14, rax               ; Put 1200.12 into xmm14
jmp end                       ; Jump to the end

csMajor:
mov rax, 0x40F57C0E147AE148   ; Put 88000.88 into rax
movq xmm14, rax               ; Put 88000.88 into xmm14

;===================================================================================================
end:
;Bye Message
push qword 0
mov rax, 0
mov rdi, bye
call printf
pop rax

movsd xmm0, xmm14     ;returns whichever xmm14 it needs

;Restore the original values to the general registers before returning to the caller.
pop rax                                                     ;Remove the extra -1 from the stack
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
