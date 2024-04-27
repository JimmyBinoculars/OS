# Compile bootloader.asm
nasm -f bin bootloader.asm -o bootloader.bin

# Compile videoloader.asm
nasm -f bin videoloader.asm -o videoloader.bin

# Combine both parts into the final bootloader binary
cat bootloader.bin videoloader.bin > bootloader_combined.bin

# Compile the kernel
gcc -ffreestanding -c kernel.c -o kernel.o
ld -o kernel.bin -Ttext 0x1000 --oformat binary kernel.o

# Combine bootloader and kernel binaries into disk image
dd if=/dev/zero of=disk.img bs=512 count=2880  # Create an empty disk image (1.44MB)
dd if=bootloader_combined.bin of=disk.img bs=512 count=1 conv=notrunc  # Write bootloader to first sector
dd if=kernel.bin of=disk.img bs=512 seek=2 conv=notrunc  # Write kernel to third sector