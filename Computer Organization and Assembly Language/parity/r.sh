#/bin/bash

#Program name "parity"
#Author: 
#This file is the script file that accompanies the "parity" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.lst
rm mult

echo "Compile the source file parity.asm"
yasm -g dwarf2 -f elf64 parity.asm -l par.lst

echo "Link the object modules to create an executable file"
ld -g -o par parity.o

#execute
ddd par

echo "This bash script will now terminate."
