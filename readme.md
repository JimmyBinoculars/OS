# OS
## Building from source
1. Build kernel.c into kernel.o: `gcc -ffreestanding -c kernel.c -o kernel.o`
2. Build bootloader.asm into bootloader.bin: `nasm -f bin bootloader.asm -o bootloader.bin`
3. Add linker to kernel: `ld -o kernel.bin -T linker.ld kernel.o`
4. Combine bootloader and kernel`cat bootloader.bin kernel.bin > os-image`