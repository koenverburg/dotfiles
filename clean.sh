#!/usr/bin/bash

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)

docker images
docker containers ls -a
