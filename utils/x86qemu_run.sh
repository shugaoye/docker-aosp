#!/bin/sh
ANDROID_IMAGE_PATH=/home/aosp/github/qemu_android
ANDROID_IMAGE_FILE=${ANDROID_IMAGE_PATH}/android-x86_64-6.0-r3.iso
QEMU_PATH=${ANDROID_IMAGE_PATH}/qemu/build/x86_64-softmmu
OUT=/home/aosp/android-x86/out/target/product/x86_64

${QEMU_PATH}/qemu-system-x86_64 \
	-enable-kvm \
	-m 1024 \
	-serial stdio \
	-netdev user,id=mynet,hostfwd=tcp::5400-:5555 \
	-device virtio-net-pci,netdev=mynet \
	-device virtio-mouse-pci -device virtio-keyboard-pci \
	-d guest_errors \
	-monitor telnet:127.0.0.1:1234,server,nowait \
	-device virtio-gpu-pci,virgl -spice port=5900,disable-ticketing \
	-cdrom  ${ANDROID_IMAGE_FILE} \
	-kernel $OUT/kernel \
	-initrd $OUT/initrd.img \
	-append "console=ttyS0 ip=dhcp androidboot.selinux=permissive buildvariant=eng androidboot.hardware=x86 DEBUG=2 SRC= DATA= android-x86vbox ROOT=/dev/ram0"

#	-tftp /home/aosp/TFTP/ \
#	-bootp tftp://10.0.2.2/pxelinux.0 \
#	-device VGA -spice port=5900,disable-ticketing

