BITS 16

start:
    ; Set up segment registers
    xor ax, ax
    mov ds, ax
    mov es, ax

    ; Load kernel into memory
    mov bx, KERNEL_OFFSET    ; Memory address where kernel will be loaded
    mov ah, 02h              ; BIOS read sector function
    mov al, 1                ; Read one sector
    mov ch, 0                ; Cylinder number
    mov cl, 2                ; Sector number
    mov dh, 0                ; Head number
    mov dl, 0                ; Drive number (usually floppy disk or hard disk)
    int 13h                  ; Call BIOS interrupt for disk I/O

    ; Jump to the kernel
    jmp KERNEL_OFFSET:0

KERNEL_OFFSET equ 0x1000    ; Adjust this according to where you want to load the kernel
