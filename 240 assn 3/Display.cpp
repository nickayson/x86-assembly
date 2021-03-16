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
//     Name:      Display.cpp                                                                 *
//     Purpose:   To print out all the integers in the array seperated by a space             *
//                                                                                            *
// ********************************************************************************************

#include <stdio.h>

extern "C" void display_array(double array[], long index);

void display_array(double array[], long index)
{
  for(long i = 0; i < index; i++)
  {
    printf("%5.8lf", array[i]);
    printf("%s", " ");        //print out numbers seperated by a space
  }
  printf("\n");       //returning these new lines but not inside array
}
