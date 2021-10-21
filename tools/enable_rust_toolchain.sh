#!/bin/bash

# enable rust nightly
rustup install nightly
cd r3_kernel
# Sets the nightly toolchain as the version of the project 
rustup override set nightly
# Installs cargo xbuild. Needed to build core for our custom target
cargo install cargo-xbuild