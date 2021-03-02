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
extern isfloat
extern atof
extern show_no_root
extern show_one_root
extern show_two_root
global root

segment .data

invalid db "Invalid input data detected. You may run this program again" ,10 ,0

welcome db "This program will find the roots of any quadratic equation",10,0

prompt1 db "Please enter the three floating point coefficients of a quadratic equation in the order a, b ,c. ",0

string db "%s%s%s", 0
equationprompt db "Thank you the equation is %5.20lf x^2 + %5.20lf x + %5.20lf = 0.0",10, 0

good_bye1 db "One of these roots will be returned to the caller function.",10,0


segment .bss

segment .text

root:

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
push qword 0
mov rax, 0
mov rdi, welcome
call printf
pop rax


;============= Begin section to input 3 numbers========================================================
;Display a prompt message asking for inputs
push qword 0
mov rax, 0
mov rdi, prompt1        ;Please enter the three floating point coefficients of a quadratic equation in the order a, b, c
call printf
pop rax

sub rsp, 1560
;scanf block
mov rax, 0
mov rdi, string       ;"%s%s%s"
mov rsi, rsp
mov rdx, rsp
add rdx, 520
mov rcx, rsp
add rcx, 1040
call scanf

;everything works need to figure out how to implement isfloat
mov rax, 0
mov rdi, rsp
call isfloat      ;answer is in rax

cmp rax, 0
jmp valid
je invalidmes       ;strangely won't output regular floats if invalid is put in front

valid:
mov rdi, rsp
call atof
movsd xmm15, xmm0

mov rdi, rsp
add rdi, 520
call atof
movsd xmm14, xmm0

mov rdi , rsp
add rdi, 1040
call atof
movsd xmm13, xmm0

add rsp, 1560
jmp over

invalidmes:
push qword 0
mov rax, 0
mov rdi, invalid
call printf
pop rax
add rsp, 1560
jmp exit



over:
;display the numbers
push qword 99
mov rax, 3
mov rdi, equationprompt
movsd xmm0, xmm15
movsd xmm1, xmm14
movsd xmm2, xmm13
call printf
pop rax


;============= End of section to input 3 numbers ===============================================================

;=============Begin section finding roots ==================================================
push qword 0
mov rax, 0

push qword 4
cvtsi2sd xmm12, [rsp]
pop rax

push qword 2
cvtsi2sd xmm11, [rsp]
pop rax

push qword 0
cvtsi2sd xmm10, [rsp]
pop rax

push qword -1
cvtsi2sd xmm6, [rsp]
pop rax

movsd xmm8, xmm14         ; backup of original xmm14
movsd xmm7, xmm14         ; backup of xmm14
mulsd xmm14, xmm14        ;xmm14 = xmm14 *xmm14 = b^2
mulsd xmm12, xmm15        ;xmm12=4*xmm13
mulsd xmm12, xmm13        ;4*a*c
subsd xmm14, xmm12       ;b^2-4ac
sqrtsd xmm14, xmm0
movsd xmm9, xmm14         ;xmm9 == b^2-4ac


;1st root
mulsd xmm8, xmm6    ;b*-1
subsd xmm8, xmm9      ;-b - b^2-4ac
mulsd xmm11, xmm15   ;2a
divsd xmm8, xmm11     ;-b - b^2-4ac/2a
movsd xmm15, xmm8     ;xmm15 =-b - b^2-4ac/2a

;second root
mulsd xmm7, xmm6    ;-b
addsd xmm7, xmm14   ;-b + b^2-4ac
divsd xmm7, xmm11   ; -b + b^2-4ac/2a

pop rax

ucomisd xmm14, xmm10
ja tworoot
je oneroot
jb noroot

tworoot:
  push qword 0
  mov rax, 2
  movsd xmm0, xmm8
  movsd xmm1, xmm7
  call show_two_root
  pop rax
  jmp exit

oneroot:
  push qword 0
  mov rax, 1
  movsd xmm0, xmm8
  call show_one_root
  pop rax
  jmp exit

noroot:
  push qword 0
  call show_no_root
  pop rax
  jmp exit


;============= Prepare to exit from this program ======================================================================

exit:

;Display good-bye message
push qword 0
mov rax, 0
mov rdi, good_bye1
call printf
pop rax

pop rax     ;to 1st push

movsd xmm0, xmm15          ;perimeter value to return to the main

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
