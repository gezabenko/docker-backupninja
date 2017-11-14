FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

RUN echo -en "###########################\n### Install packages... ###\n###########################\n"

RUN apt-get update && apt-get -qq -y upgrade
RUN apt-get -qq -y install wget backupninja rsync patch openssh-client mysql-client

RUN echo "###########################\n###    Clear env...     ###\n###########################\n"

RUN apt-get -qq -y autoremove && apt-get -qq -y autoclean && apt-get -qq -y clean && rm -rf /var/lib/apt/lists/*

RUN echo "###########################\n###    Copy files...    ###\n###########################\n"

COPY backupninja /usr/share/backupninja

RUN echo "###########################\n###   Link folders...   ###\n###########################\n"

RUN [ -d /config/.ssh ] && ln -sf /config/.ssh /root/.ssh
RUN [ -d /config/backup.d ] && ln -sf /config/backup.d /etc/backup.d

VOLUME [ "/config"]
VOLUME [ "/data" ]

CMD [ "backupninja -n -f /config/backupninja.conf" ]

