#
# Minimum Docker image to build Android AOSP
# Integrate JDK on top of ubuntu14.04
#
FROM shugaoye/docker-aosp:ubuntu14.04

MAINTAINER Roger Ye <shugaoye@yahoo.com>

ADD https://storage-googleapis.proxy.ustclug.org/git-repo-downloads/repo /usr/local/bin/
RUN chmod 755 /usr/local/bin/*

# Setup for Java
RUN echo oracle-java6-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections

# Install Oracle JDK 6
ADD https://downloads.sourceforge.net/project/byoh/jdk-6u45-linux-x64.bin /root/jdk-6u45-linux-x64.bin
RUN chmod 755 /root/jdk-6u45-linux-x64.bin
# COPY utils/jdk-6u45-linux-x64.bin /root/jdk-6u45-linux-x64.bin
RUN cd /opt;/root/jdk-6u45-linux-x64.bin
RUN sudo update-alternatives --install /usr/bin/javac javac /opt/jdk1.6.0_45/bin/javac 1
RUN sudo update-alternatives --install /usr/bin/java java /opt/jdk1.6.0_45/bin/java 1
RUN sudo update-alternatives --install /usr/bin/javaws javaws /opt/jdk1.6.0_45/bin/javaws 1

