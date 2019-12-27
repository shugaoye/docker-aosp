#
# Minimum Docker image to build Android AOSP
#
FROM shugaoye/docker-aosp:ubuntu14.04-k

MAINTAINER Roger Ye <shugaoye@yahoo.com>

RUN apt-get update -qq && \
    apt-get -y upgrade -qq
RUN apt-get install -y make unzip wget autoconf tree

# The persistent data will be in these two directories, everything else is
# considered to be ephemeral
VOLUME ["/tmp/ccache", "/home/aosp"]

# Improve rebuild performance by enabling compiler cache
ENV USE_CCACHE 1
ENV CCACHE_DIR /tmp/ccache

# Work in the build directory, repo is expected to be init'd here
WORKDIR /home/aosp

COPY utils/bash.bashrc /root/bash.bashrc
RUN chmod 755 /root /root/bash.bashrc
COPY utils/docker_entrypoint.sh /root/docker_entrypoint.sh
ENTRYPOINT ["/root/docker_entrypoint.sh"]
