nasm -f bin bootloader.asm -o bootloader.bin
gcc -m32 -ffreestanding -c kernel.c -o kernel.o
ld -melf_i386 -o kernel.elf -Ttext 0x1000 kernel.o
objcopy -O binary kernel.elf kernel.bin
dd if=/dev/zero of=disk.img bs=512 count=2880   # Create a 1.44 MB floppy disk image
dd if=bootloader.bin of=disk.img bs=512 count=1 conv=notrunc
dd if=kernel.bin of=disk.img bs=512 seek=2 conv=notrunc