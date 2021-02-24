// ;****************************************************************************************************************************
// ;Program name: "Perimeter".  This program demonstrates the input of hight and width float numbers and using them            *
// ;to calculate the perimeter and average side length. Copyright (C) 2021 Nicholas Ayson.                                                                           *
// ;                                                                                                                           *
// ;This file is part of the software program "Perimeter".                                                                   *
// ;Perimeter is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
// ;version 3 as published by the Free Software Foundation.                                                                    *
// ;Perimeter is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
// ;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
// ;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
// ;****************************************************************************************************************************
//
//
//
//
// ;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
// ;
// ;Author information
// ;  Author name: Nicholas Ayson
// ;  Author email: nick.ayson@csu.fullerton.edu
// ;
// ;Program information
// ;  Program name: Perimeter
// ;  Programming languages: One modules in C and one module in X86
// ;  Date program began: 2021-Jan-31
// ;  Date of last update: 2021-Feb-2
// ;  Files in this program: rectangle.c, perimeter.asm
// ;  Status: Finished.  The program was tested extensively with no errors in Xubuntu19.04.
// ;
// ;This file
// ;   File name: rectangle.c
// ;   Language: C.
// ;   Max page width: 54 columns
// ;   Compile: gcc -c -Wall -m64 -no-pie -o rectangle.o rectangle.c -std=c11
//     Link:gcc -m64 -no-pie -o area.out rectangle.o perimeter.o -std=c11
////
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//
//===== Begin code area ===========================================================================================================
#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>
extern double rectangle();

int main(int argc, char* argv[])
{
  double answer = 0.0;
 printf("Welcome to an friendly assembly program by Nicholas Ayson.\n");
 answer = rectangle();
 printf("The assembly program will send the perimeter to the main function.\n");
 printf("The main function received this number %5.3lf and has decided to keep it.\n", answer);
 printf("A 0 will be returned to the operating system.\n");
 printf("Have a nice day.\n");
 return 0;
}
