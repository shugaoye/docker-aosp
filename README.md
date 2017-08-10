Android Open Source Project Docker Build Environment
====================================================

Ubuntu 16.04 with packages for AOSP build enviornment.
Open JDK 8 is installed in this image so it can be used to build Nougat.

How to build it
---------------

There are two targets (aosp and test) in the Makefile. To build it, just checkout the repository
and run the below command:
$ make


How to test it
--------------

You can use the below command to test it.
$ make test
