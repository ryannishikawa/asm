#/bin/bash

#Program name "input"
#Author: 
#This file is the script file that accompanies the "input" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.lst
rm mult

echo "Compile the source file input.asm"
yasm -g dwarf2 -f elf64 input.asm -l input.lst

echo "Link the object modules to create an executable file"
ld -g -o input input.o

#execute
ddd input

echo "This bash script will now terminate."
