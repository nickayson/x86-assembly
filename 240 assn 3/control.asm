;********************************************************************************************
;Program name:          Sum of Floats - Array                                              *
;Programming Language:  x86 Assembly                                                       *
;Program Description:   This program asks a user to input doubles into an array and        *
;                       returns the sum of doubles in the array.                           *
;Built on: Tuffix 2020
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
; License v3 is available here:  <https://www.gnu.org/licenses/>.
;
;********************************************************************************************
; Program information                                                                       *
;   Program name: Sum of Floats - Array                                                     *
; Programming languages: One module in C, Three modules in X86, One modules in c++
;   Files in this program: control.asm, Fill.asm, Sum.asm, main.c, Display.cpp              *
;                                                                                           *
;********************************************************************************************
; This File                                                                                 *
;    Name:     control.asm                                                                  *
;    Purpose:   Manages all the files in the program and calls fill, sum and Display as needed*
;                                                                                           *
;******************************************************************************************

max_array_size equ 20                         ;max array size is 20 so numbers cannot be more than 20
                                              ;if entered more will still print out numbers up to the 20th float number and no more

global control

extern printf

extern fill

extern display_array

extern sum

segment .data
welcome db "Welcome to HSAS. The accuracy and reliability of this program is guaranteed by Nicholas Ayson.",10,0

get_data db "The numbers you entered are these: ",10,0

sum_info db "The sum of these values is %5.8lf",10,0

good_bye db "The control module will now return the sum to the caller module.", 10, 0


segment .bss

standard_array resq 20                     ; max array size is 20 so numbers cannot be more than 20

segment .text

control:

;====================================================================================================
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
pushf                                                       ;Backup rflags


;Display a welcome message to the viewer.
mov rax, 0
mov rdi, welcome               ;"Welcome to HSAS. The accuracy and reliability of this program is guaranteed by Nicholas Ayson."
call printf
;==================================================Filling the array========================================

;Begin preparation for calling input_array
mov rax,0
mov rdi, standard_array
mov rsi, max_array_size
call fill
;Save the returned integer in a stable register
mov r13, rax

;================================================Array Update==================================================

push qword 0
mov rax, 0
mov rdi, get_data       ;"The numbers you entered are these: "
call printf
pop rax

;==============================================Display numbers in the array=====================================

;Begin preparation for calling output_array
mov rax, 0
mov rdi, standard_array
mov rsi, r13             ;rsi receives the count of doubles in the array standard_array
call display_array

;====================================== Calling Sum ============================================
;Set up for the Sum function
mov rax,0
mov rdi, standard_array
mov rsi,r13
call sum
movsd xmm15,xmm0                    ;An extra copy of the product number is kept in xmm15

;Show the sum
mov rax,1
mov rdi,sum_info
movsd xmm0,xmm15
call printf

;==================================== Good bye ================================================

;Set up the good bye message
mov rax, 0
mov rdi, good_bye
call printf

;Send the product number to the caller of this function
movsd xmm0, xmm15

;===== Restore original values to integer registers ===============================================================================
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
