// kernel.cpp

extern "C" void kernel_main() {
    const char* message = "Hello, OS World!";
    volatile unsigned char* video_memory = (volatile unsigned char*)0xB8000;

    for (int i = 0; message[i] != '\0'; ++i) {
        video_memory[i * 2] = message[i];
        video_memory[i * 2 + 1] = 0x0F; // White on black
    }
}
