// kernel.c

void kernel_main() {
    // Write some text to the screen
    const char* message = "Hello, world!";
    write_string(message);
}

void write_string(const char* str) {
    // Write string to video memory (text mode)
    volatile char* video_memory = (volatile char*) 0xB8000;
    for (int i = 0; str[i] != '\0'; ++i) {
        video_memory[i * 2] = str[i];  // Character
        video_memory[i * 2 + 1] = 0x0F; // Attribute (white on black)
    }
}