#/bin/bash

#Program name "macro"
#Author: 
#This file is the script file that accompanies the "macro" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.lst

echo "Compile the source file macro.asm"
yasm -g dwarf2 -f elf64 macro.asm -l macro.lst

echo "Link the object modules to create an executable file"
ld -g -o macro macro.o

#execute
ddd macro

echo "This bash script will now terminate."
