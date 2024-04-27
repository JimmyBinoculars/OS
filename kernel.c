void print_string(const char* str) {
    // BIOS interrupt for screen printing
    asm volatile(
        "mov $0x0E, %%ah\n\t" // BIOS function: 'Teletype output'
        "mov $0x07, %%bh\n\t" // Page number (0 for monochrome adapters)
        "int $0x10"            // Call BIOS interrupt
        :
        : "a"(str)
        : "memory"
    );
}

void kernel_main() {
    // Print "Hi" to the screen
    print_string("Hi");

    // Loop indefinitely
    while (1);
}