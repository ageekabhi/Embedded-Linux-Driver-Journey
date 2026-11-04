# Linux Architecture and Kernel Fundamentals

## Overview

This topic explains the internal architecture of Linux,
the interaction between user space and kernel space,
system calls, kernel responsibilities, and hardware
device representation.

## Learning Objectives

- Understand user space and kernel space.
- Understand system calls and their purpose.
- Understand Linux kernel responsibilities.
- Understand monolithic kernel architecture.
- Learn the Linux boot process.
- Explore procfs, sysfs, and devtmpfs/devices.
- Understand device nodes and major/minor numbers.
- Explore I2C interfaces and kernel modules.
- Inspect Linux kernel messages.

## Topics Covered

1. User Space vs Kernel Space
2. System Calls
3. Linux Kernel Responsibilities
4. Monolithic Kernel Architecture
5. Linux Boot Process
6. procfs
7. sysfs
8. /dev and Device Nodes
9. Major and Minor Device Numbers
10. Kernel Modules
11. Kernel Messages
12. I2C Device Interfaces

## Practical Experiments

- Inspect process information using /proc.
- Inspect CPU and memory information.
- Inspect system uptime.
- Explore /sys/class.
- Explore I2C interfaces.
- Inspect /dev/i2c-* device nodes.
- Inspect kernel modules.
- Inspect boot information.
- Explore kernel logs.
- Trace system calls using strace.

## Directory Structure

- README.md: Topic overview
- notes.md: Detailed theory and explanations
- practical/: Linux commands and experiments
- exercises/: Practice questions and exercises

## Learning Outcome

Understand how Linux applications interact with
the kernel and how the kernel represents and
manages hardware devices and drivers.
