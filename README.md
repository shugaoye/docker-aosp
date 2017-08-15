Android Open Source Project Docker Build Environment
====================================================

Ubuntu 16.04 with packages for AOSP build enviornment. 
Oracle JDK 6 is installed in this image so it can be used to build from
Gingerbread to KitKat.

How to build it
---------------

There are two targets (aosp and test) in the Makefile. To build it, just checkout the repository
and run the below command:
$ make


How to test it
--------------

You can use the below command to test it.
$ make test
