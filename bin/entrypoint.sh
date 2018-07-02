#!/usr/bin/env bash

# Run supervisor
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf &

# Wait until X11 is up
until pids=$(pidof Xvfb)
do   
  sleep 1
done

# Execute Zandronum
zandronum $@
