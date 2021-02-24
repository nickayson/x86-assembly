;****************************************************************************************************************************
;Program name: "Perimeter".  This program demonstrates the input of hight and width float numbers and using them            *
;to calculate the perimeter and average side length. Copyright (C) 2021 Nicholas Ayson.                                                                           *
;                                                                                                                           *
;This file is part of the software program "Perimeter".                                                                   *
;Perimeter is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                    *
;Perimeter is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
;****************************************************************************************************************************




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Nicholas Ayson
;  Author email: nick.ayson@csu.fullerton.edu
;
;Program information
;  Program name: Perimeter
;  Programming languages: One modules in C and one module in X86
;  Date program began: 2021-Jan-31
;  Date of last update: 2021-Feb-2
;  Files in this program: rectangle.c, perimeter.asm
;  Status: Finished.  The program was tested extensively with no errors in Xubuntu19.04.
;
;This file
;   File name: perimeter.asm
;   Language: X86 with Intel syntax.
;   Max page width: 187 columns
;   Assemble: nasm -f elf64 -l perimeter.lis -o perimeter.o perimeter.asm

extern printf
extern scanf
global rectangle

segment .data

welcome db "This program will compute the perimeter and the average side length of a rectangle.",10,0

input1prompt db "Enter the height: ",0
input2prompt db "Enter the witdth: ",0

one_float_format db "%lf",0
two_float_format db "%lf",0
perimeterprompt db "The perimeter is %5.3lf", 10, 0
lengthprompt db "The length of the average side is %5.3lf", 10, 0

good_bye1 db "I hope you enjoyed your rectangle",10,0


segment .bss

segment .text

rectangle: 

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


;Display a welcome message to the viewer.
mov rax, 0
mov rdi, welcome      ;This program will compute the perimeter and the average side length of a rectangle.
call printf

;============= Begin section to input height========================================================
;Display a prompt message asking for inputs
push qword 0
mov rax, 0
mov rdi, input1prompt
call printf
pop rax

;Begin the scanf block
push qword 0
mov rax, 0
mov rdi,one_float_format
mov rsi, rsp
call scanf
movsd xmm15, [rsp]
pop rax
;============= End of section to input height ===============================================================

;============= Begin section to input width==================================
;Display a prompt message asking for inputs
push qword 0
mov rax, 0
mov rdi, input2prompt
call printf
pop rax


;Begin the scanf block
mov rax, 0
mov rdi,two_float_format
push qword 0
mov rsi, rsp
call scanf
movsd xmm14,[rsp]
pop rax
;============= End of section to input width ==============================================================

;Perimeter block begins here
;=============================================================

push qword 0
mov rax, 1
mov rdi, perimeterprompt          ;The perimeter is %5.3lf
addsd xmm14, xmm14
addsd xmm15, xmm15
addsd xmm14, xmm15                ;perimeter now set at xmm14
movsd xmm0, xmm14
call printf
pop rax

;==========End of perimeter block===========================

;========== Average side length block =====================
push qword 0
mov rax, 1
mov rdi, lengthprompt         ;The length of the average side is %5.3lf

push qword 4
cvtsi2sd xmm13, [rsp]
pop rax

divsd xmm14, xmm13            ;xmm14 now divided by 4
movsd xmm0, xmm14
call printf
pop rax
;==========  End of Average side length block =====================

;============= Prepare to exit from this program ======================================================================

;Display good-bye message
mov rax, 0
mov rdi, good_bye1
call printf

pop rax     ;to 1st push

mulsd xmm14, xmm13              ;gets xmm14 back to perimeter value
movsd xmm0, xmm14               ;perimeter value to return to the main

;===== Restore original values to integer registers ===================================================================
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
