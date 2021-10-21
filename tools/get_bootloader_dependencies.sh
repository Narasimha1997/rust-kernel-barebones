#!/bin/bash

OS_PACKAGE_MANAGER="apt"

function check_necessary_commands() {
    if ! command -v git &> /dev/null; then
        echo "git not found, install git and continue.."
        exit 1
    fi

    if ! command -v make &> /dev/null; then
        echo "make not found install build essentials.."
        exit 1
    fi

    if [[ ! "$OS_PACKAGE_MANAGER" == "apt" ]]; then
        echo "Only apt is supported as of now."
        exit 1
    fi

    echo "git and make found on this system."
}

function get_limine() {
    pushd third_party
        if [[ ! -d "bootloader" ]]; then
            mkdir -p bootloader
        fi
        pushd bootloader
            git clone git@github.com:limine-bootloader/limine.git --branch=latest-binary --depth=1
            pushd limine
                make
                sudo make install
            popd
        popd
    popd
}

function get_echfs_utils() {
    # install echfs
    pushd third_party
        if [[ ! -d "bootloader" ]]; then
            mkdir -p bootloader
        fi

        sudo apt install -y uuid-dev libfuse-dev nasm

        pushd bootloader
            git clone git@github.com:echfs/echfs.git
            pushd echfs
                make
                sudo make install
            popd
        popd
    popd
}

# install limine
check_necessary_commands

get_echfs_utils
echo "Install echfs-utils"

get_limine
echo "Installed limine bootloader."
