#!/bin/sh

echo "###########################################################"
echo "         Go-Agent $DOCKER_IMAGE_TAG"
echo "###########################################################"
echo 
exit_with_usage() {
	echo "Usage: docker run DOCKER_OPTS ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} OPTIONS"
	echo 
	echo "Environment: "
	echo "  GO_SERVER=127.0.0.1            go server"
	echo "  PROXY_SERVER=                  proxy server (e.g. http://1.2.3.4:80/"
	echo 
	echo "Options:"
	echo "  -h,  --help          help message"
	echo "  shell                execute shell. should run docker with '-i -t'. (service will not be started)"
	echo 
	echo "Example: "
	echo "    docker run -d \\"
	echo "         -p 6379:6379 \\"
	echo "         -e PORT=6379 \\"
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
GO_SERVER=${GO_SERVER:-127.0.0.1}
PROXY_SERVER=${PROXY_SERVER:-}

# config 
sed -i.bak -e s/GO_SERVER=127.0.0.1/GO_SERVER=$GO_SERVER/g /etc/default/go-agent
if [[ "$PROXY_SERVER" == "" ]];then
	echo "export http_proxy=$PROXY_SERVER" >> /etc/default/go-agent
	echo "export https_proxy=$PROXY_SERVER" >> /etc/default/go-agent
fi

# start go-agent
service go-agent start 

# infinite loop
while :; do sleep 5; done

