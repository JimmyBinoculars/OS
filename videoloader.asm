; videoloader.asm

; Read and output from video memory subroutine
read_video_memory:
    mov bx, videomem ; Move the address of video memory into bx
    mov cx, 2000     ; Number of characters in text mode (80 columns * 25 rows)
read_loop:
    mov al, [bx]     ; Read character from video memory
    mov ah, 0x0E     ; BIOS teletype function
    int 0x10         ; Call BIOS interrupt to print character in AL to screen
    inc bx           ; Move to next character
    loop read_loop   ; Loop until all characters are read
    ret

; Data section
videomem equ 0xB8000