bits 32

section .text
    global _start

_start:
    ; Set up protected mode
    cli                     ; Disable interrupts
    lgdt [gdt_descriptor]   ; Load GDT
    mov eax, cr0            ; Get control register 0
    or eax, 0x1             ; Set the PE bit
    mov cr0, eax            ; Write back to CR0
    jmp 0x08:init_pm        ; Jump to 32-bit code segment

init_pm:
    mov ax, 0x10            ; Set up data segments
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x90000        ; Set up stack pointer

    ; Call the C kernel
    call 0x10000

    ; Infinite loop
    cli
.hang:
    hlt
    jmp .hang

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

gdt_start:
    ; Null segment
    dd 0x00000000
    dd 0x00000000

    ; Code segment
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 0x9A
    db 0xCF
    db 0x00

    ; Data segment
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 0x92
    db 0xCF
    db 0x00

gdt_end: