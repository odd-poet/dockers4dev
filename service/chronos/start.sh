#!/bin/sh

echo "###########################################################"
echo "         Chronos $CHRONOS_VERSION"
echo "###########################################################"
echo 
exit_with_usage() {
	echo "Usage: docker run DOCKER_OPTS ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} OPTIONS"
	echo 
	echo "Environment vars: "
	echo "  PORT=8080                          service port"
	echo "  MASTER=zk://localhost:2181/mesos   zookeeper url for mesos master. "
	echo "                                     If you use default value, local zookeeper server will be start."
	echo "  ZK_HOSTS=localhost:2181            zookeeper server for storing state."           
	echo "                                     If you use default value, local zookeeper server will be start."
	echo "  ZK_PATH=/chronos/state             path in zookeeper for storing state"
	echo 
	echo "Options:"
	echo "  -h,  --help                        help message"
	echo "  shell                              execute shell. should run docker with '-i -t'. (service will not be started)"
	echo 
	echo "Example: "
	echo "    docker run -d \\"
	echo "         -p 8080:8080 \\"
	echo "         -e PORT=8080 \\"
	echo "         -e MATER=zk://zk-server:2181/mesos \\"
	echo "         -e ZK_HOSTS=zk-server:2181 \\"
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
DEFAULT_MASTER="zk://localhost:2181/mesos"
DEFAULT_ZK_HOSTS="localhost:2181"

PORT=${PORT:-8080}
MASTER=${MASTER:-$DEFAULT_MASTER}
ZK_HOSTS=${ZK_HOSTS:-$DEFAULT_ZK_HOSTS}
ZK_PATH=${ZK_PATH:-"/chronos/state"}

# check 
if [[ ! ("$PORT" =~ (^[0-9]+$)) ]];then 
	echo "> wrong port format: $PORT"
	echo 
	exit_with_usage
fi
if [[ ! ("$MASTER" =~ (zk\://.+/.+)) ]];then 
	echo "> wrong zookeeper url : $MASTER"
	echo 
	exit_with_usage
fi


echo "* starting chronos "
echo "* port : $PORT"
echo "* master : $MASTER"
echo "* zookeeper : zk://${ZK_HOSTS}${ZK_PATH}"
echo 

# use local zk
if [[ "$MASTER" == $DEFAULT_MASTER || "$ZK_HOSTS" == $DEFAULT_ZK_HOSTS ]];then 
	echo "* starting local zookeeper ..."
	echo
	service zookeeper-server start
fi

# start chronos
/chronos/bin/start-chronos.bash --http_port $PORT --master $MASTER --zk_hosts $ZK_HOSTS --zk_path $ZK_PATH 


