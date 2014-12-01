#!/bin/sh
#!/bin/sh

echo "###########################################################"
echo "        HBase (CHD-$CDH_VER) : pseudo-distributed mode  "
echo "###########################################################"
echo 

exit_with_usage() {
	echo "Usage: docker run DOCKER_OPTS ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} OPTIONS"
	echo 
	echo "Environment vars:"
	echo "  --ZK_HOSTS=localhost                   hbase.zookeeper.quorum." 
	echo "                                         If you use default value(localhost), local zookeeper-server will be run."
	echo "  --MASTER_PORT=60000                    hbase.master.port"
	echo "  --MASTER_INFO_PORT=60010               hbase.master.info.port"
	echo "  --REGIONSERVER_PORT=60000              hbase.regionserver.port"
	echo "  --REGIONSERVER_INFO_PORT=60010         hbase.regionserver.info.port"
	echo
	echo "Options: "
	echo "  -h,  --help                            help message"
	echo "  shell                                  execute shell. should run docker with '-i -t'. (service will not be started)"
	echo 
	echo "Example: "
	echo "    docker run \\"
	echo "         -d -h hbase \\"
	echo "         -p 65000:65000 -p 65010:65010 \\"
	echo "         -p 65020:65020 -p 65030:65030 \\"
	echo "         -p 2181:2181 \\"
	echo "         -e MASTER_PORT=65000 \\"
	echo "         -e MASTER_INFO_PORT=65010 \\"
	echo "         -e REGIONSERVER_PORT=65020 \\"
	echo "         -e REGIONSERVER_INFO_PORT=65030 \\"
	echo "         ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} "
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
			exit 0;
			;;
	esac
done

# default
ZK_HOSTS=${ZK_HOSTS:-"localhost"}
MASTER_PORT=${MASTER_PORT:-60000}
MASTER_INFO_PORT=${MASTER_INFO_PORT:-60010}
REGIONSERVER_PORT=${REGIONSERVER_PORT:-60020}
REGIONSERVER_INFO_PORT=${REGIONSERVER_INFO_PORT:-60030}

# check 
if [[ ! ("$MASTER_PORT" =~ (^[0-9]+$)) ]];then 
	echo "> wrong master port : $MASTER_PORT"
	echo 
	exit_with_usage
fi
if [[ ! ("$MASTER_INFO_PORT" =~ (^[0-9]+$)) ]];then 
	echo "> wrong master info port : $MASTER_INFO_PORT"
	echo 
	exit_with_usage
fi
if [[ ! ("$REGIONSERVER_PORT" =~ (^[0-9]+$)) ]];then 
	echo "> wrong regionserver port : $REGIONSERVER_PORT"
	echo 
	exit_with_usage
fi
if [[ ! ("$REGIONSERVER_INFO_PORT" =~ (^[0-9]+$)) ]];then 
	echo "> wrong regionserver info port : $REGIONSERVER_INFO_PORT"
	echo 
	exit_with_usage
fi

# start...
echo "* starting hbase : pseudo-distributed mode"
echo "* zookeeper hosts : $ZK_HOSTS"
echo "* master port : $MASTER_PORT"
echo "* master info port : $MASTER_INFO_PORT"
echo "* regionserver port : $REGIONSERVER_PORT"
echo "* regionserver info port : $REGIONSERVER_INFO_PORT"

# use local zk
if [[ "$ZK_HOSTS" == "localhost" ]];then 
	echo "* starting local zookeeper ..."
	echo
	service zookeeper-server start
fi

# set config
sed -i -r "s|#ZOOKEEPER#|$ZK_HOSTS|" /etc/hbase/conf/hbase-site.xml 
sed -i -r "s|#MASTER_PORT#|$MASTER_PORT|" /etc/hbase/conf/hbase-site.xml 
sed -i -r "s|#MASTER_INFO_PORT#|$MASTER_INFO_PORT|" /etc/hbase/conf/hbase-site.xml 
sed -i -r "s|#REGIONSERVER_PORT#|$REGIONSERVER_PORT|" /etc/hbase/conf/hbase-site.xml 
sed -i -r "s|#REGIONSERVER_INFO_PORT#|$REGIONSERVER_INFO_PORT|" /etc/hbase/conf/hbase-site.xml 

echo "> start hadoop"
for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do 
	service $x start &
done

echo "> start regionserver"
service hbase-regionserver start &

echo "> start master"
service hbase-master start &

# infinite loop
while :; do sleep 5; done
