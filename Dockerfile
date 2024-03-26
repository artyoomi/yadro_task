############################################
# Dockerfile to build minimal poky image
############################################

FROM ubuntu:20.04
SHELL ["/bin/bash", "-c"]

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt --yes install \
    gawk wget git diffstat unzip texinfo gcc \
    build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils \
    iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev python3-subunit mesa-common-dev zstd liblz4-tool file locales libacl1 qemu && \
    locale-gen en_US.UTF-8

RUN groupadd --gid 1024 node \
    && adduser --uid 1024 --disabled-password --gecos "" --ingroup node node --home /home/node
#RUN mkdir /home/node/poky && chown node:node /home/node/poky/ && chmod g+s /home/node/poky/ && chmod 0777 /home/node/poky
USER node

WORKDIR /home/node

COPY --chown=node:node mode_selection.sh add_layer.sh entry.sh yadro_hello.c compile_instr.txt ./
CMD source entry.sh
