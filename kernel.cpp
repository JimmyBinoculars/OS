extern "C" void main() {
    char *message = "Hello World!";
    char *vga_buffer = (char*)0xb8000;

    for (int i=0; message[i] !='\0'; ++i) {
        vga_buffer[i * 2] = message[i];
        vga_buffer[i * 2 + 1] = 0x0F;
    }
    *(char*)0xb8000 = 'H';
    return;
}