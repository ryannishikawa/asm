#/bin/bash

#Program name "subtraction"
#Author: 
#This file is the script file that accompanies the "subtraction" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.lst

echo "Compile the source file subtraction.asm"
yasm -g dwarf2 -f elf64 addition.asm -l addition.lst

echo "Link the object modules to create an executable file"
ld -g -o add addition.o

#execute
ddd add

echo "This bash script will now terminate."
