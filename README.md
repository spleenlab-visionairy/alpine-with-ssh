# alpine-with-ssh

container with openssh server and some utilities

## usage

* ssh-daemon allows login via public key only - you need to mount /tmp/authorized_keys
* use a custom host dir as workdir
* use a custom port for sshd

```
docker run --rm --name sshd -p 2222:22 -v ${PWD}:/workdir -v ${HOME}/.ssh/id_rsa.pub:/tmp/authorized_keys:ro sshd
```

## login

local login test

```
./test.sh
```
