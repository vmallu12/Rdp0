#!/bin/bash

export DISPLAY=:1
export HOME=/root

# Wait until Xvfb is ready
until xdpyinfo -display :1 >/dev/null 2>&1
do
    sleep 1
done

exec startxfce4
