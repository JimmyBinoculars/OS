bits 16

; Tell NASM that we expect our bootloader to be laoded at this address, hence offsets should be calculated in relation to this address
org 0x7c00

; Define a label X that is a memory offset of the start of our code.
; It points to a character B.
x:
    db "B"

; Move offset of x to bx
mov bx, x

; Add 0x7c00 to bx - it's universally known that BIOS loads bootloaders to this location.
; add bx, 0x7c00

; Move contents of bx to al
mov al, [bx]

; Prepare interrupt to print a character in TTY mode and issue the interrupt
mov ah, 0x0e
int 0x10

times 510 - ($-$$) db 0
dw 0xaa55