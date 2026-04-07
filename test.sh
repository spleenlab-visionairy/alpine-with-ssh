#!/bin/bash

# build the container
docker build --tag sshd .

# start the container and print the log
docker run -d --name sshd -p 2222:22 -v ${PWD}:/workdir -v ${HOME}/.ssh/id_rsa.pub:/tmp/authorized_keys:ro -e ADDITIONAL_PACKAGES="curl wget" sshd
sleep 1
docker logs sshd

# test ssh connect (please exit with 'exit' command)
ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" root@localhost -p 2222

# remove the container
docker rm -f sshd
