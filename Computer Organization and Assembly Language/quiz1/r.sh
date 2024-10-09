#/bin/bash

#Program name "q1[real]"
#Author: 
#This file is the script file that accompanies the "q1[real]" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.lst

echo "Compile the source file q1_prac.asm"
yasm -g dwarf2 -f elf64 quiz1[real].asm -l q1_prac.lst

echo "Link the object modules to create an executable file"
ld -g -o q1 quiz1[real].o

#execute
ddd q1

echo "This bash script will now terminate."
