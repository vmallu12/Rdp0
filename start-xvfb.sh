#!/bin/bash

export DISPLAY=:1

exec Xvfb :1 \
-screen 0 1280x720x24 \
-ac \
+extension GLX \
+render \
-noreset
