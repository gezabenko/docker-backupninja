FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

RUN echo -en "###########################\n### Install packages... ###\n###########################\n"

RUN apt-get update && apt-get -qq -y upgrade
RUN apt-get -qq -y --no-install-recommends install backupninja rsync openssh-client

RUN echo "###########################\n###    Clear env...     ###\n###########################\n"

RUN apt-get -qq -y autoremove && apt-get -qq -y autoclean && apt-get -qq -y clean && rm -rf /var/lib/apt/lists/*

RUN echo "###########################\n###    Copy files...    ###\n###########################\n"

COPY backupninja /usr/share/backupninja

RUN echo "###########################\n###   Link folders...   ###\n###########################\n"

RUN if [ -d /config/.ssh ]; then ln -sf /config/.ssh /root/.ssh; fi
RUN if [ -d /config/backup.d ]; then ln -sf /config/backup.d /etc/backup.d; fi

VOLUME [ "/config","/backup" ]

CMD [ "/usr/sbin/backupninja","-n","-f","/config/backupninja.conf" ]

