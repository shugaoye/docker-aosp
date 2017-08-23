#!/bin/sh
ANDROID_IMAGE_PATH=/home/aosp/github/qemu_android
QEMU_PATH=${ANDROID_IMAGE_PATH}/qemu/build/x86_64-softmmu

${QEMU_PATH}/qemu-system-x86_64 \
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

#	-tftp /home/aosp/TFTP/ \
#	-bootp tftp://10.0.2.2/pxelinux.0 \
#	-device VGA -spice port=5900,disable-ticketing

