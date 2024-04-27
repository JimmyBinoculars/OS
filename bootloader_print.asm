; bootloader_print.asm

; Print string subroutine
print_string:
    lodsb            ; Load next byte from SI into AL
    cmp al, 0        ; Check for null terminator
    je print_done    ; If null terminator, return
    stosw            ; Store AX at ES:DI and increment DI
    jmp print_string ; Repeat for next character
print_done:
    ret