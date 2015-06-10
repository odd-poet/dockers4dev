# centos with jdk7
FROM centos:centos6
MAINTAINER yunsang.choi <oddpoet@gmail.com>

#=======================
# ENV
#=======================
ENV DOCKER_IMAGE_NAME oddpoet/centos6-jdk8
ENV DOCKER_IMAGE_TAG 8u45

#=======================
# Install 
#=======================
COPY install.sh install.sh 
RUN /bin/bash install.sh