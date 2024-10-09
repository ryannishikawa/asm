#/bin/bash

#Program name "multiplication"
#Author: 
#This file is the script file that accompanies the "multiplication" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.lst
rm mult

echo "Compile the source file ex2_subtraction.asm"
yasm -g dwarf2 -f elf64 multiplication.asm -l mult.lst

echo "Link the object modules to create an executable file"
ld -g -o mult multiplication.o

#execute
ddd mult

echo "This bash script will now terminate."
