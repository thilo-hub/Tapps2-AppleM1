FROM rofrano/vagrant-provider:debian
MAINTAINER thilo-hub@nispuk.com
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update --fix-missing
RUN apt-get install -y zip xz-utils less libfreetype6 libglib2.0-0 libxxf86vm1 libgtk2.0-common
# TAP=tapps2-1.19.1-amd64-deb.zip
# test -r $TAP || wget https://www.ta.co.at/fileadmin/Downloads/Software/TAPPS2/Linux/64bit/tapps2-1.19.1-amd64-deb.zip
# unzip $TAP
RUN wget https://www.ta.co.at/fileadmin/Downloads/Software/TAPPS2/Linux/64bit/tapps2-1.19.1-amd64-deb.zip
RUN unzip tapps2-1.19.1-amd64-deb.zip

RUN apt-get install -y ./tapps2-1.19.1-amd64.deb
RUN rm ./tapps2-1.19.1*

# https://www.ta.co.at/en/downloads/file/16891701-winsol-64-bit-deb/winsol-2.13-amd64.deb.zip
ADD ./winsol-2.13-amd64.deb winsol-2.13-amd64.deb
RUN apt-get install -y ./winsol-2.13-amd64.deb
RUN rm ./winsol*.deb

## Start taps
# docker run -e DISPLAY=host.docker.internal:0
#ENV DISPLAY=host.docker.internal:0
RUN useradd Tapps2 -d /Work -p ""
RUN mkdir -p /Work/.local/share /run/sshd /Work/Files
RUN chown -R Tapps2 /Work
RUN touch /Work/.hushlogin

ADD ./sshd_config /etc/ssh/sshd_config
RUN /usr/sbin/sshd
ENTRYPOINT /usr/sbin/sshd -D
# ENTRYPOINT Tapps2 
