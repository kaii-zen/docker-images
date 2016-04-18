PYTHON_VERSION=2.7.11
IMAGE_NAME=kreisys/python:${PYTHON_VERSION}

default: push

build:
	docker build -t ${IMAGE_NAME} --build-arg PYTHON_VERSION=${PYTHON_VERSION} .

push: build
	docker push ${IMAGE_NAME}
