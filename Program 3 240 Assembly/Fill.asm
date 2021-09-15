;********************************************************************************************
; Program name:          Sum of Floats - Array                                              *
; Programming Language:  x86 Assembly                                                       *
; Program Description:   This program asks a user to input doubles into an array and        *
;                       returns the sum of doubles in the array.                            *
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
;    Program name: Sum of Floats - Array                                                     *
;    Programming languages: One module in C, Three modules in X86, One modules in c++        *
;    Files in this program: control.asm, Fill.asm, Sum.asm, main.c, Display.cpp              *
;                                                                                            *
; ********************************************************************************************
;  This File                                                                                 *
;     Name:     Fill.asm                                                                     *
;     Purpose:   accept user input of floats and save it to an array.                        *
;                   Later called on to display                                               *
;                                                                                            *
; ********************************************************************************************


extern printf
extern scanf

global fill

segment .data

prompt1 db "Please enter floating point numbers separated by ws.",10,
        db "When finished press enter followed by cntl+D.",10,0

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

;Back up the incoming data
mov r13, rdi         ;r13 is the array
mov r14, rsi         ;r14 is the max number allowed in the array
mov r15, 0           ;r15 is the loop counter and the index into the array

;print the input prompt
mov rax, 0
mov rdi, prompt1
call printf


begin_loop:		;start loop

;Input a float number
mov rax,0
mov rdi,floatformat
push qword 0
mov rsi, rsp
call scanf

;Check for possible cntl+D
cdqe      ;signal in rax
cmp rax,-1
je outofloop
pop rax

mov [r13+8*r15],rax
inc r15

cmp r15, r14            ;Check for array may be full.
jge exit		;if r15 is equal to r14 jump to exit

jmp begin_loop		;jump to the beginning of the loop

outofloop:		;out of the loop
pop rax

;Return the number of values entered into the array
exit:
pop rax
mov rax, r15

;===========================Exit==========================================================================

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
