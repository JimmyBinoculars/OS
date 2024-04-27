// kernel.c

// Include the print.h header
#include "print.h"

void kernel_main() {
    // Write some text to the screen
    const char* message = "Hello, kernel!";
    // Call the bootloader function to print the message
    print_string(message);

    // Enter an infinite loop
    while (1);
}