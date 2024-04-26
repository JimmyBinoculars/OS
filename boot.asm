; Bootloader

;Define origin
ORG 0x7C00

;Entry point
start:
    ;Clear interrupts
    cli

    ;Setup data segments
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ;Setup stack
    mov ss, ax
    mov sp, 0x7C00

    ;Load kernel
    mov bx, 0x8000
    mov dh, 15  ; Number of sectors to load
    mov dl, 0x80 ; Drive number (0x80 for first hard disk)
    mov ah, 0x02 ; Read disk sectors function
    mov al, dh   ; Number of sectors to read
    mov ch, 0x00 ; Cylinder number
    mov cl, 0x02 ; Sector number
    int 0x13     ; BIOS interrupt

    ;Jump to kernel
    jmp 0x8000

;Fill remaning bytes to reach 512
times 510 - ($ - start) db 0
dw 0xAA55 ; Boot signature