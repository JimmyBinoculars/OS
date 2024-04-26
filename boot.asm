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
    