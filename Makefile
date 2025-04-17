ARM32_BUILD_DIR = build/arm32
ARM64_BUILD_DIR = build/arm64
X64_BUILD_DIR = build/x64

# Makefile for ARM32 target
arm32_binary:
	mkdir -p $(ARM32_BUILD_DIR)
	arm-linux-gnueabihf-gcc -marm -o $(ARM32_BUILD_DIR)/insert-pld arm32/insert-pld.c
	arm-linux-gnueabihf-gcc -marm -o $(ARM32_BUILD_DIR)/insert-pld-offset arm32/insert-pld-offset.c
	arm-linux-gnueabihf-gcc -marm -o $(ARM32_BUILD_DIR)/insert-pld-with-nopsled arm32/insert-pld-with-nopsled.c
	arm-linux-gnueabihf-gcc -marm -o $(ARM32_BUILD_DIR)/BogusControlFlow-dcq32 arm32/BogusControlFlow-dcq32.c -lm
	arm-linux-gnueabihf-gcc -marm -o $(ARM32_BUILD_DIR)/branch-dcq32 arm32/branch-dcq32.c

	echo "Running ARM32 binaries"
	QEMU_LD_PREFIX='/usr/arm-linux-gnueabihf/' qemu-arm-static ./$(ARM32_BUILD_DIR)/insert-pld
	QEMU_LD_PREFIX='/usr/arm-linux-gnueabihf/' qemu-arm-static ./$(ARM32_BUILD_DIR)/insert-pld-offset
	QEMU_LD_PREFIX='/usr/arm-linux-gnueabihf/' qemu-arm-static ./$(ARM32_BUILD_DIR)/insert-pld-with-nopsled
	QEMU_LD_PREFIX='/usr/arm-linux-gnueabihf/' qemu-arm-static ./$(ARM32_BUILD_DIR)/BogusControlFlow-dcq32
	QEMU_LD_PREFIX='/usr/arm-linux-gnueabihf/' qemu-arm-static ./$(ARM32_BUILD_DIR)/branch-dcq32

# Makefile for ARM64 target
arm64_binary:
	mkdir -p $(ARM64_BUILD_DIR)
	aarch64-linux-gnu-gcc -o $(ARM64_BUILD_DIR)/BogusControlFlow-dcq64 arm64/BogusControlFlow-dcq64.c -lm
	aarch64-linux-gnu-gcc -o $(ARM64_BUILD_DIR)/branch-dcq64 arm64/branch-dcq64.c

	echo "Running ARM64 binaries"
	QEMU_LD_PREFIX='/usr/aarch64-linux-gnu/' qemu-aarch64-static ./$(ARM64_BUILD_DIR)/BogusControlFlow-dcq64
	QEMU_LD_PREFIX='/usr/aarch64-linux-gnu/' qemu-aarch64-static ./$(ARM64_BUILD_DIR)/branch-dcq64

clean:
	rm -r $(ARM32_BUILD_DIR)