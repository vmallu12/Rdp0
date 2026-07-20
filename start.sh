#!/bin/bash
set -e

export DISPLAY=:1
export HOME=/root
export USER=root

# Firefox optimizations
export MOZ_ENABLE_WAYLAND=0
export MOZ_DISABLE_GPU_SANDBOX=1
export MOZ_WEBRENDER=0
export LIBGL_ALWAYS_SOFTWARE=1
export MOZ_USE_XINPUT2=1

mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix

mkdir -p /run/dbus
mkdir -p /var/run/sshd

# Start virtual display
Xvfb :1 \
-screen 0 1280x720x24 \
-ac \
+extension GLX \
+render \
-noreset &

sleep 2

# Start D-Bus
dbus-daemon --system --fork || true

# Start SSH
/usr/sbin/sshd

# Start XFCE
startxfce4 &

sleep 5

# Start VNC
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
-bg

# Start noVNC
websockify \
--web=/usr/share/novnc \
8080 \
localhost:5900 &

echo ""
echo "===================================="
echo " Railway Desktop Started"
echo "===================================="
echo "Open:"
echo "/vnc.html?autoconnect=1&resize=scale&quality=9&compression=9"
echo "===================================="
echo ""

# Start Supervisor
exec /usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
