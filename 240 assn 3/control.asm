 ;****************************************************************************************************************************
 ;Program name: "root".  This program demonstrates the input of 3 numbers and using them            *
 ;to calculate the roots of a quadratic formula. Copyright (C) 2021 Nicholas Ayson.                                                                           *
 ;                                                                                                                           *
 ;This file is part of the software program "root".                                                                   *
 ;root is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
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
 ;  Program name: root
 ;  Programming languages: Two modules in c++ One modules in C and one module in X86
 ;  Date program began: 2021-Feb-23
;  Date of last update: 2021-Feb-28
;  Files in this program: Second_degree.c, Quadratic.asm, isfloat.cpp, Quad_library.cpp
 ;
;This file
 ;   File name: Quadratic.asm
 ;   Language: x86 assembly
 ;   Max page width: 304 columns
 ;   Assemble: nasm -f elf64 -l Quadratic.lis -o Quadratic.o Quadratic.asm
;   Link:g++ -m64 -fno-pie -no-pie -o a.out -std=c++17 Quad_library.o isfloat.o Second_degree.o Quadratic.o

;=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**



extern printf
extern scanf
extern fill
extern display_array
extern sum

array_size equ 100        ; capacity limited to 100 in array

global control

segment .data

floatformat db "%lf", 0
stringformat db "%s", 0

welcome db "Welcome to HSAS. The accuracy and reliability of this program is guaranteed by Nicholas Ayson.",10,0

prompt1 db "The numbers you entered are these: ",10,0

sumvalue db "The sum of these values is %5.8lf",10,0

controlexit db "The control module will now return the sum to the caller module.", 10, 0



segment .bss

intarray: resq 100

segment .text

control:

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

;========================================Initialize=================================================================
mov r14, 0                    ;register for number of elements in array
mov r13, 0                    ;register for sum of floats in array
;========================================================================================================================

;Display welcome message
push qword 0
mov rax, 0
mov rdi, welcome            ;"Welcome to HSAS. The accuracy and reliability of this program is guaranteed by Nicholas Ayson."
call printf
pop rax

;========================================Function call to fill============================================================

push qword 0
mov rdi, intarray
mov rsi, array_size
mov rax, 0
call fill
mov r14, rax          ; saves copy of fill array into r14
pop rax

;========================================Confirmation of inputs=====================================================

push qword 0
mov rdi, stringformat   ; change to float does not display
mov rsi, prompt1        ;"The numbers you entered are these: "
mov rax, 0
call printf
pop rax

;========================================Display array=============================================================

push qword 0
mov rdi, intarray
mov rsi, r14                            ;passes number of elements in array stored in r14
mov rax, 0
call display_array                        ;calls display
pop rax

;================================================Call Sum================================================================

 push qword 0
 mov rdi, intarray
 mov rsi, r14             ;passes number of elements in the array in r14
 mov rax, 0
 call sum                 ; call sum to add all floats in array
 mov r13, rax           ;saves copy of sum functions output into r13
 pop rax

;=================================================Prints out Sum======================================================

push qword 0
mov rdi, sumvalue
mov rdx, r13
mov rax, 0
call printf
pop rax

;=======================================================================================================================

push qword 0
mov rax, 0
mov rdi, controlexit
call printf
pop rax

pop rax
mov rax, r13      ; copies sum r13 to rax


exit:
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
