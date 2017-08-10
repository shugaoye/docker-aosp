#
# Makefile to build and test docker containers
#   VOL1 - the one used to build source code
#   VOL2 - the one used to store build cache
# Both can be defined in your environment, otherwise the below default values
# will be used.

DOCKER = docker
IMAGE = shugaoye/docker-aosp:ubuntu16.04-JDK8
VOL1 ?= $(HOME)/vol1
VOL2 ?= $(HOME)/.ccache

aosp: Dockerfile
	$(DOCKER) build -t $(IMAGE) .

test:
	$(DOCKER) run -v "$(VOL1):/root" -v "$(VOL2):/tmp/ccache" -i -t $(IMAGE) /bin/bash

all: aosp

.PHONY: all
