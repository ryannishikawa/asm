#/bin/bash

#Program name "calc"
#Author: 
#This file is the script file that accompanies the "calc" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.lst

echo "Compile the source file calc.asm"
yasm -g dwarf2 -f elf64 calc.asm -l calc.lst

echo "Link the object modules to create an executable file"
ld -g -o calc calc.o

#execute
ddd calc

echo "This bash script will now terminate."
