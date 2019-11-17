/*** To compile and run the program, you need to execute the following commnads ***/

	nasm -f elf meheraj_24.asm
	ld -m elf_i386 -s -o arr meheraj_24.o
	./arr



