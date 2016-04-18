NODE_VERSION=4.2.3
IMAGE_NAME=kreisys/node:${NODE_VERSION}

default: push

build:
	docker build -t ${IMAGE_NAME} --build-arg NODE_VERSION=${NODE_VERSION} .

push: build
	docker push ${IMAGE_NAME}

.PHONY: default push build
