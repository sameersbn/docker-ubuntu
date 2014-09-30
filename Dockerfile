FROM ubuntu:14.04
MAINTAINER sameer@damagehead.com

ENV DEBIAN_FRONTEND noninteractive

RUN echo "APT::Install-Recommends 0;" >> /etc/apt/apt.conf.d/01norecommends \
 && echo "APT::Install-Suggests 0;" >> /etc/apt/apt.conf.d/01norecommends \
 && apt-get update \
 && dpkg-divert --local --rename --add /sbin/initctl \
 && ln -sf /bin/true /sbin/initctl \
 && dpkg-divert --local --rename --add /usr/bin/ischroot \
 && ln -sf /bin/true /usr/bin/ischroot \
 && dpkg-divert --local --rename --add /usr/bin/chfn \
 && ln -sf /bin/true /usr/bin/chfn \
 && apt-get install -y vim.tiny wget sudo net-tools pwgen unzip \
      logrotate supervisor language-pack-en software-properties-common \
 && locale-gen en_US \
 && rm -rf /var/lib/apt/lists/* # 20140818

ADD install /install
RUN chmod 755 /install
RUN /install && rm -rf /install
