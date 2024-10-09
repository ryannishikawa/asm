#/bin/bash

#Program name "print"
#Author: 
#This file is the script file that accompanies the "print" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.lst
rm mult

echo "Compile the source file print.asm"
yasm -g dwarf2 -f elf64 print.asm -l print.lst

echo "Link the object modules to create an executable file"
ld -g -o print print.o

#execute
ddd print

echo "This bash script will now terminate."
