FROM centos:centos6
MAINTAINER yunsang.choi <oddpoet@gmail.com>

#=======================
# ENV
#=======================
ENV DOCKER_IMAGE_NAME oddpoet/redis-base
ENV DOCKER_IMAGE_TAG 2.8.17
ENV REDIS_VERSION 2.8.17

#=======================
# Install Redis
#=======================
COPY install.sh install.sh 
RUN /bin/bash install.sh 
