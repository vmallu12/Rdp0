FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV USER=root

RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
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
    bzip2 \
    libgtk-3-0 \
    libdbus-glib-1-2 \
    libasound2t64 \
    libx11-xcb1 \
    libxt6 \
    libxrender1 \
    libxrandr2 \
    libxdamage1 \
    libxfixes3 \
    libxcomposite1 \
    libxcb-shm0 \
    libxcb-render0 \
    libxcb1 \
    libnss3 \
    libnspr4 \
    fonts-dejavu \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install official Firefox (no Snap)
RUN wget -O /tmp/firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US" && \
    tar -xjf /tmp/firefox.tar.bz2 -C /opt && \
    ln -sf /opt/firefox/firefox /usr/local/bin/firefox && \
    rm /tmp/firefox.tar.bz2

RUN mkdir -p /var/run/sshd

RUN echo "root:railway" | chpasswd

RUN mkdir -p /root/.vnc

COPY start.sh /start.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/start.sh"]
