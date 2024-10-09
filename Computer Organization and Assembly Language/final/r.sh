#/bin/bash

#Program name "final"
#Author: 
#This file is the script file that accompanies the "final" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.lst

echo "Compile the source file final.asm"
yasm -g dwarf2 -f elf64 final.asm -l final.lst

echo "Link the object modules to create an executable file"
ld -g -o final final.o

#execute
ddd final

echo "This bash script will now terminate."
