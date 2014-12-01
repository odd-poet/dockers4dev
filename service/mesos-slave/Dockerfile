FROM oddpoet/mesos-base:0.21.0
MAINTAINER yunsang.choi <oddpoet@gmail.com>

#=======================
# ENV
#=======================
ENV DOCKER_IMAGE_NAME oddpoet/mesos-slave
ENV DOCKER_IMAGE_TAG 0.21.0
ENV MESOS_VERSION 0.21.0

#=======================
# Start services.
#=======================
COPY start.sh start.sh
ENTRYPOINT ["/bin/bash", "start.sh"]
