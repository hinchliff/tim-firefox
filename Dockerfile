FROM centos:centos7

RUN yum update && \
    yum -y install \
        wget \
        bzip2 \
        firefox \
        gtk3 \
        alsa-lib \
        libcanberra-gtk3 \
        unzip && \
    yum -y remove firefox

RUN wget -nv https://ftp.mozilla.org/pub/firefox/releases/49.0.2/linux-x86_64/en-US/firefox-49.0.2.tar.bz2 && \
    tar jxf firefox-49.0.2.tar.bz2 -C /usr/local && \
    rm /firefox-49.0.2.tar.bz2 && \
    ln -s /usr/local/firefox/firefox /usr/bin/firefox && \
    mkdir /usr/local/firefox/plugins && \
    mkdir /usr/local/firefox/defaults/profile && \
    dbus-uuidgen >/etc/machine-id && \
    yum -y install http://linuxdownload.adobe.com/linux/x86_64/adobe-release-x86_64-1.0-1.noarch.rpm && \
    yum -y install flash-plugin && \
    yum clean all

    
ENV DISPLAY :0
ENV QT_X11_NO_MITSHM 1

#RUN mkdir -p /usr/local/firefox/browser/defaults/profile
#COPY ./resources/* /usr/local/firefox/browser/defaults/profile/
#COPY ./ca_files/* /
COPY ./resources/* /
RUN unzip autoconfig.zip -d /usr/local/firefox/

CMD /opt/firefox/firefox
