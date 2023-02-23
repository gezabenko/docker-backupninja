ARG IMAGE="ubuntu:18.04"
FROM ${IMAGE}

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"
ARG DEBCONF_TERSE="yes"
ARG APT="apt-get -qq -y"

RUN echo "debconf debconf/frontend select ${DEBIAN_FRONTEND}" | debconf-set-selections >/dev/null \
    && echo 'APT::Install-Recommends "false";' | tee /etc/apt/apt.conf.d/99install-recommends \
    && echo 'APT::Get::Assume-Yes "true";' | tee /etc/apt/apt.conf.d/99assume-yes \
    && sed -Ei 's|^(DPkg::Pre-Install-Pkgs .*)|#\1|g' /etc/apt/apt.conf.d/70debconf \
    && debconf-show debconf

RUN mv /etc/apt/apt.conf.d/70debconf . \
    && ${APT} update \
    && ${APT} install apt-utils >/dev/null \
    && mv 70debconf /etc/apt/apt.conf.d \
    && ${APT} upgrade >/dev/null

RUN ${APT} install --no-install-recommends \
    tzdata \
    backupninja \
    msmtp \
    rsync \
    openssh-client

RUN ${APT} autoremove \
    && ${APT} autoclean \
    && ${APT} clean \
    && rm -rf /var/lib/apt/lists/*

ENV TZ="Europe/Budapest"

RUN mkdir /backup

VOLUME ["/backup"]

ENTRYPOINT ["/usr/sbin/backupninja"]
CMD ["--help"]

