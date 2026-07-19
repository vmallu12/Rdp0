#!/bin/bash

export DISPLAY=:1

mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix

# Start virtual display
Xvfb :1 -screen 0 1920x1080x24 &
sleep 2

# Start D-Bus
mkdir -p /run/dbus
dbus-daemon --system --fork

# Start XFCE desktop
startxfce4 &

sleep 5

# Start VNC
x11vnc \
  -display :1 \
  -forever \
  -shared \
  -nopw \
  -listen 0.0.0.0 \
  -xkb \
  -rfbport 5900 &

# Start SSH
/usr/sbin/sshd

# Start noVNC
websockify \
  --web=/usr/share/novnc \
  8080 \
  localhost:5900 &

# Keep services running
exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
