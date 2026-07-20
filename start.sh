#!/bin/bash

export DISPLAY=:1
export HOME=/root

# Firefox optimizations
export MOZ_ENABLE_WAYLAND=0
export MOZ_DISABLE_GPU_SANDBOX=1
export MOZ_WEBRENDER=0
export LIBGL_ALWAYS_SOFTWARE=1
export MOZ_USE_XINPUT2=1

mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix

# Virtual display (good for mobile)
Xvfb :1 -screen 0 1280x720x24 -ac +extension GLX +render -noreset &
sleep 2

# D-Bus
mkdir -p /run/dbus
dbus-daemon --system --fork

# XFCE
export DISPLAY=:1
startxfce4 &
sleep 5

# VNC
x11vnc \
-display :1 \
-forever \
-shared \
-nopw \
-rfbport 5900 \
-listen 0.0.0.0 \
-noxdamage \
-repeat \
-xkb \
-wait 10 \
-bg

# SSH
/usr/sbin/sshd

# noVNC
websockify \
--web=/usr/share/novnc \
8080 \
localhost:5900 &

echo "Desktop Started"
echo "Open:"
echo "https://YOUR-DOMAIN/vnc.html?autoconnect=1&resize=scale&quality=9&compression=9"

# Keep container alive
exec tail -f /dev/null
