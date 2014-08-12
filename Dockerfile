FROM ubuntu:12.04
MAINTAINER sameer@damagehead.com

ENV DEBIAN_FRONTEND noninteractive

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && \
		apt-get update && \
		dpkg-divert --local --rename --add /sbin/initctl && \
		ln -sf /bin/true /sbin/initctl && \
		dpkg-divert --local --rename --add /usr/bin/ischroot && \
		ln -sf /bin/true /usr/bin/ischroot && \
		dpkg-divert --local --rename --add /usr/bin/chfn && \
		ln -sf /bin/true /usr/bin/chfn && \
		apt-get install -y --no-install-recommends vim.tiny wget sudo net-tools pwgen unzip \
			logrotate supervisor language-pack-en python-software-properties && \
		locale-gen en_US && \
		apt-get clean # 20140804

ADD install /install
RUN chmod 755 /install
RUN /install && rm -rf /install
