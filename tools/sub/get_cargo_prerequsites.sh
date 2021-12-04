#!/bin/bash

# install xbuild = this will make cross-compilation easy for us.
cargo install cargo-xbuild

# set default nightly compiler
rustup default nightly

# get rust-src
rustup component add rust-src --toolchain nightly-x86_64-unknown-linux-gnu

# add llvm-tools-preview - the bootloader needs it.
rustup component add llvm-tools-preview 