FROM phusion/baseimage:0.9.15
MAINTAINER roberto@caro.ga

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# Set correct environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV HOME            /root
ENV LC_ALL          C.UTF-8
ENV LANG            en_US.UTF-8
ENV LANGUAGE        en_US.UTF-8

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Fix a Debianism of the nobody's uid being 65534
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody

#########################################
##  FILES, SERVICES AND CONFIGURATION  ##
#########################################

RUN apt-get -q update && \
    apt-get install -qy --force-yes python wget unrar git python-lxml && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN git clone git://github.com/RuudBurger/CouchPotatoServer.git /opt/couchpotato

RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

#########################################
##         EXPORTS AND VOLUMES         ##
#########################################

VOLUME ["/config"]

EXPOSE 5050

#########################################
##                 RUN                 ##
#########################################

CMD ["/start.sh"]