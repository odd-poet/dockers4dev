FROM oddpoet/zookeeper-base
MAINTAINER yunsang.choi <oddpoet@gmail.com>

#=======================
# ENV
#=======================
ENV DOCKER_IMAGE_NAME oddpoet/storm-base
ENV DOCKER_IMAGE_TAG 0.9.2
ENV STORM_VERSION 0.9.2

#=======================
# Install Redis
#=======================
COPY install.sh install.sh 
RUN /bin/bash install.sh 
