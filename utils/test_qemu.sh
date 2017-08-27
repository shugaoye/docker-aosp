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

AOSP_OUT=/home/aosp/m/out/target/product/x86_64qemu
IMG_TYPE=.qcow2

# Refer to Android emulator (ranchu) for the parameters
#	-drive if=none,overlap-check=none,cache=unsafe,index=4,id=sdcard,file=${AOSP_OUT}/sdcard.img${IMG_TYPE},l2-cache-size=1048576 
#	-device virtio-blk-pci,drive=sdcard,iothread=disk-iothread,modern-pio-notify 
x86qemu () {
	echo "Running default ...p0=$0 p1=$1 p2=$2 p3=$3"
	
	qemu-system-x86_64 \
	    -enable-kvm \
		-m 1024 \
		-serial stdio \
		-monitor telnet:127.0.0.1:1234,server,nowait \
		-netdev user,tftp=/home/aosp/TFTP/,bootfile=tftp://10.0.2.2/pxelinux.0,id=mynet,hostfwd=tcp::5400-:5555 \
		-device virtio-net-pci,netdev=mynet \
		-device virtio-mouse-pci -device virtio-keyboard-pci \
		-d guest_errors \
		-kernel ${AOSP_OUT}/kernel \
		-initrd ${AOSP_OUT}/initrd.img \
		-drive if=none,overlap-check=none,cache=unsafe,index=0,id=system,file=${AOSP_OUT}/system.img${IMG_TYPE} \
		-device virtio-blk-pci,drive=system,modern-pio-notify \
		-drive if=none,overlap-check=none,cache=unsafe,index=1,id=cache,file=${AOSP_OUT}/cache.img${IMG_TYPE},l2-cache-size=1048576 \
		-device virtio-blk-pci,drive=cache,modern-pio-notify \
		-drive if=none,overlap-check=none,cache=unsafe,index=2,id=userdata,file=${AOSP_OUT}/userdata.img${IMG_TYPE},l2-cache-size=1048576 \
		-device virtio-blk-pci,drive=userdata,modern-pio-notify \
		-append 'ip=dhcp console=ttyS0 rw androidboot.selinux=permissive androidboot.hardware=x86_64qemu ROOT=/dev/vda RAMDISK=vdd DATA=vdc' \
		-drive index=4,if=virtio,id=ramdisk,file=ramdisk.img,format=raw,readonly \
		-device virtio-gpu-pci,virgl -spice port=5900,disable-ticketing
}

x86qemu_pxe () {
	echo "Booting PXE ... p0=$0 p1=$1 p2=$2 p3=$3"

	qemu-system-x86_64 \
	    -enable-kvm \
		-m 1024 \
		-boot n \
		-serial stdio \
		-monitor telnet:127.0.0.1:1234,server,nowait \
		-netdev user,tftp=/home/aosp/TFTP/,bootfile=tftp://10.0.2.2/pxelinux.0,id=mynet,hostfwd=tcp::5400-:5555 \
		-device virtio-net-pci,netdev=mynet \
		-device virtio-mouse-pci -device virtio-keyboard-pci \
		-d guest_errors \
		-drive if=none,overlap-check=none,cache=unsafe,index=0,id=system,file=${AOSP_OUT}/system.img${IMG_TYPE} \
		-device virtio-blk-pci,drive=system,modern-pio-notify \
		-drive if=none,overlap-check=none,cache=unsafe,index=1,id=cache,file=${AOSP_OUT}/cache.img${IMG_TYPE},l2-cache-size=1048576 \
		-device virtio-blk-pci,drive=cache,modern-pio-notify \
		-drive if=none,overlap-check=none,cache=unsafe,index=2,id=userdata,file=${AOSP_OUT}/userdata.img${IMG_TYPE},l2-cache-size=1048576 \
		-device virtio-blk-pci,drive=userdata,modern-pio-notify \
		-drive index=4,if=virtio,id=ramdisk,file=ramdisk.img,format=raw,readonly \
		-device virtio-gpu-pci,virgl -spice port=5900,disable-ticketing
	
}

x86qemu_iso () {
	echo "Running ISO image ... p0=$0 p1=$1 p2=$2 p3=$3"
	
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
		-netdev user,tftp=/home/aosp/TFTP/,bootfile=tftp://10.0.2.2/pxelinux.0,id=mynet,hostfwd=tcp::5400-:5555 \
		-device virtio-net-pci,netdev=mynet \
		-device virtio-mouse-pci -device virtio-keyboard-pci \
		-d guest_errors \
		-cdrom  ${ANDROID_X86_IMAGE} \
		-drive if=none,overlap-check=none,cache=unsafe,index=0,id=system,file=${AOSP_OUT}/system.img${IMG_TYPE} \
		-device virtio-blk-pci,drive=system,modern-pio-notify \
		-drive if=none,overlap-check=none,cache=unsafe,index=1,id=cache,file=${AOSP_OUT}/cache.img${IMG_TYPE},l2-cache-size=1048576 \
		-device virtio-blk-pci,drive=cache,modern-pio-notify \
		-drive if=none,overlap-check=none,cache=unsafe,index=2,id=userdata,file=${AOSP_OUT}/userdata.img${IMG_TYPE},l2-cache-size=1048576 \
		-device virtio-blk-pci,drive=userdata,modern-pio-notify \
		-drive index=4,if=virtio,id=ramdisk,file=ramdisk.img,format=raw,readonly \
		-device virtio-gpu-pci,virgl -spice port=5900,disable-ticketing
}

#	-device VGA -spice port=5900,disable-ticketing
#	-netdev user,id=mynet,hostfwd=tcp::5400-:5555 -device virtio-net-pci,netdev=mynet \
#	-device virtio-gpu-pci,virgl -spice port=5900,disable-ticketing


case $0 in
        *iso)
		x86qemu_iso $0 $1 $2 $3
	;;
        *pxe)
		x86qemu_pxe $0 $1 $2 $3
	;;
	*)
		x86qemu $0 $1 $2 $3
	;;
esac
