#!/bin/bash

#Program: Perimeter
#Author: Nicholas Ayson

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble Quadratic.asm"
nasm -f elf64 -l Quadratic.lis -o Quadratic.o Quadratic.asm

echo "Compile Quad_library.cpp using g++ compiler standard 2011"
g++ -c -m64 -Wall -fno-pie -no-pie -o Quad_library.o Quad_library.cpp -std=c++17

echo "Compile isfloat.cpp using g++ compiler standard 2011"
g++ -c -m64 -Wall -fno-pie -no-pie -o isfloat.o isfloat.cpp -std=c++17

echo "Compile Second_degree.c using gcc compiler standard 2011"
gcc -c -Wall -m64 -no-pie -o Second_degree.o Second_degree.c -std=c11

echo "Link the object files using the gcc linker standard 2011"
g++ -m64 -fno-pie -no-pie -o a.out -std=c++17 Quad_library.o isfloat.o Second_degree.o Quadratic.o

echo "Run the program root"
./a.out

echo "The script file will terminate"
