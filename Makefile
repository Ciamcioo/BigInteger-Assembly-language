all:  program.s program.o
	as --32 -o program.o program.s 
	ld -m elf_i386 -o program program.o
build:	program.s
	as --32 -o program.o program.s 
link: program.o
	ld -m elf_i386 -o program program.o
run: program 
	./program
clean:
	rm -f *.o  program
