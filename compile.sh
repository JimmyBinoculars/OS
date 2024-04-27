#!/bin/bash

# Compile the bootloader assembly code
nasm -f bin bootloader.asm -o stage1.bin

# Compile the C kernel
gcc -m32 -ffreestanding -c kernel.c -o kernel.o

# Link the bootloader and the C kernel
ld -m elf_i386 -Ttext 0x100000 --oformat binary kernel.o -o kernel.bin

# Combine the bootloader and the C kernel
cat stage1.bin kernel.bin > bootloader.bin

# Run the combined binary with QEMU
qemu-system-x86_64 -drive format=raw,file=bootloader.bin