FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

RUN echo -en "###########################\n### Install packages... ###\n###########################"

RUN apt-get update && apt-get -qq -y upgrade
RUN apt-get install less vim wget curl p7zip-full backupninja rsync patch openssh-client mysql-client

RUN echo -en "###########################\n###    Clear env...     ###\n###########################"

RUN apt-get -qq -y autoremove && apt-get -qq -y autoclean && apt-get -qq -y clean && rm -rf /var/lib/apt/lists/*

RUN echo -en "###########################\n###    Copy files...    ###\n###########################"

COPY etc /etc
COPY backupninja /usr/share/backupninja

RUN echo -en "###########################\n###  Link ssh files...  ###\n###########################"

RUN ln -sf /etc/.ssh/config /root/.ssh/config && ln -sf /etc/.ssh/id_rsa /root/.ssh/id_rsa && ln -sf /etc/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub

VOLUME [ "/backup" ]

CMD [ "backupninja -n" ]

