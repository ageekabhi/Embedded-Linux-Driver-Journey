# Day 02 — Linux Architecture Practical Commands

## 1. Purpose

This document records the Linux commands used to explore process information, system resources, kernel interfaces, and I2C device representation.

The commands are divided into:
- **Executed experiments:** Commands already run during Day 02.
- **Pending experiments:** Commands to investigate in a later practical session.

## 2. Process Information — Executed

### Identify the current shell process

```bash
ps -p $$ -o pid,ppid,comm
```

Purpose:
- `$$` represents the current shell's process ID.
- `PID` identifies the process.
- `PPID` identifies its parent process.
- `COMMAND` displays the process name.

### Inspect the process directory

```bash
ls /proc/$$
```

Purpose: Lists the virtual files and directories associated with the current process.

### Read process status

```bash
cat /proc/$$/status
```

Important fields:
- `Name`: Process name.
- `State`: Current process state.
- `Pid`: Process ID.
- `PPid`: Parent process ID.
- `Uid` and `Gid`: User and group identifiers.
- `VmSize`: Virtual memory size.
- `VmRSS`: Resident Set Size.
- `Threads`: Number of threads.
- `voluntary_ctxt_switches`: Voluntary context switches.
- `nonvoluntary_ctxt_switches`: Non-voluntary context switches.

## 3. CPU and Memory Information — Executed

### CPU information

```bash
cat /proc/cpuinfo | head -20
```

Purpose: Inspects the first 20 lines of CPU information exposed through procfs.

### Memory information

```bash
cat /proc/meminfo | head -20
```

Purpose: Inspects memory statistics maintained by the Linux kernel.

Important fields:
- `MemTotal`: Total usable RAM reported by the kernel.
- `MemFree`: Currently unused memory.
- `MemAvailable`: Estimated memory available for new applications without swapping.
- `Cached`: Cached filesystem data.
- `SwapTotal`: Total swap space.
- `SwapFree`: Currently unused swap space.

### System uptime

```bash
cat /proc/uptime
```

Purpose: Displays system uptime and accumulated idle CPU time.

## 4. sysfs Exploration — Executed

### List sysfs top-level entries

```bash
ls /sys
```

### Explore device classes

```bash
ls /sys/class
```

Purpose: Inspects device classes registered with the Linux device model.

### Explore I2C device interfaces

```bash
ls -l /sys/class/i2c-dev
```

Purpose: Inspects symbolic links representing registered I2C character-device interfaces.

## 5. I2C Device Nodes — Executed

```bash
ls -l /dev/i2c-*
```

Purpose: Lists the I2C device nodes exposed through the `/dev` filesystem.

Important fields in the output:
- `c`: Character device.
- Owner and group: Access permissions.
- Major number: Device interface/driver association.
- Minor number: Individual device instance identifier.

**Observed on this system:** I2C device nodes were present with major number `89` and minor numbers `0` through `12`. The nodes were owned by `root`.

## 6. Additional Experiments — Pending

The following commands are documented for future investigation. They must not be considered completed until they have actually been executed and their outputs examined.

### I2C sysfs hierarchy

```bash
ls /sys/bus
ls /sys/bus/i2c
ls /sys/bus/i2c/devices
ls /sys/bus/i2c/drivers
```

### Device-node metadata

```bash
stat /dev/i2c-0
```

### Kernel module inspection

```bash
ls /sys/module | head -30
lsmod | head -20
```

### Boot information

```bash
systemd-analyze
systemctl status
ps -p 1 -o pid,comm,args
uname -a
```

### Kernel logs

```bash
dmesg | tail -n 20
journalctl -k -n 20
```

### System call tracing

```bash
strace -e trace=write,openat,close echo "Hello Embedded Linux"
```

Note: `strace` may need to be installed separately. Kernel log access may also be restricted by system permissions.

## 7. Safety Notes

- These experiments are intended for system inspection.
- Do not write arbitrary data to `/dev/i2c-*`.
- Do not unload kernel modules or change device permissions during these introductory experiments.
- Use elevated privileges only when necessary and when the command is understood.

## 8. Learning Outcome

These experiments provide practical exposure to:
- Process information through `/proc`.
- CPU and memory information exposed by the kernel.
- Device-model information through `/sys`.
- Character-device interfaces through `/dev`.
- I2C device representation in Linux.

Further experiments will investigate system calls, kernel modules, boot information, and kernel logs.
