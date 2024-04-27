; bootloader.asm

ORG 0x7C00

start:
    cli

    xor ax, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ss, ax
    mov sp, 0x7C00

    ; Load the kernel into memory
    mov bx, 0x8000      ; Load address in memory where the kernel will be loaded
    mov dh, 15          ; Number of sectors to load
    mov dl, 0x80        ; Drive number (0x80 for first hard disk)
    mov ah, 0x02        ; Read disk sectors function
    mov al, dh          ; Number of sectors to read
    mov ch, 0x00        ; Cylinder number
    mov cl, 0x02        ; Sector number
    int 0x13            ; BIOS interrupt

    ; Jump to the kernel
    jmp 0x8000

times 510 - ($ - start) db 0
dw 0xAA55