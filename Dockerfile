FROM ubuntu:trusty
MAINTAINER Dudytz <dudytz@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# ensure locale is set during build
ENV LANG     en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL   en_US.UTF-8

# ensure locale is set for new logins
RUN echo     'LANG=en_US.UTF-8' >> '/etc/default/locale' \
 && echo 'LANGUAGE=en_US:en'    >> '/etc/default/locale' \
 && echo   'LC_ALL=en_US.UTF-8' >> '/etc/default/locale'

# enable backports repository
RUN sed -i "/^# *deb.*backports/ s/^# *//" /etc/apt/sources.list

# install additional packages
RUN echo "APT::Install-Recommends 0;" >> /etc/apt/apt.conf.d/01norecommends \
 && echo "APT::Install-Suggests 0;" >> /etc/apt/apt.conf.d/01norecommends \
 && apt-get update \
 && apt-get install -y vim wget curl sudo tree telnet htop iotop strace ca-certificates \
 && rm -rf /var/lib/apt/lists/*
