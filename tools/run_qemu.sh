#!/bin/bash

QEMU_BINARY="qemu-system-x86_64"

if [[ ! -d "./kbin/x86_64" ]]; then
    mkdir -p kbin
    # build the kernel bootimage
    ./tools/sub/build_kernel_bootimage.sh
fi

KERNEL_BIN_PATH="./kbin/x86_64/debug/bootimage-r3_kernel.bin"
# run in with qemu:
QEMU_ARGS="-enable-kvm -cpu host -m 1G -M pc"
QEMU_ARGS="$QEMU_ARGS -hda $KERNEL_BIN_PATH"

# run the binary
$QEMU_BINARY $QEMU_ARGS
