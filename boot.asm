; Bootloader

;Define origin
ORG 0x7C00

;Entry point
start:
    ;Clear interrupts
    cli

    ;Setup data segments