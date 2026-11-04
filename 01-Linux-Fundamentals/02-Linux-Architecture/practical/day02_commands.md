# Day 02 - Linux Architecture Practical Commands

## Process Information

```bash
ps -p $$ -o pid,ppid,comm
ls /proc/$$
cat /proc/$$/status

## CPU and MEmory
cat /proc/cpuinfo | head -20
cat /proc/meminfo | head -20
cat /proc/uptime

##sysfs Exploration
ls /sys
ls /sys/class
ls /sys/class/i2c-dev
ls /sys/bus
ls /sys/bus/i2c
ls /sys/bus/i2c/devices
ls /sys/bus/i2c/drivers

##I2C Device Nodes
ls -l /dev/i2c-*
stat /dev/i2c-0

##Kernel Modules
ls /sys/module | head -30
lsmod | head -20

##Boot Information
systemd-analyze
systemctl status
ps -p 1 -o pid,comm,args
uname -a

##Kernel Logs
dmesg | tail -n 20
journalctl -k -n 20

##System Call Tracing
strace -e trace=write,openat,close echo "Hello Embedded Linux"
