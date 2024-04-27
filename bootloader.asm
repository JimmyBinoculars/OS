bits 16

section .text
    global _start

_start:
    ; Set up stack pointer
    mov ax, 0x9000
    mov ss, ax
    mov sp, 0xFFFF

    ; Load second stage bootloader
    mov ah, 0x02          ; BIOS function: Read sectors
    mov al, 1             ; Read one sector
    mov dl, 0x00          ; Drive number (usually 0 for floppy, 80h for hard drive)
    mov ch, 0             ; Cylinder number
    mov dh, 0             ; Head number
    mov cl, 2             ; Sector number (second sector of the disk)
    mov bx, 0x8000        ; Buffer address where to read the sector
    int 0x13              ; BIOS interrupt

    ; Jump to the second stage bootloader
    jmp 0x8000

    ; Padding and magic number
    times 510-($-$$) db 0
    dw 0xAA55