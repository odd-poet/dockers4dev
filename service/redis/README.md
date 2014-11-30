Redis
=================

- version: 2.8.17

Usage 
-------

You can see usage ``docker run oddpoet/redis -h``. 

```
$ docker run oddpoet/redis -h
###########################################################
         Redis Server 2.8.17
###########################################################

Usage: docker run DOCKER_OPTS oddpoet/redis OPTIONS

Environment:
  PORT=6379            redis service port

Options:
  -h,  --help          help message
  shell                execute shell. should run docker with '-i -t'. (service will not be started)

Example:
    docker run -d \
         -p 16379:6379 \
         -e PORT=6379 \
         oddpoet/redis
```

fig.yml
--------

```
redis:
  image: oddpoet/redis
  environment:
    - PORT=6379
  ports:
    - "6379"
```
