FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

RUN echo -en "###########################\n### Install packages... ###\n###########################\n"

RUN apt-get update && apt-get -qq -y upgrade
RUN apt-get install wget backupninja rsync patch openssh-client mysql-client

RUN echo -en "###########################\n###    Clear env...     ###\n###########################\n"

RUN apt-get -qq -y autoremove && apt-get -qq -y autoclean && apt-get -qq -y clean && rm -rf /var/lib/apt/lists/*

RUN echo -en "###########################\n###    Copy files...    ###\n###########################\n"

COPY etc /etc
COPY backupninja /usr/share/backupninja

RUN echo -en "###########################\n###  Link ssh files...  ###\n###########################\n"

RUN ln -sf /etc/.ssh /root/.ssh

VOLUME [ "/backup" ]

CMD [ "backupninja -n" ]

