#Nicholas Ayson
#CPSC240-1 Test 1
rm *.o
rm *.out

echo "Assemble resistance.asm"
nasm -f elf64 -l resistance.lis -o resistance.o resistance.asm

echo "Compile electricity.c using gcc compiler standard 2011"
gcc -c -Wall -m64 -no-pie -o electricity.o electricity.c -std=c11

echo "Link the object files using the gcc linker standard 2011"
gcc -m64 -no-pie -o a.out electricity.o resistance.o -std=c11

echo "Run the program Resistance"
./a.out

echo "The script file will terminate"
