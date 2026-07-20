#!/bin/bash

export DISPLAY=:1

echo "Waiting for X server..."

until xdpyinfo -display :1 >/dev/null 2>&1
do
    sleep 1
done

echo "Starting x11vnc..."

exec x11vnc \
-display :1 \
-forever \
-shared \
-nopw \
-listen 0.0.0.0 \
-rfbport 5900 \
-noxdamage \
-repeat \
-xkb \
-o /tmp/x11vnc.log
