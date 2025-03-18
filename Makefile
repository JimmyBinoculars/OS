CC = gcc
LD = ld
OBJCOPY = objcopy
QEMU = qemu-system-x86_64
EFI_INCLUDE = /usr/include/efi
EFI_LIB = /usr/lib
EFI_LDS = $(EFI_LIB)/elf_x86_64_efi.lds
BUILD_DIR = build
OUTPUT = $(BUILD_DIR)/bootloader.efi
IMG = $(BUILD_DIR)/boot.img
MNT_DIR = /mnt/boot

CFLAGS = -I$(EFI_INCLUDE) -I$(EFI_INCLUDE)/x86_64 \
         -fno-stack-protector -fpic -fshort-wchar -mno-red-zone -Wall
LDFLAGS = -nostdlib -znocombreloc -T $(EFI_LDS) -shared -Bsymbolic -L$(EFI_LIB)

all: $(OUTPUT) $(IMG)

install-deps:
	sudo apt-get update
	sudo apt-get install -y gnu-efi ovmf dosfstools

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(OUTPUT): $(BUILD_DIR)/main.o | $(BUILD_DIR)
	$(LD) $(LDFLAGS) -o $@ $^ -lefi -lgnuefi

$(BUILD_DIR)/main.o: /workspaces/OS/bootloader/main.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c -o $@ $<

$(IMG): | $(BUILD_DIR)
	dd if=/dev/zero of=$(IMG) bs=1M count=64
	mkfs.vfat $(IMG)
	sudo mkdir -p $(MNT_DIR)
	sudo mount $(IMG) $(MNT_DIR)
	sudo mkdir -p $(MNT_DIR)/EFI/BOOT
	sudo cp $(OUTPUT) $(MNT_DIR)/EFI/BOOT/BOOTX64.EFI
	sudo umount $(MNT_DIR)

run: all
	$(QEMU) -bios /usr/share/OVMF/OVMF_CODE.fd -drive format=raw,file=$(IMG)

clean:
	rm -rf $(BUILD_DIR)
