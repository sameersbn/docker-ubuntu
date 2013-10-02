FROM ubuntu:12.04
MAINTAINER sameer@damagehead.com

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y && apt-get clean # 20130925

RUN apt-get install -y bash-completion vim && apt-get clean

ADD resources/.bash_aliases /root/
ADD resources/.vimrc /root/
