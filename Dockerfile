ARG IMAGE="alpine:3.17"
FROM ${IMAGE}

RUN apk update && apk upgrade && \
    apk add --no-cache autoconf \
                       automake \
                       bash \
                       borgbackup \
                       cryptsetup \
                       duplicity \
                       flashrom \
                       gawk \
                       gzip \
                       hwinfo \
                       make \
                       msmtp \
                       openssh-client \
                       rdiff-backup \
                       restic \
                       rsync \
                       tar \
                       tzdata

ENV TZ=Europe/Budapest

RUN mkdir /usr/local/src

RUN wget -q "https://0xacab.org/liberate/backupninja/-/archive/backupninja-1.2.2/backupninja-backupninja-1.2.2.tar.gz" -O /usr/local/src/backupninja.tgz

RUN tar -xzf /usr/local/src/backupninja.tgz -C /usr/local/src/

WORKDIR "/usr/local/src/backupninja-backupninja-1.2.2/"

RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install

RUN mkdir /backup

VOLUME ["/backup"]

ENTRYPOINT ["/usr/local/sbin/backupninja"]
CMD ["--help"]
