# Day 02 — Linux Architecture and Kernel Fundamentals
## Exercises and Knowledge Assessment

These exercises are designed to test understanding of Linux architecture, kernel fundamentals, virtual filesystems, and device interfaces.

## Section 1 — Conceptual Questions

1. What is the difference between user space and kernel space?
2. Why does Linux separate user space from kernel space?
3. What happens when a user-space application requests a kernel service?
4. What is a system call?
5. Is `printf()` a system call? Explain.
6. What is the difference between a library function and a system call?
7. What are the major responsibilities of the Linux kernel?
8. What is a monolithic kernel?
9. Why is Linux described as a modular monolithic kernel?
10. What is the role of a device driver in Linux?

## Section 2 — Linux Virtual Filesystems

11. What is a virtual filesystem?
12. What is procfs?
13. Why is `/proc` not an ordinary disk-backed directory?
14. What information is available in `/proc/[PID]/status`?
15. What is the difference between `VmSize` and `VmRSS`?
16. What information is provided by `/proc/cpuinfo`?
17. What is the purpose of `/proc/meminfo`?
18. What information does `/proc/uptime` provide?
19. What is sysfs?
20. What is the difference between `/proc` and `/sys`?

## Section 3 — Linux Device Model

21. What is the purpose of `/sys/class`?
22. What is the purpose of `/sys/devices`?
23. What is the purpose of `/sys/bus`?
24. What is the purpose of `/sys/module`?
25. What is the difference between `/sys` and `/dev`?
26. What is a device node?
27. What is a character device?
28. What is a block device?
29. What are major and minor device numbers?
30. Why are device nodes not the physical hardware themselves?

## Section 4 — I2C in Linux

31. What is I2C?
32. What are SDA and SCL?
33. What is the role of the I2C controller driver?
34. What is the role of the Linux I2C core?
35. What is an I2C client driver?
36. What is the purpose of the `i2c-dev` interface?
37. What is the relationship between `/sys/class/i2c-dev` and `/dev/i2c-*`?
38. Does the presence of an I2C adapter guarantee that a sensor is connected? Explain.

## Section 5 — Kernel and Boot Fundamentals

39. What is the Linux boot process?
40. What is the role of BIOS/UEFI?
41. What is a bootloader?
42. What is initramfs?
43. What happens when the Linux kernel starts executing?
44. What is PID 1?
45. What is the purpose of `systemd`?
46. What are kernel modules?
47. What is the difference between built-in kernel code and a loadable kernel module?
48. What is the purpose of `dmesg`?

## Section 6 — Practical Exercises

### Exercise 1: Process Inspection

Use:

```bash
ps -p $$ -o pid,ppid,comm
cat /proc/$$/status
```

Tasks:
- Identify the process ID and parent process ID.
- Find the process state.
- Identify the number of threads.
- Locate the memory-related fields.
- Explain what the output tells you about the process.

### Exercise 2: System Information

Use:

```bash
cat /proc/cpuinfo | head -20
cat /proc/meminfo | head -20
cat /proc/uptime
```

Tasks:
- Identify processor information.
- Explain the difference between `MemFree` and `MemAvailable`.
- Explain what the two uptime values represent.

### Exercise 3: Explore sysfs

Use:

```bash
ls /sys
ls /sys/class
ls /sys/bus
```

Tasks:
- Identify the important directories.
- Explain the purpose of `/sys/class`.
- Explain how sysfs helps users investigate kernel-managed devices.

### Exercise 4: Understand Device Nodes

Use:

```bash
ls -l /dev/null
ls -l /dev/zero
ls -l /dev/tty
```

Tasks:
- Identify character-device entries.
- Find their major and minor numbers.
- Explain the meaning of the `c` character in the output.

### Exercise 5: I2C Interface Exploration

Use:

```bash
ls -l /sys/class/i2c-dev
ls -l /dev/i2c-*
```

Tasks:
- Explain what an I2C adapter represents.
- Identify the character-device interface.
- Explain the relationship between sysfs and `/dev`.
- Explain why an adapter does not necessarily mean an external sensor is connected.

## Section 7 — Engineering Challenge

**Challenge: Explain the journey of a user-space application accessing an I2C sensor.**

Describe the sequence involving:

1. User-space application.
2. System call interface.
3. I2C userspace interface or kernel I2C client driver.
4. Linux I2C core.
5. I2C controller driver.
6. Physical I2C controller.
7. Sensor hardware.

Explain how the architecture differs when an application accesses a sensor through a dedicated kernel client driver rather than directly through `/dev/i2c-*`.

## Section 8 — Self-Assessment

Before moving to the next topic, make sure you can:

- [ ] Explain user space and kernel space.
- [ ] Explain the purpose of system calls.
- [ ] Describe the major responsibilities of the kernel.
- [ ] Differentiate `/proc`, `/sys`, and `/dev`.
- [ ] Explain major and minor device numbers.
- [ ] Describe the basic Linux I2C architecture.
- [ ] Explain the Linux boot sequence.
- [ ] Explain the purpose of kernel modules and kernel logs.
