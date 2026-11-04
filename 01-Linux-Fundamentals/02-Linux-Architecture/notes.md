# Linux Architecture and Kernel Fundamentals

## 1. Introduction

Linux is an open-source, Unix-like operating-system kernel. A complete Linux-based operating system combines the kernel with system libraries, utilities, services, applications, and other components.

Linux is widely used in embedded systems because it provides:

- Hardware abstraction.
- Process and memory management.
- Device-driver frameworks.
- Networking support.
- Filesystem support.
- Multitasking.
- Security and access control.
- Support for different processor architectures.

In embedded products, Linux commonly runs on application processors such as ARM-based SoCs and provides the software platform for applications and hardware peripherals.

---

## 2. Linux System Architecture

A simplified Linux system can be divided into four major layers:

```text
+--------------------------------------+
|          User Applications          |
|  Shell | Programs | Embedded Apps   |
+--------------------------------------+
|       Libraries and System APIs     |
|       glibc | POSIX APIs             |
+--------------------------------------+
|          Linux Kernel               |
|                                      |
| Process | Memory | VFS | Networking  |
|       Device Drivers | IPC           |
+--------------------------------------+
|             Hardware                |
| CPU | RAM | Storage | Peripherals    |
+--------------------------------------+
```

### 2.1 Hardware Layer

This is the physical computing platform.

Examples:

- CPU or SoC.
- RAM.
- Flash storage.
- GPIO controllers.
- UART controllers.
- I2C controllers.
- SPI controllers.
- Ethernet controllers.
- USB controllers.

### 2.2 Kernel Layer

The kernel manages hardware resources and provides services to user-space programs.

Applications normally do not directly control hardware registers. They interact with kernel interfaces and device drivers.

### 2.3 Library and API Layer

Libraries provide reusable functions and interfaces to applications.

Examples:

- glibc.
- POSIX interfaces.
- C standard library.

A library function may internally invoke one or more system calls.

### 2.4 Application Layer

This includes programs running in user space.

Examples:

- Shell.
- Text editors.
- Network applications.
- Embedded monitoring applications.
- Industrial control applications.

---

## 3. User Space and Kernel Space

Linux separates application execution from privileged kernel execution.

This separation improves system stability, security, and resource management.

### 3.1 User Space

User space is the environment where normal applications execute.

Examples:

- Shell programs.
- C applications.
- Python applications.
- Network services.
- Embedded applications.

Characteristics:

- Applications execute with restricted privileges.
- Each process has its own virtual address space.
- Applications cannot directly execute privileged CPU instructions.
- Applications request kernel services through system calls.

### 3.2 Kernel Space

Kernel space is the privileged execution environment of the Linux kernel.

Responsibilities include:

- Process scheduling.
- Virtual memory management.
- Hardware management.
- Device-driver execution.
- Interrupt handling.
- Networking.
- Filesystem operations.
- Security enforcement.

Kernel code executes with the privileges required to manage system resources.

### 3.3 User Space vs Kernel Space

| Feature | User Space | Kernel Space |
|---|---|---|
| Execution | Applications | Kernel code |
| Privilege | Restricted | Privileged |
| Memory | Process virtual address space | Kernel-managed address space |
| Hardware access | Through supported interfaces | Through drivers and hardware interfaces |
| Failure impact | Usually isolated to process | Can affect the entire system |
| Examples | Shell, applications | Scheduler, drivers, memory manager |

### 3.4 Transition Between User and Kernel Space

Consider a program that writes data to a terminal.

```text
User Application
       |
       | write() request
       v
System Call Interface
       |
       v
Kernel
       |
       v
TTY / Terminal Subsystem
       |
       v
Terminal Output
```

The CPU changes from user execution to privileged kernel execution through the system-call mechanism.

The kernel validates and processes the request, then returns a result to the application.

Important: A system call is not simply an ordinary C function call. It uses an architecture-specific mechanism to enter the kernel.

---

## 4. System Calls

A system call is the controlled interface through which a user-space application requests a service from the Linux kernel.

Applications need system calls because they do not have unrestricted access to kernel-managed resources.

### 4.1 Common System Calls

| System Call | Purpose |
|---|---|
| `open()` | Opens a file or device |
| `read()` | Reads data |
| `write()` | Writes data |
| `close()` | Closes a file descriptor |
| `fork()` | Creates a child process |
| `execve()` | Replaces the current process image |
| `mmap()` | Maps memory |
| `ioctl()` | Performs device-specific operations |
| `socket()` | Creates a communication endpoint |

### 4.2 Library Functions vs System Calls

A library function is provided by a software library. It may use system calls internally.

Example:

```c
#include <stdio.h>

int main(void)
{
    printf("Hello Linux\n");
    return 0;
}
```

`printf()` is a C standard library function, not itself a Linux system call.

The C library may use `write()` to transfer buffered output to the terminal.

### 4.3 Typical System Call Flow

```text
Application
    |
    v
Library Function
    |
    v
System Call Wrapper
    |
    v
CPU Enters Kernel Mode
    |
    v
Kernel System Call Handler
    |
    v
Kernel Subsystem
    |
    v
Return Value / Error
    |
    v
Application Resumes
```

The exact implementation depends on the processor architecture and kernel version.

---

## 5. Major Responsibilities of the Linux Kernel

### 5.1 Process Management

The kernel manages processes and threads.

Responsibilities:

- Process creation.
- Process termination.
- CPU scheduling.
- Context switching.
- Process state management.
- Inter-process communication support.

The scheduler decides which runnable task gets CPU time.

### 5.2 Memory Management

The kernel manages physical and virtual memory.

Responsibilities:

- Virtual memory management.
- Page allocation and deallocation.
- Memory mapping.
- Memory protection.
- Page caching.
- Memory reclaim.
- Swap management.

Each process operates within its own virtual address space, subject to kernel-managed mappings and permissions.

### 5.3 Device Management

The kernel manages hardware through device drivers and subsystem frameworks.

Examples:

- GPIO subsystem.
- I2C subsystem.
- SPI subsystem.
- USB subsystem.
- Input subsystem.
- Network subsystem.

Device drivers translate subsystem operations into hardware-specific operations.

### 5.4 Filesystem Management

The Virtual File System (VFS) provides a common interface for different filesystem implementations.

Examples:

- ext4.
- FAT.
- tmpfs.
- procfs.
- sysfs.

Applications use common filesystem operations without needing to understand every filesystem's internal implementation.

### 5.5 Networking

The kernel implements network protocols and manages network interfaces.

Examples:

- Ethernet.
- IP.
- TCP.
- UDP.
- Routing.
- Network packet processing.

### 5.6 Interrupt Management

Hardware devices can generate interrupts to notify the processor about events.

The kernel provides interrupt-handling mechanisms so drivers can respond to hardware events.

For example, a UART controller may signal that received data is available.

---

## 6. Linux Kernel Architecture

Linux uses a monolithic kernel architecture with support for dynamically loadable modules.

### 6.1 Monolithic Kernel

In a monolithic kernel, major operating-system services execute within the kernel's privileged address space.

Examples include:

- Process management.
- Memory management.
- Filesystem implementations.
- Networking.
- Device drivers.

### 6.2 Modular Kernel

Linux supports loadable kernel modules.

Modules allow selected kernel functionality, including many drivers, to be loaded when needed and removed when no longer required, subject to dependency and usage constraints.

This provides flexibility without changing Linux into a microkernel.

### 6.3 Major Kernel Components

```text
+------------------------------------+
|           System Calls             |
+------------------------------------+
| Process Management | Memory Mgmt   |
+------------------------------------+
| VFS | Networking | IPC | Security  |
+------------------------------------+
|        Device Driver Subsystems    |
| GPIO | I2C | SPI | USB | PCI       |
+------------------------------------+
|             Hardware              |
+------------------------------------+
```

The diagram is conceptual; actual kernel subsystems interact through many interfaces.

---

## 7. Linux Virtual Filesystems

Linux exposes several kernel interfaces through virtual filesystems.

These interfaces allow user-space applications and developers to inspect or interact with kernel-managed information.

### 7.1 procfs — /proc

procfs is a virtual filesystem that exposes process and kernel runtime information.

Important entries:

| Path | Purpose |
|---|---|
| `/proc/cpuinfo` | Processor information |
| `/proc/meminfo` | Memory statistics |
| `/proc/uptime` | System uptime |
| `/proc/[PID]/status` | Process status |
| `/proc/[PID]/maps` | Process memory mappings |

The files are generated through kernel interfaces when accessed. They are not ordinary disk-backed files.

### 7.2 sysfs — /sys

sysfs exposes the Linux kernel device model and attributes of registered kernel objects.

Important directories:

| Directory | Purpose |
|---|---|
| `/sys/class` | Device classes |
| `/sys/bus` | Bus types, devices and drivers |
| `/sys/devices` | Device hierarchy |
| `/sys/module` | Kernel module information |
| `/sys/block` | Block-device information |
| `/sys/power` | Power-management interfaces |

sysfs is especially useful for understanding how devices and drivers are represented by the kernel.

### 7.3 /dev — Device Nodes

The `/dev` directory contains device nodes through which applications access kernel device interfaces.

Examples:

- `/dev/null`
- `/dev/zero`
- `/dev/tty`
- `/dev/i2c-0`

A device node is an interface to a kernel-managed device. It is not the physical device itself.

### 7.4 Difference Between /proc, /sys and /dev

| Interface | Main Purpose |
|---|---|
| `/proc` | Process and kernel runtime information |
| `/sys` | Kernel device model and subsystem attributes |
| `/dev` | Device access interfaces |

---

## 8. Linux Device Model

The Linux device model provides a common framework for representing hardware devices, drivers, buses and classes.

Important concepts:

### 8.1 Device

A device represents a hardware component or a logical device managed by the kernel.

### 8.2 Driver

A driver contains the code needed to manage a particular device or family of devices.

### 8.3 Bus

A bus represents a communication or connection framework through which devices and drivers are associated.

Examples:

- PCI.
- USB.
- I2C.
- SPI.
- Platform bus.

### 8.4 Class

A class groups devices by their functionality rather than necessarily by their physical connection.

Examples:

- Input devices.
- Network interfaces.
- LEDs.
- Thermal devices.

### 8.5 Driver Binding

The kernel matches a device with a compatible driver using subsystem-specific matching rules.

After a successful match, the driver's probe callback is generally used to initialize the device.

---

## 9. Character Devices and Block Devices

Linux broadly distinguishes between character devices and block devices.

### 9.1 Character Devices

Character devices expose operations commonly performed as streams or device-specific transactions.

Examples:

- Serial interfaces.
- Terminal devices.
- I2C userspace interfaces.

### 9.2 Block Devices

Block devices provide block-oriented storage access.

Examples:

- HDDs.
- SSDs.
- Storage partitions.

### 9.3 Major and Minor Numbers

Device numbers identify device interfaces within the Linux device-number namespace.

- Major number identifies the registered device-number range associated with a driver.
- Minor number distinguishes individual devices or instances handled through that range.

The major number alone does not always uniquely identify one specific driver in every context; device-number registrations and subsystem conventions determine the association.

---

## 10. I2C Architecture in Linux

I2C stands for Inter-Integrated Circuit. It is a synchronous serial communication bus commonly used to connect low-speed peripherals.

### 10.1 I2C Signals

| Signal | Purpose |
|---|---|
| SDA | Serial Data |
| SCL | Serial Clock |

I2C devices commonly use a shared data line and clock line, with device addressing used to select a target.

### 10.2 Linux I2C Software Architecture

```text
       User-Space Application
                 |
                 v
          /dev/i2c-X
                 |
                 v
             i2c-dev
                 |
                 v
              I2C Core
                 |
                 v
        I2C Adapter Driver
                 |
                 v
        Physical I2C Controller
                 |
                 v
             I2C Bus
                 |
                 v
           I2C Peripheral
```

This illustrates the userspace `i2c-dev` path. Kernel client drivers can also communicate with devices through the I2C core without requiring an application to access `/dev/i2c-X` directly.

### 10.3 I2C Controller Driver

The controller driver manages the I2C controller hardware and implements the adapter transfer operations.

### 10.4 I2C Core

The I2C core provides common infrastructure for I2C adapters, clients, drivers and transfers.

### 10.5 I2C Client Driver

An I2C client driver manages a particular peripheral, such as a temperature sensor or EEPROM.

It understands the peripheral's registers, commands and device-specific communication protocol.

### 10.6 i2c-dev

The `i2c-dev` interface exposes I2C adapters to user-space applications through device nodes such as `/dev/i2c-0`.

It provides an alternative to writing a dedicated kernel client driver for certain applications. Direct userspace access must be used carefully because it can conflict with a kernel driver managing the same device.

---

## 11. Linux Boot Process

The boot process starts when a computer is powered on and ends when the operating system reaches its operational state.

### 11.1 Simplified Boot Sequence

```text
Power On
   |
   v
BIOS / UEFI
   |
   v
Bootloader
   |
   v
Linux Kernel + initramfs
   |
   v
Kernel Initialization
   |
   v
Root Filesystem
   |
   v
PID 1 (init/systemd)
   |
   v
System Services
   |
   v
Login / User Applications
```

### 11.2 BIOS / UEFI

Firmware initializes essential hardware and selects a boot device.

### 11.3 Bootloader

The bootloader loads the Linux kernel and commonly an initramfs image into memory.

GRUB is a commonly used Linux bootloader.

### 11.4 Kernel Initialization

The kernel initializes essential subsystems, memory management, CPU scheduling, device infrastructure and other core functionality.

### 11.5 initramfs

initramfs provides a temporary early userspace environment.

It may contain drivers, scripts and tools needed to locate and mount the actual root filesystem.

### 11.6 Root Filesystem

The kernel or early userspace process establishes the real root filesystem.

### 11.7 PID 1

The first userspace process normally becomes PID 1.

On many modern Linux distributions, this is systemd.

It initializes and manages system services and other userspace processes.

---

## 12. Kernel Modules

Kernel modules are components that can be dynamically loaded into or unloaded from a running Linux kernel.

They are commonly used for:

- Device drivers.
- Filesystem support.
- Networking functionality.
- Other optional kernel features.

### Important Commands

| Command | Purpose |
|---|---|
| `lsmod` | Lists loaded modules |
| `modinfo` | Displays module metadata |
| `modprobe` | Loads or removes modules while handling dependencies |
| `insmod` | Inserts a module file |
| `rmmod` | Removes a loaded module |

Not every driver is a loadable module. Some functionality is compiled directly into the kernel.

---

## 13. Kernel Logs

The Linux kernel produces messages during initialization and normal operation.

These messages help engineers investigate:

- Hardware detection.
- Driver initialization.
- Device connection and disconnection.
- Kernel warnings.
- Hardware errors.
- Subsystem activity.

Important tools:

- `dmesg`: Displays kernel ring-buffer messages.
- `journalctl -k`: Displays kernel messages collected by the system journal.

Kernel logs are particularly useful during device-driver development and hardware debugging.

---

## 14. Relevance to Embedded Linux Development

Understanding Linux architecture is essential before developing kernel modules and device drivers.

An embedded Linux engineer should understand:

1. How user applications interact with the kernel.
2. How system calls provide controlled kernel access.
3. How the kernel manages CPU and memory resources.
4. How Linux represents hardware devices.
5. How drivers interact with kernel subsystems.
6. How device interfaces are exposed to user space.
7. How the kernel boots and initializes hardware.
8. How kernel modules and logs support development and debugging.

These concepts form the foundation for subsequent topics such as C programming for Linux, kernel internals, kernel module development and Linux device drivers.

---

## 15. Day 02 Summary

In this topic, we introduced the Linux system architecture and explored the relationship between applications, libraries, the kernel and hardware.

We also studied:

- User space and kernel space.
- System calls.
- Kernel responsibilities.
- Monolithic and modular kernel architecture.
- procfs, sysfs and device nodes.
- Linux device model.
- Character and block devices.
- Major and minor numbers.
- Linux I2C architecture.
- Linux boot process.
- Kernel modules and kernel logs.

Practical commands and experiments are documented separately in the `practical/` directory.
