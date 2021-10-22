#![no-std]

pub struct PortIO {
    pub port_no: u16,
    pub read_only: bool
}

impl PortIO {
    new(port_no: usize, read_only: bool) -> Self {
        Port { port_no, read_only }
    }

    pub fn read_u8(&self) -> u8 {
        // assembly is unsafe
        let value: u8;
        unsafe {
            asm!(
                "in al, dx", out("al") value, in("dx") self.port_no, 
                options(nomem, nostack, preserves_flags)
            );
        }

        return value;
    }

    pub fn write_u8(&self, value: u8) {
        if !self.read_only {
            unsafe {
                asm!(
                    "out dx, al", in("dx") self.port_no, in("al") value,
                    options(nomem, nostack, preserves_flags)
                );
            }
        }
    }

    pub fn read_u16(&self) -> u16 {
        let value: u16;
        unsafe {
            asm!(
                "in ax, dx", out("ax") value, in("dx") self.port_no,
                options(nomem, nostack, preserves_flags)
            );
        }

        return value;
    }

    pub fn write_u16(&self, value: u16) {

        if !self.read_only {
            unsafe {
                asm!(
                    "out dx, ax", in("dx") self.port_no, in("ax") value,
                    options(nomem, nostack, preserves_flags) 
                );
            }
        }
    }

    pub fn read_u32(&self) -> u32 {
        let value: u32;
        unsafe {
            asm!(
                "in eax, dx", out("eax") value, in("dx") self.port_no,
                options(nomem, nostack, preserves_flags)
            );
        }

        return value;
    }

    pub fn write_u32(&self, value: u32) {
        if !self.read_only {
            unsafe {
                asm!(
                    "out dx, eax", in("dx") self.port_no, in("eax") value,
                    options(nomem, nostack, preserves_flags)
                );
            }
        }
    }

    pub fn read_u64(&self) -> u64 {
        let value: u64;
        unsafe {
            asm!(
                "in rax, dx", out("rax") value, in("dx") self.port_no,
                options(nomem, nostack, preserves_flags)
            );
        }

        return value;
    }

    pub fn write_u64(&self, value: u64) {
        if !self.read_only {
            unsafe {
                asm!(
                    "out dx, rax", in("dx") self.port_no, in("rax") value,
                    options(nomem, nostack, preserves_flags)
                );
            }
        }
    }
}