#/bin/bash

#Program name "hello"
#Author: 
#This file is the script file that accompanies the "hello" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.lst

echo "Compile the source file ex2_subtraction.asm"
yasm -g dwarf2 -f elf64 hello.asm -l hello.lst

echo "Link the object modules to create an executable file"
ld -g -o hello hello.o

#execute
ddd hello

echo "This bash script will now terminate."
