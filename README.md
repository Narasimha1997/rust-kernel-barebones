# rust-kernel-barebones
A minimal 64-bit rust kernel and a bunch of configuration scripts that can be used to bootstrap Operating system development using Nightly-Rust (x86_64-unkown-linux-gnu host-triple) compiler.

This repository uses tools built by the awesome Rust OsDev [community](https://github.com/rust-osdev) (like xbuild, bootloader crates) and configures all of these tools to work together so developers can use them without having to worry much on toochain configuration. The toolchain builds and configures the project to use `x86_64-unknwon-none` target. Some features include:

1. A single script that configures the whole environment.
2. A single script to build the kernel and emulate it using Qemu.
3. VS Code RLS configuration.

### Tools used by this barebones:
1. [bootloader](https://github.com/rust-osdev/bootloader) - A bootloader written in Rust.
3. [cargo-xbuild](https://github.com/rust-osdev/cargo-xbuild) - A tool that takes care of managing nightly rust toolchain.

### Prerequisites
1. A linux based operating system with bash shell.
2. apt package manager (if you are using Red hat based distros, modify `tools/setup_env.sh` file.)

### How to set-up?
Follow these simple steps to bootstrap a working kernel development environment:
1. Clone the repository with it's submodules:

```
git clone --recurse-submodule git@github.com:Narasimha1997/rust-kernel-barebones.git
```

2. Setup the environment:
Just run the file:
```
bash ./tools/setup_env.sh
```

This will check for tools like qemu, kvm, rustc, cargo and jq. Tools which are not present will be installed and you may need to enter few choices while installation. Next it will download and install few rust crates that are required for the toolchain to work properly. Then the script configures VS code editor to make RLS plugin recognize the `x86_64-unknown-none` target.

**Note:**: After running this script you may have to restart the shell before proceeding to step 3 if `cargo` and `rustc` are freshly installed because the `$PATH` needs to be updated to make sure `cargo` and `rustc` are picked up. You can also run `source ~/.bashrc` to manually refresh the shell's env.

3. Build and run the kernel:
To build and run the kernel, just run:
```
bash tools/run_qemu.sh
```
This will build the kernel with bootloader and creates a bootable image, then spins up the qemu with KVM acceleration. If you want to only build and skip emulation, then:

```
bash tools/run_qemu.sh --build
```
The build artifcats are generated at `kbin` directory, so build artifacts will be cached for next time. If you want to force a rebuild from scratch again, then:
```
bash tools/run_qemu.sh --clean
```
You can use both of these options together as well:
```
bash tools/run_qemu.sh --clean --build
```

If everything is successful, the kernel should bootup into a blank screen and qemu should create a `serial.out` file where the kernel will write `Hello, World!!` via a serial port.

### UEFI Mode:
Normally the kernel will be booted in legacy BIOS mode. In order to enable UEFI mode, pass `--uefi` flag to the `run_qemu.sh`.
```
bash tools/run_qemu.sh --uefi
```
The UEFI mode uses [Open Virtual Machine Firmware (OVMF)](http://www.linux-kvm.org/downloads/lersek/ovmf-whitepaper-c770f8c.txt) and can be installed via `ovmf` package. The `setup_env.sh` script will install this as well, the UEFI firmware will be added to `qemu-system-x86_64` via `-bios /usr/share/ovmf/OVMF.fd` flag. The `--uefi` flag can be used with other flags as well:
```
bash tools/run_qemu.sh --uefi --clean --build
```

#### Configuring QEMU parameters:
To use your own custom parameters for qemu emulation, modify `QEMU_ARGS` variable in `tools/run_qemu.sh` file.

### Contributing:
Feel free to try this tool, raise issues, suggest changes or make pull requests. 
