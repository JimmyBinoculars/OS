[org 0x7c00]
mov ah, 0x0e
mov al, [variableName]
int 0x10
jmp $

variableName:
    db "Hello world!", 0

times 510-($-$$) db 0
db 0x55, 0xaa