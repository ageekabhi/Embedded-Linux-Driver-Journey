# Linux Architecture and Kernel Fundamentals

## 1. User Space

User space is the restricted execution environment
where normal applications and processes run.

Examples:
- Shell
- Text editors
- Compilers
- Applications
- Libraries

Applications request privileged kernel services
through system calls.

## 2. Kernel Space

Kernel space is the privileged execution environment
where the Linux kernel performs operating-system
operations.

Responsibilities:
- Process scheduling
- Memory management
- Device management
- Interrupt handling
- Networking
- Filesystem management
- Security

## 3. System Calls

System calls provide the interface between
user-space applications and the kernel.

Common system calls:

| System Call | Purpose |
|-------------|---------|
| open() | Open a file |
| read() | Read data |
| write() | Write data |
| close() | Close a file |
| fork() | Create a process |
| execve() | Execute a program |
| mmap() | Map memory |
| ioctl() | Device-specific operations |

A library function such as printf() is not itself
a system call. It may use write() internally.

## 4. Linux Kernel Architecture

Linux uses a monolithic kernel architecture
with modular capabilities.

Major subsystems:
- Process management
- Memory management
- Virtual File System
- Networking
- Device drivers
- Interrupt management
- I2C and SPI frameworks

## 5. Kernel Responsibilities

The Linux kernel manages:
- CPU resources
- Memory
- Processes
- Hardware devices
- Filesystems
- Network communication
- Security and permissions
- Power management

## 6. Linux Boot Process

Simplified boot sequence:

1. BIOS/UEFI initializes hardware.
2. Bootloader loads kernel and initramfs.
3. Kernel initializes its core subsystems.
4. Initramfs assists in locating the root filesystem.
5. Kernel mounts the real root filesystem.
6. PID 1 starts.
7. System services start.
8. Login interface becomes available.

## 7. procfs

/proc is a virtual filesystem that exposes
process and kernel runtime information.

Important entries:
- /proc/cpuinfo
- /proc/meminfo
- /proc/uptime
- /proc/[PID]/status

It is generated dynamically by kernel code,
rather than being ordinary disk-backed files.

## 8. sysfs

/sys is a virtual filesystem associated with sysfs.

It exposes the kernel device model and attributes.

Important directories:
- /sys/class
- /sys/bus
- /sys/devices
- /sys/module
- /sys/block

It is especially useful when investigating
hardware devices and their associated drivers.

## 9. /dev

/dev contains device nodes used by applications
to access device interfaces.

Examples:
- /dev/null
- /dev/tty
- /dev/i2c-0

Device nodes are not the physical hardware itself.
They provide an interface to kernel-managed devices.

## 10. Major and Minor Numbers

Linux device numbers identify device interfaces.

- Major number identifies the device type/driver
  association.
- Minor number identifies a particular device
  handled through that interface.

For example:
- /dev/i2c-0: major 89, minor 0
- /dev/i2c-1: major 89, minor 1

## 11. Character and Block Devices

Character devices expose stream-oriented or
device-specific operations.

Examples:
- Serial interfaces
- I2C character-device interface

Block devices operate on data blocks.

Examples:
- SSD
- HDD

## 12. I2C Architecture

I2C is a serial communication bus using:
- SDA: Serial Data
- SCL: Serial Clock

Linux I2C architecture includes:

1. I2C userspace interface (i2c-dev)
2. I2C core
3. I2C controller driver
4. I2C client driver
5. Physical controller and peripheral

The controller driver manages the controller hardware.
The client driver manages communication with a
particular peripheral.

## 13. Kernel Modules

Kernel modules are components that can be loaded
into or unloaded from the running Linux kernel.

Useful commands:

- lsmod
- modinfo
- modprobe
- insmod
- rmmod

Some drivers are built into the kernel and do not
appear in lsmod.

## 14. Kernel Logs

dmesg displays kernel messages.

Useful commands:

- dmesg
- dmesg | tail
- journalctl -k

Logs help investigate hardware detection,
driver initialization, warnings, and errors.

## 15. Important Differences

| Interface | Purpose |
|-----------|---------|
| /proc | Process and kernel runtime information |
| /sys | Kernel device model and attributes |
| /dev | Device access interfaces |

## 16. Key Learning

User applications operate in user space and
request kernel services through system calls.

The kernel manages hardware through subsystems
and device drivers.

Understanding /proc, /sys, and /dev is an
important foundation for Linux device-driver
development.
