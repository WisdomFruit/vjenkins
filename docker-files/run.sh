#!/bin/bash

# yum commands
yum install net-tools -y && \

# docker commands
# jenkins network
docker network create vjenkins-net

# jenkins master
docker run --name vjenkins \
    --restart=on-failure \
    --detach \
    --network vjenkins-net \
    --env DOCKER_HOST=tcp://docker:2376 \
    --env DOCKER_CERT_PATH=/certs/client \
    --env DOCKER_TLS_VERIFY=1 \
    --privileged \
    --publish 8080:8080 \
    --publish 50000:50000 \
    --volume /vagrant/jenkins-home:/var/jenkins_home \
    --volume /vagrant/jenkins-docker-certs:/certs/client:ro \
    luckyjenkins-blueocean:2.387.1-1

# jenkins slave
docker run --name vnode \
    --detach \
    --restart=always \
    -p 127.0.0.1:2376:2375 \
    --network vjenkins-net \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    alpine/socat \
    tcp-listen:2375,fork,reuseaddr \
    unix-connect:/var/run/docker.sock

# change permissions
chown vagrant:vagrant /vagrant/jenkins* -R