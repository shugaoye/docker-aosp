#!/bin/sh
#******************************************************************************
#
# Android System Programming
# Script to execute x86_64qemu device
#
# Copyright (c) 2017 Roger Ye.  All rights reserved.
# Software License Agreement
# 
# 
# THIS SOFTWARE IS PROVIDED "AS IS" AND WITH ALL FAULTS.
# NO WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT
# NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE. The AUTHOR SHALL NOT, UNDER
# ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR CONSEQUENTIAL
# DAMAGES, FOR ANY REASON WHATSOEVER.
#
#******************************************************************************
#
# connect to the display using the following command:
# $ remote-viewer spice://172.17.0.2:5900/
# To start the environment from PXE, create a symbolic link of this script as
# x86qemu_pxe.
# To start the environment from ISO image, create a symbolic link of this
# script as x86qemu_iso.
#

x86qemu_pxe () {

	qemu-system-x86_64 \
	    -enable-kvm \
		-m 1024 \
		-boot n \
		-serial stdio \
		-netdev user,tftp=/home/aosp/TFTP/,bootfile=tftp://10.0.2.2/pxelinux.0,id=mynet,hostfwd=tcp::5400-:5555 \
		-device virtio-net-pci,netdev=mynet \
		-device virtio-mouse-pci -device virtio-keyboard-pci \
		-d guest_errors \
		-monitor telnet:127.0.0.1:1234,server,nowait \
		-device virtio-gpu-pci,virgl -spice port=5900,disable-ticketing
	
}

x86qemu_iso () {
	echo "p0=$0 p1=$1 p2=$2 p3=$3"
	if [ -n "$1" ]; then
		ANDROID_X86_IMAGE=$2
		echo "ANDROID_X86_IMAGE=$2"
		QEMU_PATH=/usr/local/bin
	else
		ANDROID_IMAGE_PATH=/home/aosp/github/qemu_android
		ANDROID_X86_IMAGE=${ANDROID_IMAGE_PATH}/android-x86_64-6.0-r3.iso
		QEMU_PATH=${ANDROID_IMAGE_PATH}/qemu/build/x86_64-softmmu
	fi
	
	
	qemu-system-x86_64 \
	    -enable-kvm \
		-m 1024 \
		-serial stdio \
		-monitor telnet:127.0.0.1:1234,server,nowait \
		-netdev user,id=mynet,hostfwd=tcp::5400-:5555 -device virtio-net-pci,netdev=mynet \
		-device virtio-mouse-pci -device virtio-keyboard-pci \
		-d guest_errors \
		-cdrom  ${ANDROID_X86_IMAGE} \
		-device VGA -spice port=5900,disable-ticketing
}

#	-netdev user,id=mynet,hostfwd=tcp::5400-:5555 -device virtio-net-pci,netdev=mynet \
#	-device virtio-gpu-pci,virgl -spice port=5900,disable-ticketing


case $0 in
        *iso)
		echo "Running ISO image ... $0"
		x86qemu_iso $0 $1 $2 $3
	;;
        *pxe)
		echo "Booting PXE ... $0"
		x86qemu_pxe $0 $1 $2 $3
	;;
	*)
		echo "Running default ...$0"
	;;
esac
