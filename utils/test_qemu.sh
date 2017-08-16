#!/bin/sh
ANDROID_IMAGE_PATH=/home/aosp/github/qemu_android
QEMU_PATH=${ANDROID_IMAGE_PATH}/qemu/build/x86_64-softmmu

${QEMU_PATH}/qemu-system-x86_64 \
    -enable-kvm \
	-m 1024 \
	-serial stdio \
	-netdev user,id=mynet,hostfwd=tcp::5400-:5555 -device virtio-net-pci,netdev=mynet \
	-device virtio-mouse-pci -device virtio-keyboard-pci \
	-d guest_errors \
	-cdrom  ${ANDROID_IMAGE_PATH}/android-x86_64-6.0-r3.iso\
	-device VGA -spice port=5900,disable-ticketing

#	-device virtio-gpu-pci,virgl -spice port=5900,disable-ticketing

