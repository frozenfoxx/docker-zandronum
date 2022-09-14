#!/usr/bin/env bash

# Build the config files
export DISPLAY_HEIGHT
export DISPLAY_WIDTH
export PORT

envsubst < /home/mpukgame/.config/zandronum/zandronum.ini.tmpl > /home/mpukgame/.config/zandronum/zandronum.ini
envsubst < /etc/supervisor/conf.d/supervisord.conf.tmpl > /home/mpukgame/supervisord.conf

# Run supervisor
/usr/bin/supervisord -c /home/mpukgame/supervisord.conf &

# Wait until X11 is up
until pids=$(pidof Xvfb)
do   
  sleep 1
done

# Execute Zandronum
zandronum $@
