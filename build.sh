#!/bin/bash

# Login to Docker
echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin

# Build image
docker build -t ${DOCKER_USERNAME}/${IMAGE} .

# Tag image and upload to Dockerhub
docker tag ${DOCKER_USERNAME}/${IMAGE} ${DOCKER_USERNAME}/${IMAGE}:latest
docker push ${DOCKER_USERNAME}/${IMAGE}:latest
