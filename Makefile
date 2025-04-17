ARM32_BUILD_DIR = build/arm32
ARM64_BUILD_DIR = build/arm64

# Makefile for ARM32 target
arm32_binary:
	mkdir -p $(ARM32_BUILD_DIR)
	arm-linux-gnueabihf-gcc -marm -o $(ARM32_BUILD_DIR)/insert-pld arm/insert-pld.c
	arm-linux-gnueabihf-gcc -marm -o $(ARM32_BUILD_DIR)/insert-pld-offset arm/insert-pld-offset.c
	arm-linux-gnueabihf-gcc -marm -o $(ARM32_BUILD_DIR)/insert-pld-with-nopsled arm/insert-pld-with-nopsled.c
	arm-linux-gnueabihf-gcc -marm -o $(ARM32_BUILD_DIR)/bogus-control-flow arm/bogus-control-flow.c -lm
	arm-linux-gnueabihf-gcc -marm -o $(ARM32_BUILD_DIR)/skip-deadcode arm/skip-deadcode.c

	echo "Running ARM32 binaries"
	QEMU_LD_PREFIX='/usr/arm-linux-gnueabihf/' qemu-arm-static ./$(ARM32_BUILD_DIR)/insert-pld
	QEMU_LD_PREFIX='/usr/arm-linux-gnueabihf/' qemu-arm-static ./$(ARM32_BUILD_DIR)/insert-pld-offset
	QEMU_LD_PREFIX='/usr/arm-linux-gnueabihf/' qemu-arm-static ./$(ARM32_BUILD_DIR)/insert-pld-with-nopsled
	QEMU_LD_PREFIX='/usr/arm-linux-gnueabihf/' qemu-arm-static ./$(ARM32_BUILD_DIR)/bogus-control-flow
	QEMU_LD_PREFIX='/usr/arm-linux-gnueabihf/' qemu-arm-static ./$(ARM32_BUILD_DIR)/skip-deadcode

# Makefile for ARM64 target
arm64_binary:
	mkdir -p $(ARM64_BUILD_DIR)
	aarch64-linux-gnu-gcc -o $(ARM64_BUILD_DIR)/bogus-control-flow arm/bogus-control-flow.c -lm
	aarch64-linux-gnu-gcc -o $(ARM64_BUILD_DIR)/skip-deadcode arm/skip-deadcode.c

	echo "Running ARM64 binaries"
	QEMU_LD_PREFIX='/usr/aarch64-linux-gnu/' qemu-aarch64-static ./$(ARM64_BUILD_DIR)/bogus-control-flow
	QEMU_LD_PREFIX='/usr/aarch64-linux-gnu/' qemu-aarch64-static ./$(ARM64_BUILD_DIR)/skip-deadcode

clean:
	rm -r $(ARM32_BUILD_DIR)