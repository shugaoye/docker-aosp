#
# Minimum Docker image to build Android AOSP
#
FROM ubuntu:16.04

MAINTAINER Roger Ye <shugaoye@yahoo.com>

COPY utils/sources.list /etc/apt/sources.list

# /bin/sh points to Dash by default, reconfigure to use bash until Android
# build becomes POSIX compliant
RUN echo "dash dash/sh boolean false" | debconf-set-selections && \
    dpkg-reconfigure -p critical dash

# Keep the dependency list as short as reasonable
RUN apt-get update && \
    apt-get install -y bc bison bsdmainutils build-essential curl \
        flex g++-multilib gcc-multilib git gnupg gperf lib32ncurses5-dev \
        lib32z1-dev libesd0-dev libncurses5-dev \
        libsdl1.2-dev libwxgtk3.0-dev libxml2-utils lzop sudo \
        pngcrush schedtool xsltproc zip zlib1g-dev graphviz && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# All builds will be done by user aosp
COPY gitconfig /root/.gitconfig
COPY ssh_config /root/.ssh/config

