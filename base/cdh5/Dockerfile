FROM oddpoet/centos6-jdk7
MAINTAINER yunsang.choi <oddpoet@gmail.com>

#=======================
# ENV
#=======================
ENV DOCKER_IMAGE_NAME oddpoet/cdh5-base
ENV DOCKER_IMAGE_TAG cdh5.2
ENV CDH_VER 5.2.0

#=======================
# Install HBase
#=======================
COPY install.sh install.sh 
RUN /bin/bash install.sh 
