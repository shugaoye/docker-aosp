Android Open Source Project Docker Build Environment
====================================================

This is a project forked from kylemanna/docker-aosp.

I moved the source code and output in docker volume instead of inside
the container itself.

You can choose the build environment using either Ubuntu 14.04 or Ubuntu 16.04.
The environment can be customized based on which layer that you want to start
with. Using Ubuntu 16.04 as an example,

ubuntu16.04-m     - the image that you can use to build Mashmallow
ubuntu16.04-JDK8  - the image with JDK8
ubuntu16.04       - the base image

You can customize the build environment according to your own need.

If you are interested in Android System Programming, you can read
my book below:

[Android System Programming]: (https://www.amazon.com/Android-System-Programming-Roger-Ye-ebook/dp/B072M68RN9/ref=asap_bc?ie=UTF8 "Android System Programming")
[Embedded Programming with Android]: (https://www.amazon.com/Embedded-Programming-Android-Bringing-Scratch/dp/0134030001/ref=asap_bc?ie=UTF8 "Embedded Programming with Android")
