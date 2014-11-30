#!/bin/bash 

CURPATH=$(cd $(dirname $0); pwd)

inspect_env_value() {
	local img_name=$1
	local env_key=$2
	local matched
	matched=$(docker inspect ${img_name} | grep -o -E "${env_key}=[^\"]*" | uniq)
	echo ${matched#*=}
}

build_docker() {
	local path=$1
	local img_name
	local img_tag
	cd $path
	dirname=$(basename $path)
	tmp_name="${dirname}-$RANDOM"

	echo 
	echo "Build image : $tmp_name"
	echo "-------------------------"
	docker build --rm -t $tmp_name . # | read line; echo "$dirname> $line"
	echo 
	echo "Finished "
	echo 

	img_name=$(inspect_env_value $tmp_name "DOCKER_IMAGE_NAME")
	img_tag=$(inspect_env_value $tmp_name "DOCKER_IMAGE_TAG")
	echo "* image name : ${img_name}:${img_tag}"
	echo "* dirname : ${dirname}"
	echo "* tmp_name : ${tmp_name}"
	
	if [[ "$img_name" == "" && "$img_tag" == "" ]];then
		docker tag ${tmp_name} ${dirname}:latest
		docker rmi ${tmp_name}
	else
		img_name=${img_name:-$dirname}
		img_tag=${img_tag:-"latest"}
		echo 
		echo " * Image name : $img_name:$img_tag"
		echo 
		docker tag ${tmp_name} ${img_name}:${img_tag}
		# docker push ${img_name}:${img_tag}
		docker tag ${tmp_name} ${img_name}:latest
		# docker push ${img_name}:latest
		docker rmi ${tmp_name}
	fi
}

build_all() {
	build_docker $CURPATH/centos6-jdk7
	build_docker $CURPATH/cdh5
	build_docker $CURPATH/zookeeper
	build_docker $CURPATH/hbase-local
	build_docker $CURPATH/redis
	build_docker $CURPATH/mesos
	build_docker $CURPATH/chronos
	build_docker $CURPATH/storm
	
	# for docker in `find $CURPATH -name Dockerfile` ;do 
	# 	docker_path=$(dirname $docker)
	# 	build_docker $docker_path 
	# done
}

if [[ $# != 1 ]];then 
	echo "Usage: $(basename $0) all or PATH"
	echo "    all        build all docker images in subdir."
	echo "    PATH       build a docker image for given path"
	echo 
	exit 1
fi

case "$1" in 
	all)
		build_all
		;;
	*)
		path=$(cd $1;pwd)
		build_docker $path
esac
