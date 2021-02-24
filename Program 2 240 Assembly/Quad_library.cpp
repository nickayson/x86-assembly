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
// ;   File name: Quad_library.cpp
// ;   Language: c++
// ;   Max page width: 58 columns
// ;   Compile: g++ -c -m64 -Wall -fno-pie -no-pie -o Quad_library.o Quad_library.cpp -std=c++17
//     Link:g++ -m64 -fno-pie -no-pie -o a.out -std=c++17 Quad_library.o isfloat.o Second_degree.o Quadratic.o
////
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//

#include <iostream>
#include <cstring>
extern "C" void show_no_root();
extern "C" void show_one_root(double root);
extern "C" void show_two_root(double root1, double root2);
void show_no_root()
{
  std::cout << "There is no possible root." << std::endl;
}
void show_one_root(double root)
{
  std::cout << "The one root is " << root << std::endl;
}
void show_two_root(double root1, double root2)
{
  std::cout << "The two roots are " << root1 << " and " << root2 << std::endl;
}
