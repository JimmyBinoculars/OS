// kernel.c

#define VIDEO_MEMORY 0xB8000

void kernel_main() {
    // Write some text to the screen
    const char* message = "Hello, kernel!";
    write_string(message);

    // Enter an infinite loop
    while (1);
}

void write_string(const char* str) {
    // Write string to video memory (text mode)
    volatile char* video_memory = (volatile char*) VIDEO_MEMORY;
    for (int i = 0; str[i] != '\0'; ++i) {
        video_memory[i * 2] = str[i];      // Character
        video_memory[i * 2 + 1] = 0x0F;    // Attribute (white on black)
    }
}