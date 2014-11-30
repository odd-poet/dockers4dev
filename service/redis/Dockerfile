
FROM oddpoet/redis-base:2.8.17
MAINTAINER yunsang.choi <oddpoet@gmail.com>

#=======================
# ENV
#=======================
ENV DOCKER_IMAGE_NAME oddpoet/redis
ENV DOCKER_IMAGE_TAG 2.8.17
ENV REDIS_VERSION 2.8.17

#=======================
# Start services.
#=======================
COPY start.sh start.sh
ENTRYPOINT ["/bin/bash", "start.sh"]
