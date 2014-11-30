#!/bin/sh

echo "###########################################################"
echo "         Redis Server $REDIS_VERSION"
echo "###########################################################"
echo 
exit_with_usage() {
	echo "Usage: docker run DOCKER_OPTS ${DOCKER_IMAGE_NAME} OPTIONS"
	echo 
	echo "Environment: "
	echo "  PORT=6379            redis service port"
	echo 
	echo "Options:"
	echo "  -h,  --help          help message"
	echo "  shell                execute shell. should run docker with '-i -t'. (service will not be started)"
	echo 
	echo "Example: "
	echo "    docker run -d \\"
	echo "         -p 16379:6379 \\"
	echo "         -e PORT=6379 \\"
	echo "         ${DOCKER_IMAGE_NAME}"
	exit 1
}

# parse option
while [[ $# > 0 ]];do 
	arg="$1"
	shift
	case $arg in 
		-h|--help)
			exit_with_usage
			;;
		shell)
			/bin/bash 
			exit
			;;
		*)
			;;
	esac
done

# default
PORT=${PORT:-6379}

# check 
if [[ ! ("$PORT" =~ (^[0-9]+$)) ]];then 
	echo "> wrong port format: $PORT"
	echo 
	exit_with_usage
fi


echo "* starting redis "
echo "* port : $PORT"
echo 

# start
redis-server --port $PORT

