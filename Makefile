DOCKER = docker
IMAGE = shugaoye/docker-aosp:ubuntu14.04-JDK8

aosp: Dockerfile
	$(DOCKER) build -t $(IMAGE) .

test:
	docker run --name ubuntu14.04-JDK8 -v "$(HOME)/vol1:/root" -v "$(HOME)/.ccache:/tmp/ccache" -i -t $(IMAGE) /bin/bash

all: aosp

.PHONY: all
