#include <math.h>
#include <stdio.h>

// for ARM32 & ARM64

int main() {
    int a = 3;
    int b = 2;
    int c = 5;
    if (c < sqrt(a*a+b*b)) {
        __asm__ volatile(
            ".long 0x01020304\n"
            ".long 0x05060708\n"
        );
    }
    printf("Hello, world!\n");
    return 0;
}