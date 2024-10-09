#/bin/bash

#Program name "function"
#Author: 
#This file is the script file that accompanies the "function" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.lst

echo "Compile the source file function.asm"
yasm -g dwarf2 -f elf64 function.asm -l function.lst

echo "Link the object modules to create an executable file"
ld -g -o function function.o

#execute
ddd function

echo "This bash script will now terminate."
