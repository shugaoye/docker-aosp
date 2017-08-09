#
# Minimum Docker image to build Android AOSP
#
FROM ubuntu:14.04

MAINTAINER Roger Ye <shugaoye@yahoo.com>

# Setup for Java
RUN echo oracle-java6-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections

# /bin/sh points to Dash by default, reconfigure to use bash until Android
# build becomes POSIX compliant
RUN echo "dash dash/sh boolean false" | debconf-set-selections && \
    dpkg-reconfigure -p critical dash

# Keep the dependency list as short as reasonable
RUN apt-get update && \
    apt-get install -y bc bison bsdmainutils build-essential curl \
        flex g++-multilib gcc-multilib git gnupg gperf lib32ncurses5-dev \
        lib32readline-gplv2-dev lib32z1-dev libesd0-dev libncurses5-dev \
        libsdl1.2-dev libwxgtk2.8-dev libxml2-utils lzop \
        pngcrush schedtool xsltproc zip zlib1g-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD https://storage-googleapis.proxy.ustclug.org/git-repo-downloads/repo /usr/local/bin/
RUN chmod 755 /usr/local/bin/*

# All builds will be done by user aosp
ADD gitconfig /root/.gitconfig
ADD ssh_config /root/.ssh/config

# Install Oracle JDK 6
ADD https://downloads.sourceforge.net/project/byoh/jdk-6u45-linux-x64.bin /root/jdk-6u45-linux-x64.bin
RUN chmod 755 /root/jdk-6u45-linux-x64.bin
# COPY utils/jdk-6u45-linux-x64.bin /root/jdk-6u45-linux-x64.bin
RUN cd /opt;/root/jdk-6u45-linux-x64.bin
RUN sudo update-alternatives --install /usr/bin/javac javac /opt/jdk1.6.0_45/bin/javac 1
RUN sudo update-alternatives --install /usr/bin/java java /opt/jdk1.6.0_45/bin/java 1
RUN sudo update-alternatives --install /usr/bin/javaws javaws /opt/jdk1.6.0_45/bin/javaws 1

# The persistent data will be in these two directories, everything else is
# considered to be ephemeral
VOLUME ["/tmp/ccache", "/home/aosp"]

# Improve rebuild performance by enabling compiler cache
ENV USE_CCACHE 1
ENV CCACHE_DIR /tmp/ccache

# Work in the build directory, repo is expected to be init'd here
WORKDIR /home/aosp

COPY utils/docker_entrypoint.sh /root/docker_entrypoint.sh
ENTRYPOINT ["/root/docker_entrypoint.sh"]
