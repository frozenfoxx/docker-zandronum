#!/usr/bin/env bash

# Build the config files
export DISPLAY_HEIGHT
export DISPLAY_WIDTH
export PORT

envsubst < /etc/supervisor/conf.d/supervisord.conf.tmpl > /etc/supervisor/conf.d/supervisord.conf

# Run supervisor
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf &

# Wait until X11 is up
until pids=$(pidof Xvfb)
do   
  sleep 1
done

# Execute Zandronum
zandronum $@
