#/bin/bash

#Program name "division"
#Author: 
#This file is the script file that accompanies the "division" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.lst

echo "Compile the source file ex2_subtraction.asm"
yasm -g dwarf2 -f elf64 division.asm -l div.lst

echo "Link the object modules to create an executable file"
ld -g -o div division.o

#execute
ddd div

echo "This bash script will now terminate."
