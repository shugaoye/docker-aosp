DOCKER = docker
IMAGE = shugaoye/docker-aosp:ubuntu16.04-JDK7

aosp: Dockerfile
	$(DOCKER) build -t $(IMAGE) .

test:
	docker run -v "$(HOME)/vol1:/root" -v "$(HOME)/.ccache:/tmp/ccache" -i -t $(IMAGE) /bin/bash

all: aosp

.PHONY: all
