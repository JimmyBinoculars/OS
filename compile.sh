nasm -f bin bootloader.asm -o bootloader.bin
gcc -ffreestanding -c kernel.c -o kernel.o
ld -o kernel.bin -Ttext 0x1000 --oformat binary kernel.o
dd if=bootloader.bin of=disk.img bs=512 count=1 conv=notrunc
dd if=kernel.bin of=disk.img bs=512 seek=2 conv=notrunc