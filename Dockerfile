FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -qq -y upgrade
RUN apt-get -qq -y --no-install-recommends install backupninja rsync openssh-client

RUN apt-get -qq -y autoremove && apt-get -qq -y autoclean && apt-get -qq -y clean && rm -rf /var/lib/apt/lists/*

ADD backupninja /usr/share/backupninja

VOLUME ["/config"]
VOLUME ["/backup"]

COPY ["docker_entrypoint.sh","/"]
COPY ["docker_entrypoint.d/*","/docker_entrypoint.d/"]
ENTRYPOINT ["/docker_entrypoint.sh","/usr/sbin/backupninja"]

CMD ["--help"]

