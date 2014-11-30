#!/bin/bash 

# delete exited containers.
docker rm $(docker ps -a -f "status=exited" -q)

# delete dangling images 
docker rmi $(docker images -a -q -f "dangling=true")