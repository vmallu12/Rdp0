FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV USER=root

RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    firefox \
    x11vnc \
    xvfb \
    supervisor \
    novnc \
    websockify \
    openssh-server \
    wget \
    curl \
    nano \
    htop \
    sudo \
    dbus-x11 \
    xterm \
    ca-certificates \
    net-tools \
    && apt-get clean

RUN mkdir -p /var/run/sshd

RUN echo "root:railway" | chpasswd

RUN mkdir -p /root/.vnc

COPY start.sh /start.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/start.sh"]
