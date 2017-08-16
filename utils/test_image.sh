#!/bin/sh

VOL1=${HOME}/vol1
VOL2=${HOME}/.ccache
USER_ID=`id -u`
GROUP_ID=`id -g`

if [ -n "$1" ]; then
	IMAGE=shugaoye/docker-aosp:$1
else
	IMAGE=shugaoye/aosp:ubuntu16.04-qemu_android
fi
docker run --privileged -v "${VOL1}:/home/aosp" -v "${VOL2}:/tmp/ccache" -it -e USER_ID=${USER_ID} -e GROUP_ID=${GROUP_ID} ${IMAGE} /bin/bash
