FROM oddpoet/chronos-base:2.1.0
MAINTAINER yunsang.choi <oddpoet@gmail.com>

#=======================
# ENV
#=======================
ENV DOCKER_IMAGE_NAME oddpoet/chronos-local
ENV DOCKER_IMAGE_TAG 2.1.0
ENV CHRONOS_VERSION 2.1.0

#=======================
# Start services.
#=======================
COPY start.sh start.sh
ENTRYPOINT ["/bin/bash", "start.sh"]
