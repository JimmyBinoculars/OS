; Stage 1 Bootloader (16-bit)
BITS 16
ORG 0x7C00

start:
    ; Set up segments
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00  ; Set stack pointer

    ; Load stage 2 bootloader
    mov bx, 0x8000  ; Load stage 2 bootloader at 0x8000
    mov ah, 0x02    ; BIOS function to read sectors
    mov al, 1       ; Read 1 sector
    mov ch, 0x00    ; Cylinder number
    mov cl, 0x02    ; Sector number
    mov dh, 0x00    ; Head number
    int 0x13        ; BIOS interrupt

    ; Jump to stage 2 bootloader
    jmp 0x8000

; Stage 2 Bootloader (32-bit)
BITS 32
ORG 0x8000

start:
    ; Set up segments
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov esp, 0x90000  ; Set stack pointer

    ; Switch to 64-bit long mode
    cli             ; Disable interrupts
    lgdt [gdt_ptr]  ; Load GDT
    mov eax, cr0
    or eax, 0x1     ; Set PE bit to enable protected mode
    mov cr0, eax
    jmp CODE_SEG:start64 ; Jump to 64-bit code segment

gdt_start:
    dq 0x0
    dq 0x0

; 64-bit code segment descriptor
gdt_code:
    dw 0xFFFF
    dw 0x0
    db 0x0
    db 10011010b   ; Present, DPL=0, Code, Executable, Readable
    db 11001111b   ; Limit 64-bit, Granularity 4KB
    db 0x0

gdt_data:
    dw 0xFFFF
    dw 0x0
    db 0x0
    db 10010010b   ; Present, DPL=0, Data, Readable, Writable
    db 11001111b   ; Limit 64-bit, Granularity 4KB
    db 0x0

gdt_end:
gdt_ptr:
    dw gdt_end - gdt_start - 1 ; Limit (Size of GDT)
    dd gdt_start ; Base of GDT

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

start64:
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax

    ; Call the C kernel
    call KERNEL_START

    ; Hang here if kernel returns
    hlt

; C Kernel
KERNEL_START:
    extern kernel_main
    call kernel_main
    ret

; 64-bit code goes here

; End of stage 2 bootloader
TIMES 510 - ($ - $$) db 0
DW 0xAA55  ; Boot signature