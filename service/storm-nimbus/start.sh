#!/bin/sh

echo "###########################################################"
echo "         Storm Nimbus $STORM_VERSION"
echo "###########################################################"
echo 
exit_with_usage() {
	echo "Usage: docker run DOCKER_OPTS ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} OPTIONS"
	echo 
	echo "Options:"
	echo "  -h,  --help          help message"
	echo "  shell                execute shell. should run docker with '-i -t'. (service will not be started)"
	echo 
	echo "Notice: To configure storm, you can mount your storm config dir to '/storm/conf'."
	echo 
	echo "Example: "
	echo "    docker run -d \\"
	echo "         -p 6627:6627 \\"
	echo "         -v \"/path/to/storm/conf:/storm/conf\""
	echo "         ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
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


echo "* starting storm-nimbus "
echo 

# start
/storm/bin/storm nimbus
