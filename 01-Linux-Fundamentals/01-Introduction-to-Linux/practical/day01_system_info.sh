#!/bin/bash

#Embedded Linux Journey 
#Day 1: Linux System Introduction

echo "======================================"
echo "       LINUX SYSTEM INTRODUCTION       "
echo "======================================"
echo ""
echo "Operating System:"
grep PRETTY_NAME /etc/os-release

echo ""
echo "Kernel Version:"
uname -r

echo ""
echo "System Architecture:"
uname -m

echo ""
echo "Hostname:"
hostname

echo ""
echo "Current User:"
whoami

echo ""
echo "CPU Information:"
lscpu | grep "Model name" | head -n 1

echo ""
echo "Memory Information:"
free -h

echo ""
echo "======================================"
echo "          PROGRAM COMPLETED"
echo "======================================"
