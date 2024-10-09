#/bin/bash

#Program name "q2"
#Author: 
#This file is the script file that accompanies the "q1" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.lst

echo "Compile the source file q1_prac.asm"
yasm -g dwarf2 -f elf64 quiz2.asm

echo "Link the object modules to create an executable file"
ld -g -o q2 quiz2.o

#execute
ddd q2

echo "This bash script will now terminate."
