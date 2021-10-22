#!/bin/bash

# install qemu if not exist:
function install_qemu () {
    if ! command -V qemu-system-x86_64 &> dev/null; then
        # change this according to your package name
        echo "Installing Qemu + KVM"
        sudo apt update
        sudo apt install -y qemu-kvm libvirt-dev bridge-utils libvirt-daemon-system \
            libvirt-daemon virtinst bridge-utils libosinfo-bin libguestfs-tools \
            virt-top
        echo "Installed Qemu + KVM"
    else
        echo "Qemu with kvm is already installed"
    fi
}

function install_rust_cargo () {
    if ! command -V cargo &> dev/null; then
        echo "Installing rust and cargo."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        echo "Installed rust and cargo."
    else
        echo "Rust and Cargo are already installed."
    fi
}

function setup_toolchain_env () {
    echo "Configuring project to use rust nightly cross compiler."
    ./tools/sub/get_cargo_prerequsites.sh

    echo "Building bootimage generator binary locally."
    ./tools/sub/build_bootimage_binary.sh

    echo "Done configuring."
}

install_qemu
install_rust_cargo
setup_toolchain_env

