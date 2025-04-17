#include <stdio.h>

int main() {
    __asm__ volatile(
        "b skip_deadcode\n"
        ".long 0x01020304\n"
        ".long 0x05060708\n"

        "skip_deadcode:"
    );
    printf("Hello, world!\n");
    return 0;
}