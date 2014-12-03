#!/bin/sh

echo "###########################################################"
echo "         Chronos $CHRONOS_VERSION"
echo "###########################################################"
echo 
exit_with_usage() {
	echo "Usage: docker run DOCKER_OPTS ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} OPTIONS"
	echo 
	echo "Environment vars: "
	echo "  PORT=8080                          chronos port"
	echo "  MESOS_MASTER_PORT=5050             mesos master port"
	echo "  MESOS_SLAVE_PORT=5051              mesos slave port"
	echo 
	echo "Options:"
	echo "  -h,  --help                        help message"
	echo "  shell                              execute shell. should run docker with '-i -t'. (service will not be started)"
	echo 
	echo "Example: "
	echo "    docker run -d \\"
	echo "         -p 8080:8080 \\"
	echo "         -p 5050:5050 \\"
	echo "         -p 5051:5051 \\"
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
unset MESOS_VERSION

# default
PORT=${PORT:-8080}
MESOS_MASTER_PORT=${MESOS_MASTER_PORT:-5050}
MESOS_SLAVE_PORT=${MESOS_SLAVE_PORT:-5051}

# check 
if [[ ! ("$PORT" =~ (^[0-9]+$)) ]];then 
	echo "> wrong port format: $PORT"
	echo 
	exit_with_usage
fi
if [[ ! ("$MESOS_MASTER_PORT" =~ (^[0-9]+$)) ]];then 
	echo "> wrong port format: $MESOS_MASTER_PORT"
	echo 
	exit_with_usage
fi
if [[ ! ("$MESOS_SLAVE_PORT" =~ (^[0-9]+$)) ]];then 
	echo "> wrong port format: $MESOS_SLAVE_PORT"
	echo 
	exit_with_usage
fi


echo "* starting chronos "
echo "* port : $PORT"
echo "* mesos master port : $MESOS_MASTER_PORT"
echo "* mesos slave port : $MESOS_SLAVE_PORT"
echo 

# use local zk
echo " > starting zookeeper"
service zookeeper-server start

ZK_URL="zk://localhost:2181/mesos"
# start mesos master
echo $ZK_URL > /etc/mesos/zk 

# start master 

sed -r -i "s|PORT=[0-9]+|PORT=$MESOS_MASTER_PORT|" /etc/default/mesos-master
mesos-init-wrapper master &

# start mesos slave
echo "$MESOS_SLAVE_PORT" > /etc/mesos-slave/port
mesos-init-wrapper slave &

# start chronos
/chronos/bin/start-chronos.bash --http_port $PORT --master $ZK_URL --zk_hosts localhost:2181 --zk_path /chronos/status 


