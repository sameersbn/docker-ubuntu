FROM ubuntu:12.04
MAINTAINER sameer@damagehead.com

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update # 20140310

# essentials
RUN apt-get install -y vim curl wget sudo net-tools pwgen && \
	apt-get install -y logrotate supervisor openssh-server && \
	apt-get clean

# build tools
# RUN apt-get install -y gcc make && apt-get clean

# image specific

ADD assets/ /ubuntu/
RUN chmod 755 /ubuntu/init /ubuntu/setup/install && /ubuntu/setup/install

ADD authorized_keys /root/.ssh/
RUN mv /ubuntu/.vimrc /ubuntu/.bash_aliases /root/
RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys && chown root:root -R /root

EXPOSE 22
ENTRYPOINT ["/ubuntu/init"]
CMD ["app:start"]
