FROM ubuntu:14.04
MAINTAINER sameer@damagehead.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
		dpkg-divert --local --rename --add /sbin/initctl && \
		ln -sf /bin/true /sbin/initctl && \
		dpkg-divert --local --rename --add /usr/bin/ischroot && \
		ln -sf /bin/true /usr/bin/ischroot && \
		apt-get install -y vim.tiny curl wget sudo net-tools pwgen unzip \
			logrotate supervisor language-pack-en software-properties-common && \
		locale-gen en_US && \
		apt-get clean # 20140519

ADD assets/ /app/
RUN mv /app/.vimrc /app/.bash_aliases /root/ && \
		chmod 755 /app/init /app/setup/install
RUN /app/setup/install

ENTRYPOINT ["/app/init"]
CMD ["app:start"]
