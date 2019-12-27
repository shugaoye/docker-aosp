AOSP Docker Build Environment
====================================================

iPerf/iPerf3 build environment using Android NDK in Ubuntu 14.04. Please refer to [android-iperf](https://github.com/shugaoye/android-iperf) about how to build iPerf for Android.

How to build it
---------------

There are two targets (aosp and test) in the Makefile. To build it, just checkout the repository
and run the below command:
```
$ make
```

How to test it
--------------

You can use the below command to test it.
```
$ make test
```

This target executes the below command:
$ docker run -v "$(VOL1):/root" -v "$(VOL2):/tmp/ccache" -it -e USER_ID=$(id -u) -e GROUP_ID=$(id -g) $(IMAGE) /bin/bash

It will set two data volumes. 
VOL1 - the working directory for the build
VOL2 - the cache directory for ccache

You can define your own user and group using environment varialbles or it will setup the current user in the container.

Build iPerf
-----------
To build iPerf, you can follow the below steps.
1. Download and install Android NDK in VOL1. 
2. Start the container and set the below environment variables.
```
export ANDROID_NDK_VERSION=r10e
export ANDROID_NDK_HOME=/home/aosp/android-ndk-r10e

export PATH=${PATH}:${ANDROID_NDK_HOME}
```
3. Download iPerf and android-iperf source code and build in the container
```
$ cd $HOME
$ mkdir src
$ git clone https://github.com/shugaoye/android-iperf.git
$ wget -q -O iperf-2.0.5.tar.gz https://iperf.fr/download/source/iperf-2.0.5-source.tar.gz && \
    tar -zxvf iperf-2.0.5.tar.gz && \
    rm -f iperf-2.0.5.tar.gz
$ mkdir jni
$ cp android-iperf/jni/*.mk jni/*.mk
$ cp android-iperf/iperf-2.0.5/Android.mk iperf-2.0.5/Android.mk
$ cd iperf-2.0.5 && \
    autoconf && \
    ./configure
$ ndk-build clean
$ ndk-build
```
To use a specific version of NDK, you can edit jni/Application.mk. To build a specific version of iPerf, please change the path of source code in jni/Android.mk.

Notes:
You may get the following error.
```
/home/aosp/src/iperf-3.2/src/cjson.c:207: error: undefined reference to 'localeconv'
clang++: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [obj/local/armeabi-v7a/iperf3.2] Error 1
```

For iPerf 3.2 or above, we can only compile for Android API level 21 (Android 5.0) or above. For old Android system, we can build iperf 2.0.5 or 3.1.6.
