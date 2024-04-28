# OS
## Building from source
### You can build from source using the compile.sh file

1. Compile the kernel: `i386-elf-gcc -ffreestanding -m32 -g -c "kernel.cpp" -o "kernel.o"`
2. Build the kernel loader: `nasm "kernel_entry.asm" -f elf -o "kernel_entry.o"`
3. Link all kernel scipts: `i386-elf-ld -o "full_kernel.bin" -Ttext 0x1000 "kernel_entry.o" "kernel.o" --oformat binary`
4. Compile bootloader: `nasm "boot.asm" -f bin -o "boot.bin"`
5. Combine kernel and bootloader: `cat "boot.bin" "full_kernel.bin" > "everything.bin"`
6. Make a large bin file: `nasm zeros.asm -f bin -o "zeros.bin"`
7. Combined everything and large bin file: `cat "everything.bin" "zeros.bin" > "OS.bin"`