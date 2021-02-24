// ;****************************************************************************************************************************
// ;Program name: "root".  This program demonstrates the input of 3 numbers and using them            *
// ;to calculate the roots of a quadratic formula. Copyright (C) 2021 Nicholas Ayson.                                                                           *
// ;                                                                                                                           *
// ;This file is part of the software program "root".                                                                   *
// ;root is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
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
// ;  Program name: root
// ;  Programming languages: Two modules in c++ One modules in C and one module in X86
// ;  Date program began: 2021-Feb-23
// ;  Date of last update: 2021-Feb-28
// ;  Files in this program: Second_degree.c, Quadratic.asm, isfloat.cpp, Quad_library.cpp
// ;
// ;This file
// ;   File name: Second_degree.c
// ;   Language: C.
// ;   Max page width: 58 columns
// ;   Compile: gcc -c -Wall -m64 -no-pie -o Second_degree.o Second_degree.c -std=c11
//     Link:g++ -m64 -fno-pie -no-pie -o a.out -std=c++17 Quad_library.o isfloat.o Second_degree.o Quadratic.o
////
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//


#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>
extern double root();

int main(int argc, char* argv[])
{
  double answer = 0.0;
 printf("Welcome to Root Calculator.\n");
 printf("Programmed by Nicholas Ayson.\n");
 answer = root();
 printf("The main driver received %5.6lf and has decided to keep it.\n", answer);
 printf("Now 0 will be returned to the operating system. Have a nice day. Bye.\n");
 return 0;
}
