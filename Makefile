DOCKER = docker
IMAGE = shugaoye/docker-aosp:ubuntu14.04-JDK6

aosp: Dockerfile
	$(DOCKER) build -t $(IMAGE) .

test:
	docker run -v "$(HOME)/vol1:/root" -v "$(HOME)/.ccache:/tmp/ccache" -i -t $(IMAGE) /bin/bash

all: aosp

.PHONY: all
