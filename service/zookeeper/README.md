Zookeeper
=================

- version: 3.4.5+cdh5.2.0

Usage 
-------

You can see usage ``docker run oddpoet/zookeeper -h``. 

```
$ docker run oddpoet/zookeeper -h
###########################################################
         Zookeeper Server 3.4.5 (CDH-5.2.0)
###########################################################

Usage: docker run DOCKER_OPTS oddpoet/zookeeper OPTIONS

Environment vars:
  PORT=2181            zookeeper service port

Options:
  -h,  --help          help message
  shell                execute shell. should run docker with '-i -t'. (service will not be started)

Example:
    docker run -d \
         -p 2181:12181 \
         -e PORT=12181 \
         oddpoet/zookeeper
```

fig.yml
--------

```
zookeeper:
  image: oddpoet/zookeeper
  hostname: zk-server
  environment:
    - PORT=12181
  ports:
    - "2181:12181"
```
