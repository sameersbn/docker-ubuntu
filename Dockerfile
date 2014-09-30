FROM ubuntu:12.04
MAINTAINER sameer@damagehead.com

ENV DEBIAN_FRONTEND noninteractive

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list \
 && echo "APT::Install-Recommends 0;" >> /etc/apt/apt.conf.d/01norecommends \
 && echo "APT::Install-Suggests 0;" >> /etc/apt/apt.conf.d/01norecommends \
 && apt-get update \
 && apt-get install -y vim.tiny wget sudo net-tools pwgen unzip \
      logrotate supervisor language-pack-en python-software-properties \
 && locale-gen en_US \
 && rm -rf /var/lib/apt/lists/* # 20140818

ADD install /install
RUN chmod 755 /install
RUN /install && rm -rf /install
