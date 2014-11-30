
FROM oddpoet/cdh5-base:cdh5.2
MAINTAINER yunsang.choi <oddpoet@gmail.com>

#=======================
# ENV
#=======================
ENV DOCKER_IMAGE_NAME oddpoet/zookeeper-base
ENV DOCKER_IMAGE_TAG cdh5.2
ENV CDH_VER 5.2.0
ENV ZOOKEEPER_VERSION 3.4.5

#=======================
# Install zookeeper
#=======================
COPY install.sh install.sh
RUN /bin/bash install.sh