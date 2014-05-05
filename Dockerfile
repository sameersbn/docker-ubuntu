FROM ubuntu:14.04
MAINTAINER sameer@damagehead.com

ENV DEBIAN_FRONTEND noninteractive

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && \
		apt-get update && \
		dpkg-divert --local --rename --add /sbin/initctl && \
		ln -sf /bin/true /sbin/initctl && \
		dpkg-divert --local --rename --add /usr/bin/ischroot && \
		ln -sf /bin/true /usr/bin/ischroot && \
		apt-get install -y vim curl wget sudo net-tools pwgen unzip \
			logrotate supervisor openssh-server language-pack-en && \
		locale-gen en_US && \
		apt-get clean # 20140418

ADD assets/ /app/
RUN mv /app/.vimrc /app/.bash_aliases /root/ && \
		mkdir -p /root/.ssh && touch /root/.ssh/authorized_keys && \
		chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys && chown root:root -R /root/.ssh && \
		chmod 755 /app/init /app/setup/install
RUN /app/setup/install

RUN sed 's/UsePAM yes/UsePAM no/' -i /etc/ssh/sshd_config && \
		sed 's/PermitRootLogin without-password/PermitRootLogin yes/' -i /etc/ssh/sshd_config

ADD authorized_keys /root/.ssh/

EXPOSE 22

ENTRYPOINT ["/app/init"]
CMD ["app:start"]
