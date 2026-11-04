# Linux Architecture and Kernel Fundamentals

## Overview

This topic explores the internal architecture of Linux, the interaction between user space and kernel space, system calls, kernel responsibilities, virtual filesystems, and hardware device representation.

It builds the foundation required to understand Linux kernel internals, kernel module development, and embedded Linux device drivers.

## Learning Objectives

- Understand the architecture of a Linux operating system.
- Differentiate user space and kernel space.
- Understand the purpose and operation of system calls.
- Explore major responsibilities of the Linux kernel.
- Understand monolithic kernel architecture and loadable modules.
- Understand Linux virtual filesystems: procfs and sysfs.
- Explore the Linux device model.
- Understand character devices, block devices, and device numbers.
- Understand the Linux I2C subsystem and device interfaces.
- Learn the stages of the Linux boot process.
- Understand kernel modules and kernel logging.

## Topics Covered

1. Linux System Architecture
2. User Space vs Kernel Space
3. System Calls
4. Linux Kernel Responsibilities
5. Linux Kernel Architecture
6. Linux Virtual Filesystems
7. Linux Device Model
8. Character Devices and Block Devices
9. I2C Architecture in Linux
10. Linux Boot Process
11. Kernel Modules
12. Kernel Logs
13. Embedded Linux Relevance

## Practical Experiments

### Completed

- Inspected the current shell process using `ps`.
- Explored process information through `/proc`.
- Examined process status information.
- Inspected CPU information through `/proc/cpuinfo`.
- Inspected memory information through `/proc/meminfo`.
- Examined system uptime through `/proc/uptime`.
- Explored Linux sysfs directories.
- Inspected available device classes through `/sys/class`.
- Explored I2C interfaces through `/sys/class/i2c-dev`.
- Inspected I2C device nodes under `/dev`.

### Planned

- Explore the I2C bus and driver directories under `/sys/bus`.
- Inspect device-node metadata using `stat`.
- Explore loaded kernel modules using `lsmod`.
- Inspect kernel module information under `/sys/module`.
- Examine boot and service information.
- Inspect kernel messages using `dmesg` and `journalctl`.
- Trace system calls using `strace`.

## Repository Structure

```text
02-Linux-Architecture/
├── README.md
├── notes.md
├── practical/
│   └── day02_commands.md
└── exercises/
    └── questions.md
```

| File | Purpose |
|---|---|
| `README.md` | Topic overview and learning progress |
| `notes.md` | Detailed theory and technical explanations |
| `practical/day02_commands.md` | Commands, experiments, and observations |
| `exercises/questions.md` | Conceptual and practical exercises |

## Learning Outcome

Develop a foundational understanding of how Linux applications interact with the kernel, how the kernel manages system resources, and how hardware devices are represented through Linux kernel interfaces.

This knowledge prepares for advanced study of Linux kernel internals, kernel modules, and device driver development.

## Progress

**Status:** In Progress

Theory and initial `/proc`, `/sys`, and `/dev` explorations have been documented. Additional practical experiments and deeper study of system calls, boot processes, kernel modules, and kernel logs remain.
