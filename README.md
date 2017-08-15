Android Open Source Project Docker Build Environment
====================================================

AOSP build environment for KitKat in Ubuntu 16.04.

How to build it
---------------

There are two targets (aosp and test) in the Makefile. To build it, just checkout the repository
and run the below command:
$ make


How to test it
--------------

You can use the below command to test it.
$ make test

This target executes the below command:
$ docker run -v "$(VOL1):/root" -v "$(VOL2):/tmp/ccache" -it -e USER_ID=$(id -u) -e GROUP_ID=$(id -g) $(IMAGE) /bin/bash

It will set two data volumes. 
VOL1 - the working directory for the build
VOL2 - the cache directory for ccache

You can define your own user and group using environment varialbles or it will setup the current user in the container.
