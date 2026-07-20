FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV HOME=/root

RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    firefox-esr \
    xvfb \
    x11vnc \
    x11-utils \
    supervisor \
    novnc \
    websockify \
    openssh-server \
    dbus-x11 \
    sudo \
    wget \
    curl \
    nano \
    htop \
    net-tools \
    procps \
    ca-certificates \
    fonts-dejavu \
    xterm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN echo "root:railway" | chpasswd

RUN mkdir -p \
    /run/dbus \
    /var/run/sshd \
    /root/.vnc \
    /etc/supervisor/conf.d

COPY start.sh /start.sh
COPY start-xvfb.sh /start-xvfb.sh
COPY start-xfce.sh /start-xfce.sh
COPY start-vnc.sh /start-vnc.sh
COPY start-novnc.sh /start-novnc.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY index.html /usr/share/novnc/index.html

RUN chmod +x \
    /start.sh \
    /start-xvfb.sh \
    /start-xfce.sh \
    /start-vnc.sh \
    /start-novnc.sh

EXPOSE 8080

CMD ["/start.sh"]
