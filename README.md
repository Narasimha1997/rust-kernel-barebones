# rust-kernel-barebones
A minimal rust kernel and a bunch of configuration scripts that can be used to bootstrap Operating system development using Nightly-Rust (x86_64-unkown-none host-triple) compiler.

This repository uses tools built by the awesome Rust OsDev [community](https://github.com/rust-osdev) (like xbuild, bootimage, bootloader crates) and configures all of these tools to work together so developers can use them without having to worry much on toochain configuration. The toolchain builds and configures the project to use `x86_64-unknwon-none` target. Some features include:

1. A single script that configures the whole environment.
2. A single script to build the kernel and emulate it using Qemu.
3. VS Code RLS configuration.

### Tools used by this barebones:
1. [bootimage](https://github.com/rust-osdev/bootimage) - A tool that builds the Kernel written in Rust and packages it with bootloader.
2. [bootloader](https://github.com/rust-osdev/bootloader) - A bootloader written in Rust.
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

2. Build and run the kernel:
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

#### Configuring QEMU parameters:
To use your own custom parameters for qemu emulation, modify `QEMU_ARGS` variable in `tools/run_qemu.sh` file.

### Contributing:
Feel free to try this tool, raise issues, suggest changes or make pull requests. 
