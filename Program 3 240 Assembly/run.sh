#program: Sum of Floats-Array
#Author Nicholas Ayson




#Delete some un-needed files
rm *.o
rm *.out
rm *.lis

#echo "Compile Display.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -o Display.o Display.cpp -std=c++17

#echo "Compile main.c"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11

#echo "Assemble control.asm"
nasm -f elf64 -l control.lis -o control.o control.asm

#echo "Assemble Fill.asm"
nasm -f elf64 -l Fill.lis -o Fill.o Fill.asm

#echo "Assemble Sum.asm"
nasm -f elf64 -l Sum.lis -o Sum.o Sum.asm

#echo "Link the object files"
gcc -m64 -no-pie -o array.out -std=c11 main.o Fill.o Sum.o Display.o control.o

#echo "Run the program Sorting Array Example:"
./array.out
