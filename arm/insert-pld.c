#include <stdio.h>

// for ARM32

int main() {
    __asm__ volatile(
        "pld [pc]\n"
    );
    puts("Hello, world!\n");
    return 0;
}