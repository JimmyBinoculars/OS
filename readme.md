# OS
## Building from source
1. Build kernel.c into kernel.o: `gcc -ffreestanding -c kernel.c -o kernel.o`
2. Build bootloader.asm into bootloader.bin: `nasm -f bin bootloader.asm -o bootloader.bin`
3. Add linker to kernel: `ld -o kernel.bin -T linker.ld kernel.o`
4. Combine bootloader and kernel`cat bootloader.bin kernel.bin > os-image`
5. Create bootable disk:
```sh
dd if=/dev/zero of=floppy.img bs=512 count=2880
dd if=os-image of=floppy.img conv=notrunc
```
6. Run kernel: `qemu-system-x86_64 -fda floppy.img`.