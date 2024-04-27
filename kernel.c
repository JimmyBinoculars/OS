// C Kernel (kernel.c)
void kernel_main() {
    // Function pointer to video memory
    volatile unsigned char *video_memory = (unsigned char *)0xb8000;
    // Print "Hello World!" to the top-left corner of the screen
    const char *hello = "Hello World!";
    for (int i = 0; hello[i] != '\0'; ++i) {
        video_memory[i * 2] = hello[i];
        video_memory[i * 2 + 1] = 0x0f; // White on black color
    }
}