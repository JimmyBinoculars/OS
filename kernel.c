void print_string(const char *str) {
    // VGA memory location
    char *video_memory = (char*)0xb8000;

    // Loop through the string and print each character
    for (int i = 0; str[i] != '\0'; ++i) {
        video_memory[i*2] = str[i];
        video_memory[i*2+1] = 0x07; // White color on black background
    }
}

void kernel_main() {
    print_string("Hello, World!");
}