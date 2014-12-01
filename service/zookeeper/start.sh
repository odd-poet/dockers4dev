#!/bin/sh

echo "###########################################################"
echo "         Zookeeper Server $ZOOKEEPER_VERSION (CDH-$CDH_VER)"
echo "###########################################################"
echo 
exit_with_usage() {
	echo "Usage: docker run DOCKER_OPTS ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} OPTIONS"
	echo 
	echo "Environment vars: "
	echo "  PORT=2181            zookeeper service port"
	echo 
	echo "Options:"
	echo "  -h,  --help          help message"
	echo "  shell                execute shell. should run docker with '-i -t'. (service will not be started)"
	echo 
	echo "Example: "
	echo "    docker run -d \\"
	echo "         -p 2181:12181 \\"
	echo "         -e PORT=12181 \\"
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
PORT=${PORT:-2181}

# check 
if [[ ! ("$PORT" =~ (^[0-9]+$)) ]];then 
	echo "> wrong port format: $PORT"
	echo 
	exit_with_usage
fi


echo "* starting zookeeper "
echo "* port : $PORT"
echo 
# change port
sed -i -r "s|clientPort=[0-9]+|clientPort=$PORT|" /etc/zookeeper/conf/zoo.cfg

# start
service zookeeper-server start

# check 
sleep 1
service zookeeper-server status
if [[ $? != 0 ]]; then 
	echo "zookeeper-server is not running. maybe something is wrong!"
	echo
	exit 1
fi

# infinite loop
while :; do sleep 5; done
