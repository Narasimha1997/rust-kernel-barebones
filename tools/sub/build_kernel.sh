#!/bin/bash

# build the kernel elf64 binary
pushd r3_kernel
    cargo xbuild
popd
