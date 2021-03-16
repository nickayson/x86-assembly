;********************************************************************************************
; Program name:          Sum of Floats - Array                                              *
; Programming Language:  x86 Assembly                                                       *
; Program Description:   This program asks a user to input doubles into an array and        *
;                        returns the sum of doubles in the array.                           *
; Built on: Tuffix 2020
;                                                                                           *
;********************************************************************************************
; Author Information:                                                                       *
; Name:         Nicholas Ayson                                                              *
; Email:        nick.ayson@csu.fullerton.edu                                                *
; Institution:  California State University - Fullerton                                     *
; Course:       CPSC 240-05 Assembly Language                                               *
;                                                                                           *
;********************************************************************************************
; Copyright (C) 2020 Nicholas Ayson                                                         *
; This program is free software: you can redistribute it and/or modify it under the terms   *
; of the GNU General Public License version 3 as published by the Free Software Foundation. *
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY  *
; without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. *
; See the GNU General Public License for more details. A copy of the GNU General Public     *
; License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;                                                                                           *
;********************************************************************************************
; Program information                                                                       *
;   Program name: Sum of Floats - Array                                                     *
;   Programming languages: One module in C, Three modules in X86, One modules in c++        *
;   Files in this program: control.asm, Fill.asm, Sum.asm, main.c, Display.cpp              *
;                                                                                           *
;********************************************************************************************
; This File                                                                                 *
;    Name:      Sum.asm                                                                     *
;    Purpose:   To add all the inputs of the array and send it to the control               *
;                                                                                           *
;********************************************************************************************

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

mov r13, rdi                            ; Copies array that was passed to r15.
mov r14, rsi                            ; Copies number of elements in the array to r14.
mov r15, 0                             ; Counter to to iterate through array.

mov rax, 0
cvtsi2sd xmm8, rax                ;0 in xmm8
;=========================================== Start of Loop ==========================================
begin_loop:	;start of the loop

; Compares the counter (r15) to the number of elements in the array (r14).
cmp r15, r14
jge outofloop

;======================================= Copy into array ===========================================
; Adds element of array at index of r12 to the Sum of register r13.
movsd xmm9, [r13 + 8 * r15]
addsd xmm8, xmm9
inc r15                                ; Increments counter r15 by 1.

; Restarts loop
jmp begin_loop

;======================================= End of loop =================================================
outofloop:
movsd xmm0, xmm8
; Restores all backed up registers to their original state.
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
