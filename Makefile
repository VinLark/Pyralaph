CC = gcc
CCFLAGS = -c -w -masm=intel
ASM = as
LD = ld
LDARCH = elf_i386
LAZM = vram.o shell.o keyboard.o print.o lsd.o str.o


pyralaph.elf : $(LAZM) kernel.o linker.ld boot.elf
	$(LD) -m $(LDARCH) -T linker.ld kernel.o boot.elf $(LAZM) -o pyralaph.elf
	cp pyralaph.elf iso/boot/
	grub-mkrescue -o alif.iso iso
%.o : %.c
	$(CC) $(CCFLAGS) $<
boot.elf : boot.S
	$(ASM) boot.S -o boot.elf
clean: 
	rm *.o *.elf *.iso iso/boot/*.elf
