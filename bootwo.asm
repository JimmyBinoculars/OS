bits 16

section .text
    global _start

_start:
    ; Set up stack pointer
    mov ax, 0x9000
    mov ss, ax
    mov sp, 0xFFFF

    ; Load kernel
    mov ah, 0x02          ; BIOS function: Read sectors
    mov al, 5             ; Read five sectors
    mov dl, 0x00          ; Drive number (usually 0 for floppy, 80h for hard drive)
    mov ch, 0             ; Cylinder number
    mov dh, 0             ; Head number
    mov cl, 3             ; Sector number (third sector of the disk)
    mov bx, 0x10000       ; Buffer address where to read the sectors
    int 0x13              ; BIOS interrupt

    ; Jump to the kernel
    jmp 0x10000
