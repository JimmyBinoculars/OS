; bootloader.asm

; Define the entry point
    BITS 16
    ORG 0x7C00

; Constants
VIDEO_MEMORY equ 0xB8000

; Main bootloader code
start:
    ; Disable interrupts
    cli

    ; Output debug message
    mov si, debug_msg
    call print_string

    ; Load kernel from disk
    mov ax, 0x0201    ; AH=2 (read sectors), AL=1 (number of sectors to read)
    mov bx, 0x8000    ; ES:BX = 0x8000:0x0000 (destination address)
    mov cx, 0x0002    ; Cylinder 0, Sector 2
    mov dh, 0x00      ; Head 0
    mov dl, 0x80      ; Drive 0x80 (first floppy drive)
    int 0x13          ; BIOS interrupt for disk I/O

    ; Check for error
    jc disk_error

    ; Jump to kernel entry point
    jmp 0x8000:0x0000

; Error handling code
disk_error:
    ; Display error message and halt
    mov si, error_msg
    call print_string
    cli
    hlt

; Print string subroutine
print_string:
    lodsb            ; Load next byte from SI into AL
    cmp al, 0        ; Check for null terminator
    je print_done    ; If null terminator, return
    mov ah, 0x0E     ; BIOS teletype function
    int 0x10         ; Call BIOS interrupt
    jmp print_string ; Repeat for next character
print_done:
    ret

; Print video memory subroutine
print_video_memory:
    mov si, VIDEO_MEMORY    ; Set SI to point to the start of video memory
print_video_memory_loop:
    lodsw                    ; Load next word from SI into AX (character and attribute)
    cmp al, 0                ; Check for null terminator
    je print_video_memory_done ; If null terminator, return
    mov ah, 0x0E             ; BIOS teletype function
    int 0x10                 ; Call BIOS interrupt to print character
    jmp print_video_memory_loop ; Repeat for next character
print_video_memory_done:
    ret

; Data section
error_msg db "Error loading kernel!", 0
debug_msg db "Booting kernel...", 0

; Padding and boot signature
times 510-($-$$) db 0
dw 0xAA55