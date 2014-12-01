
FROM oddpoet/storm-base:0.9.2
MAINTAINER yunsang.choi <oddpoet@gmail.com>

#=======================
# ENV
#=======================
ENV DOCKER_IMAGE_NAME oddpoet/storm-supervisor
ENV DOCKER_IMAGE_TAG 0.9.2
ENV STORM_VERSION 0.9.2

#=======================
# Start services.
#=======================
COPY start.sh start.sh
ENTRYPOINT ["/bin/bash", "start.sh"]
