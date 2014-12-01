Chronos
=================

- version: 2.1.0

Usage 
-------

You can see usage ``docker run oddpoet/chronos -h``. 

```
$ docker run oddpoet/chronos -h
###########################################################
         Chronos 2.1.0
###########################################################

Usage: docker run DOCKER_OPTS oddpoet/chronos:2.1.0 OPTIONS

Environment vars:
  PORT=8080                          service port
  MASTER=zk://localhost:2181/mesos   zookeeper url for mesos master.
                                     If you use default value, local zookeeper server will be start.
  ZK_HOSTS=localhost:2181            zookeeper server for storing state.
                                     If you use default value, local zookeeper server will be start.
  ZK_PATH=/chronos/state             path in zookeeper for storing state

Options:
  -h,  --help                        help message
  shell                              execute shell. should run docker with '-i -t'. (service will not be started)

Example:
    docker run -d \
         -p 8080:8080 \
         -e PORT=8080 \
         -e MATER=zk://zk-server:2181/mesos \
         -e ZK_HOSTS=zk-server:2181 \
         oddpoet/chronos:2.1.0
```

fig.yml
--------

```
master:
  image: oddpoet/mesos-master
  environment:
    - PORT=5050
  ports:
    - "5050:5050"
    - "2181:2181"
slave:
  image: oddpoet/mesos-slave
  environment:
    - PORT=5051
    - ZK_URL=zk://zookeeper:2181/mesos
  ports:
    - "5051:5051"
  links:
    - master:zookeeper
chronos:
  image: oddpoet/chronos
  environment:
    - PORT=8080
    - MASTER=zk://zookeeper:2181/mesos
    - ZK_HOSTS=zookeeper:2181
  ports:
    - "8080:8080"
  links:
    - master:zookeeper
```
