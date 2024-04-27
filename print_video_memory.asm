; print_video_memory.asm

; Print video memory subroutine
print_video_memory:
    mov cx, 0 ; Initialize counter for row
    mov dh, 0 ; Initialize counter for column
next_character:
    lodsb ; Load character from SI into AL
    test al, al ; Check if it's the end of string
    jz video_memory_done ; If end of string, exit loop
    mov ah, 0x0E ; Set teletype function
    int 0x10 ; Call BIOS interrupt
    inc dh ; Move to next column
    cmp dh, 80 ; Check if end of line
    jne next_character ; If not, continue to next character
    mov dh, 0 ; Reset column counter
    inc cx ; Move to next row
    cmp cx, 25 ; Check if end of screen
    jne next_character ; If not, continue to next character
    jmp video_memory_done ; If end of screen, exit loop
video_memory_done:
    ret