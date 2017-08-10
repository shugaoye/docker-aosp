Android Open Source Project Docker Build Environment
====================================================

Ubuntu 16.04 with packages for AOSP build enviornment installed except JDK. 
This image can be used as the basic layer for the AOSP build environment.

How to build it
---------------

There are two targets (aosp and test) in the Makefile. To build it, just checkout the repository
and run the below command:
$ make


How to test it
--------------

You can use the below command to test it.
$ make test
