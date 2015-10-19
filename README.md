Overview
========
These are docker containers to run

Prerequisites
=============

* docker
* docker-machine
* docker-compose

To install
----------
```sh
git clone git@github.com:aaronbbrown/docker_home.git
cd docker_home
git submodule update --init
cp common.env.sample common.env
```

Edit `common.env` to include configuration suitable for the environment.

To start
--------

```sh
./dm_run.sh # only necessary if using docker-machine
docker-compose -f tigh-docker-compose.yml build
docker-compose -f tigh-docker-compose.yml up
```
