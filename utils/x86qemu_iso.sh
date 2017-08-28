#!/bin/sh

ANDROID_IMAGE_PATH=/home/aosp/github/qemu_android/android-x86_64-6.0-r3.iso
# ANDROID_IMAGE_PATH=/home/aosp/android-x86/out/target/product/x86_64/android_x86_64.iso

QEMU_PATH=/home/aosp/github/qemu_android/qemu/build/x86_64-softmmu

${QEMU_PATH}/qemu-system-x86_64 \
    -enable-kvm \
	-m 1024 \
	-serial stdio \
	-netdev user,id=mynet,hostfwd=tcp::5400-:5555 \
	-device virtio-net-pci,netdev=mynet \
	-device virtio-mouse-pci -device virtio-keyboard-pci \
	-cdrom  ${ANDROID_IMAGE_PATH} \
	-d guest_errors \
	-monitor telnet:127.0.0.1:1234,server,nowait \
	-device virtio-gpu-pci,virgl -spice port=5900,disable-ticketing

#	-append "console=ttyS0 rw" \
#	-device VGA -spice port=5900,disable-ticketing

