#!/bin/sh

echo "###########################################################"
echo "         Mesos-Master $MESOS_VERSION"
echo "###########################################################"
echo 
exit_with_usage() {
	echo "Usage: docker run DOCKER_OPTS ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} OPTIONS"
	echo 
	echo "Environment vars: "
	echo "  PORT=5050                          service port"
	echo "  ZK_URL=zk://localhost:2181/mesos   zookeeper url. "
	echo "                                     If you use default value, local zookeeper server will be start."
	echo 
	echo "Options:"
	echo "  -h,  --help                        help message"
	echo "  shell                              execute shell. should run docker with '-i -t'. (service will not be started)"
	echo 
	echo "Example: "
	echo "    docker run -d \\"
	echo "         -p 5050:5050 \\"
	echo "         -e PORT=5050 \\"
	echo "         -e ZK_URL=zk://zk-server1:2181,zk-server2:2181/mesos \\"
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
DEFAULT_ZK="zk://localhost:2181/mesos"
PORT=${PORT:-5050}
ZK_URL=${ZK_URL:-$DEFAULT_ZK}

# check 
if [[ ! ("$PORT" =~ (^[0-9]+$)) ]];then 
	echo "> wrong port format: $PORT"
	echo 
	exit_with_usage
fi
if [[ ! ("$ZK_URL" =~ (zk\://.+/.+)) ]];then 
	echo "> wrong zookeeper url : $ZK_URL"
	echo 
	exit_with_usage
fi


echo "* starting mesos master "
echo "* port : $PORT"
echo "* zookeeper : $ZK_URL"
echo 

# use local zk
if [[ "$ZK_URL" == $DEFAULT_ZK ]];then 
	echo "* starting local zookeeper ..."
	echo
	service zookeeper-server start
fi

# set zk for mesos
echo $ZK_URL > /etc/mesos/zk 

# start master 
unset MESOS_VERSION
sed -r -i "s|PORT=[0-9]+|PORT=$PORT|" /etc/default/mesos-master
mesos-init-wrapper master

