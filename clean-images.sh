#!/bin/bash 

echo "Delete existed containers..."
if [[ $(docker ps -a -f "status=exited" -q) != "" ]]; then
	docker rm $(docker ps -a -f "status=exited" -q)
fi

echo "Delete dangling images..."
if [[ $(docker images -a -q -f "dangling=true") != "" ]]; then
	docker rmi $(docker images -a -q -f "dangling=true")
fi