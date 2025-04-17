#include <stdio.h>

int main() {
    __asm__ volatile(
        "pld [pc, #-4]\n"
    );
    puts("Hello, world!\n");
    return 0;
}