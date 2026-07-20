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

mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix

mkdir -p /run/dbus
mkdir -p /var/run/sshd

# Start D-Bus if not already running
dbus-daemon --system --fork || true

echo "======================================"
echo "Starting Railway Desktop..."
echo "======================================"

exec /usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
