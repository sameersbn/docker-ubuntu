FROM ubuntu:14.04
MAINTAINER sameer@damagehead.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
		dpkg-divert --local --rename --add /sbin/initctl && \
		ln -sf /bin/true /sbin/initctl && \
		dpkg-divert --local --rename --add /usr/bin/ischroot && \
		ln -sf /bin/true /usr/bin/ischroot && \
		apt-get install -y vim.tiny wget sudo net-tools pwgen unzip \
			logrotate supervisor language-pack-en software-properties-common && \
		locale-gen en_US && \
		apt-get clean # 20140519

ADD install /install
RUN chmod 755 /install
RUN /install && rm -rf /install
