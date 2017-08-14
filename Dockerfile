#
# Minimum Docker image to build Android AOSP
# Integrate JDK on top of ubuntu16.04
#
FROM shugaoye/docker-aosp:ubuntu16.04

MAINTAINER Roger Ye <shugaoye@yahoo.com>

ADD https://storage-googleapis.proxy.ustclug.org/git-repo-downloads/repo /usr/local/bin/
RUN chmod 755 /usr/local/bin/*

# Install Open JDK 7
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:openjdk-r/ppa
RUN apt-get update && \
    apt-get install -y openjdk-7-jdk && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

