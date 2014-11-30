
FROM oddpoet/zookeeper-base:cdh5.2
MAINTAINER yunsang.choi <oddpoet@gmail.com>

#=======================
# ENV
#=======================
ENV DOCKER_IMAGE_NAME oddpoet/zookeeper
ENV DOCKER_IMAGE_TAG cdh5.2
ENV CDH_VER 5.2.0

#=======================
# Start services.
#=======================
COPY start.sh start.sh
ENTRYPOINT ["/bin/bash", "start.sh"]
