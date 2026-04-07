ARG BASE_IMAGE=alpine:3.23.3
FROM $BASE_IMAGE

# install typical utilities and openssh-server / openssl
RUN apk add --no-cache bash btop curl htop iotop ncdu openssh-server openssl nano rsync wget

# ssh default password for root (entrypoint will overwrite it)
RUN echo 'root:12345678' | chpasswd

# overwrite ssh config
COPY sshd_config /etc/ssh/sshd_config

# use bash and deactivate history
SHELL ["/bin/bash", "-c"]
RUN rm /bin/sh && ln -s /bin/bash /bin/sh && echo 'unset HISTFILE' >> /etc/profile.d/disable.history.sh

# use the entrypoint to handle ssh and users - this should not be static
WORKDIR /workdir
COPY entrypoint.sh /entry/entrypoint.sh
ENTRYPOINT ["/entry/entrypoint.sh"]
