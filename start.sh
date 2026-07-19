#!/bin/bash

export DISPLAY=:1
export MOZ_ENABLE_WAYLAND=0
export MOZ_DISABLE_GPU_SANDBOX=1
export MOZ_WEBRENDER=0
export LIBGL_ALWAYS_SOFTWARE=1
export MOZ_USE_XINPUT2=1

mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix

Xvfb :1 -screen 0 720x1600x24 &
sleep 2

mkdir -p /run/dbus
dbus-daemon --system --fork

startxfce4 &
sleep 5

x11vnc \
-display :1 \
-forever \
-shared \
-nopw \
-listen 0.0.0.0 \
-rfbport 5900 \
-noxdamage \
-repeat \
-xkb \
-wait 10 &

/usr/sbin/sshd

websockify \
--web=/usr/share/novnc \
8080 \
localhost:5900 &

exec /usr/bin/supervisord -n
