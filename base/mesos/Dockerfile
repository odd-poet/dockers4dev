
FROM oddpoet/zookeeper-base
MAINTAINER yunsang.choi <oddpoet@gmail.com>

#=======================
# ENV
#=======================
ENV DOCKER_IMAGE_NAME oddpoet/mesos-base
ENV DOCKER_IMAGE_TAG 0.21.0
ENV MESOS_VERSION 0.21.0

#=======================
# Install mesos
#=======================
COPY install.sh install.sh 
RUN /bin/bash install.sh 
