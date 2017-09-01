#!/bin/sh

[ -e ${VOL1} ] && echo ${VOL1} || VOL1=${HOME}/vol1
[ -e ${VOL2} ] && echo ${VOL2} || VOL2=${HOME}/.ccache
USER_ID=`id -u`
GROUP_ID=`id -g`

if [ -n "$1" ]; then
	IMAGE=shugaoye/$1
else
	IMAGE=shugaoye/docker-spice:latest
fi
docker run --privileged -v "${VOL1}:/home/aosp" -v "${VOL2}:/tmp/ccache" -it -e USER_ID=${USER_ID} -e GROUP_ID=${GROUP_ID} ${IMAGE} /bin/bash
