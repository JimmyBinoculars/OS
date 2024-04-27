#!/bin/bash

# Assemble stage1.asm
nasm -f bin -o stage1.bin stage1.asm

# Assemble stage2.asm
nasm -f elf32 -o stage2.o stage2.asm

# Compile kernel.c
gcc -m32 -ffreestanding -c -o kernel.o kernel.c -fno-pic

# Link stage2 and kernel to create kernel.bin
ld -m elf_i386 -Ttext 0x10000 -o kernel.bin stage2.o kernel.o --oformat binary

# Combine stage1 and kernel.bin to create final image
cat stage1.bin kernel.bin > os_image.bin

echo "Compilation successful!"
