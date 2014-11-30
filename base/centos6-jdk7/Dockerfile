# centos with jdk7
FROM centos:centos6
MAINTAINER yunsang.choi <oddpoet@gmail.com>

#=======================
# ENV
#=======================
ENV DOCKER_IMAGE_NAME oddpoet/centos6-jdk7
ENV DOCKER_IMAGE_TAG 7u71

#=======================
# Install 
#=======================
COPY install.sh install.sh 
RUN /bin/bash install.sh