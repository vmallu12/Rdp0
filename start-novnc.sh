#!/bin/bash

exec websockify \
--web=/usr/share/novnc \
8080 \
localhost:5900
