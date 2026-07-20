FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    firefox-esr \
    x11vnc \
    xvfb \
    supervisor \
    novnc \
    websockify \
    openssh-server \
    dbus-x11 \
    xterm \
    sudo \
    wget \
    curl \
    nano \
    htop \
    net-tools \
    ca-certificates \
    procps \
    fonts-dejavu \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN echo "root:railway" | chpasswd

RUN mkdir -p \
    /var/run/sshd \
    /root/.vnc \
    /etc/supervisor/conf.d

COPY start.sh /start.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY index.html /usr/share/novnc/index.html

RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/start.sh"]
