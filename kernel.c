void main() {
    // Video memory starts at address 0xB8000
    char *video_memory = (char *)0xB8000;

    // Write "Hello World" to the video memory
    video_memory[0] = 'H';
    video_memory[1] = 0x0F; // White on Black color attribute
    video_memory[2] = 'e';
    video_memory[3] = 0x0F;
    video_memory[4] = 'l';
    video_memory[5] = 0x0F;
    video_memory[6] = 'l';
    video_memory[7] = 0x0F;
    video_memory[8] = 'o';
    video_memory[9] = 0x0F;

    // Loop indefinitely
    while (1) {}
}