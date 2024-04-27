global _start

section .text
_start:
    ; Set up stack
    xor     ax, ax
    mov     ss, ax
    mov     sp, 0x7c00

    ; Load stage 2 from disk to memory
    mov     bx, 0x8000  ; Destination address in memory
    mov     dh, 15      ; Head number
    mov     dl, 0       ; Drive number (first floppy)
    mov     ch, 0       ; Cylinder number
    mov     cl, 2       ; Sector number (first sector after boot sector)
    mov     ah, 2       ; Read sector function
    mov     al, 1       ; Number of sectors to read
    int     13h         ; BIOS interrupt

    ; Jump to stage 2
    jmp     0x8000

    ; Padding and magic number
    times 510-($-$$) db 0
    db 0x55
    db 0xAA