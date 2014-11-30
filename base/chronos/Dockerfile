
FROM oddpoet/mesos-base
MAINTAINER yunsang.choi <oddpoet@gmail.com>

#=======================
# ENV
#=======================
ENV DOCKER_IMAGE_NAME oddpoet/chronos-base
ENV DOCKER_IMAGE_TAG 2.1.0

#=======================
# Install chronos
#=======================
COPY install.sh install.sh 
RUN /bin/bash install.sh 


