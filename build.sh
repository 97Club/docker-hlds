#!/bin/bash

IMAGE=chenyu1990/cs1.6
VERSION=8196

docker build -t $IMAGE:$VERSION . 
# docker tag $IMAGE:$VERSION $IMAGE:latest

# docker images
docker push $IMAGE:$VERSION
docker push $IMAGE:latest


# docker run -d \
#     -p 27015:27015 -p 27015:27015/udp \
#     --name cs1.6-kz-server \
#     $IMAGE:$VERSION
