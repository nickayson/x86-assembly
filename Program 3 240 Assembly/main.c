//********************************************************************************************
//Program name:          Sum of Floats - Array                                              *
//Programming Language:  x86 Assembly                                                       *
//Program Description:   This program asks a user to input doubles into an array and        *
//                       returns the sum of doubles in the array.                           *
// Built on: Tuffix 2020
//                                                                                            *
// ********************************************************************************************
//  Author Information:                                                                       *
//  Name:         Nicholas Ayson                                                              *
//  Email:        nick.ayson@csu.fullerton.edu                                                *
//  Institution:  California State University - Fullerton                                     *
//  Course:       CPSC 240-05 Assembly Language                                               *
//                                                                                            *
// ********************************************************************************************
//  Copyright (C) 2020 Nicholas Ayson                                                         *
//  This program is free software: you can redistribute it and/or modify it under the terms   *
//  of the GNU General Public License version 3 as published by the Free Software Foundation. *
//  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY  *
//  without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. *
//  See the GNU General Public License for more details. A copy of the GNU General Public     *
//  License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//                                                                                            *
// ********************************************************************************************
//  Program information                                                                       *
//    Program name: Sum of Floats - Array                                                     *
//    Programming languages: One module in C, Three modules in X86, One modules in c++        *
//    Files in this program: control.asm, Fill.asm, Sum.asm, main.c, Display.cpp              *
//                                                                                            *
// ********************************************************************************************
//  This File                                                                                 *
//     Name:      main.c                                                                      *
//     Purpose:   Prints the welcome message and calls on control to produce a value          *
//                                                                                            *
// ********************************************************************************************
#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>
extern double control();

int main(int argc, char* argv[])
{
  double answer = 0.0;
  //Beginnning statements
 printf("Welcome to High Speed Array Summation by Nicholas Ayson.\n");
 printf("Software Licensed by GNU GPL 3.0\n");
 printf("Version 1.0 released on January 28, 2021.\n");
 answer = control();	//gets answer from control
 //ending statements
 printf("The main driver received %5.8lf and has decided to keep it.\n", answer);
 printf("Thank you for using High Speed Array Software.\n");
 printf("For system support contact Nicholas Ayson at nick.ayson@csu.fullerton.edu.\n");
 printf("A zero will be returned to the operating system.\n");
 return 0;
}
