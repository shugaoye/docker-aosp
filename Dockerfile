#
# Minimum Docker image to build Android AOSP
# Integrate JDK on top of ubuntu14.04
#
FROM shugaoye/docker-aosp:ubuntu14.04

MAINTAINER Roger Ye <shugaoye@yahoo.com>

# Setup for Java
RUN apt-get update && \
    apt-get install -y java-common liblcms2-2 libnss3 libpcsclite1 libxtst6 ca-certificates-java libatk-wrapper-java-jni libgif4
    
ADD https://storage-googleapis.proxy.ustclug.org/git-repo-downloads/repo /usr/local/bin/
RUN chmod 755 /usr/local/bin/*

ADD http://archive.ubuntu.com/ubuntu/pool/universe/o/openjdk-8/openjdk-8-jre-headless_8u45-b14-1_amd64.deb /root/openjdk-8-jre-headless_8u45-b14-1_amd64.deb
ADD http://archive.ubuntu.com/ubuntu/pool/universe/o/openjdk-8/openjdk-8-jre_8u45-b14-1_amd64.deb /root/openjdk-8-jre_8u45-b14-1_amd64.deb
ADD http://archive.ubuntu.com/ubuntu/pool/universe/o/openjdk-8/openjdk-8-jdk_8u45-b14-1_amd64.deb /root/openjdk-8-jdk_8u45-b14-1_amd64.deb

RUN dpkg -i /root/openjdk-8-jre-headless_8u45-b14-1_amd64.deb
RUN dpkg -i /root/openjdk-8-jre_8u45-b14-1_amd64.deb
RUN dpkg -i /root/openjdk-8-jdk_8u45-b14-1_amd64.deb
RUN apt-get -f install
