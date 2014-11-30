FROM oddpoet/zookeeper-base:cdh5.2
MAINTAINER yunsang.choi <oddpoet@gmail.com>

#=======================
# ENV
#=======================
ENV DOCKER_IMAGE_NAME oddpoet/hbase-local-base
ENV DOCKER_IMAGE_TAG cdh5.2
ENV CDH_VER 5.2.0
ENV HBASE_VERSION 0.98.6
ENV HADOOP_VERSION 2.5.0

#=======================
# Install HBase
#=======================
COPY install.sh install.sh 
RUN /bin/bash install.sh 
